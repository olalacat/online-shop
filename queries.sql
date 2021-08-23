--1.

SELECT DISTINCT clients.client_id, first_name, last_name
FROM clients
         INNER JOIN orders
                    ON clients.client_id = orders.client_id
         INNER JOIN orders_items oi ON orders.order_id = oi.order_id
         INNER JOIN products p ON oi.product_id = p.product_id
WHERE placed_date BETWEEN '2018-01-01'
    AND '2018-01-02'
  AND p.product_name =
      'X'
  AND p.manufacturer_name = 'Y';

--2.
WITH valuable_clients AS
         (SELECT orders.client_id, SUM(total) AS client_spent
          FROM clients
                   INNER JOIN orders
                              ON clients.client_id = orders.client_id
          WHERE clients.first_name = 'Иван'
            AND placed_date BETWEEN '2018-01-01' AND '2018-01-02'
         ),
     interesting_orders AS (
         SELECT client_id,
                orders.order_id,
                order_number,
                COUNT(CASE product_name WHEN 'X' THEN 1 END) AS count_x,
                COUNT(CASE product_name WHEN 'Y' THEN 1 END) AS count_y
         FROM orders
                  INNER JOIN orders_items
                             ON orders.order_id = orders_items.order_id
                  INNER JOIN products
                             ON orders_items.product_id = products.product_id
         GROUP BY 1, 2, 3
     )
SELECT order_id, order_number
FROM valuable_clients
         INNER JOIN interesting_orders
                    ON interesting_orders.client_id = valuable_clients.client_id
WHERE client_spent >= 10000
  AND count_x = 0
  AND count_y > 0;

--3.
WITH top_regions AS (
    SELECT region_id, SUM(total)
    FROM clients
             INNER JOIN orders o ON clients.client_id = o.client_id
    GROUP BY 1
    ORDER BY 2 DESC
    LIMIT 3
),
     orders_in_last_6m AS (
         SELECT client_id, COUNT(*) AS orders_in_last_6m_count
         FROM orders
         WHERE placed_date BETWEEN
                   NOW() - INTERVAL '6 month' AND
                   NOW()
         GROUP BY 1
     ),
     spent_last_year AS (
         SELECT client_id, SUM(total) AS spend_6m
         FROM orders
         WHERE placed_date BETWEEN
                   NOW() - INTERVAL '18 month' AND
                   NOW() - INTERVAL '12 month'
         GROUP BY 1
     )
SELECT clients.client_id, first_name, last_name
FROM clients
         LEFT OUTER JOIN orders_in_last_6m
                         ON clients.client_id = orders_in_last_6m.client_id
         INNER JOIN spent_last_year
                    ON spent_last_year.client_id = clients.client_id
WHERE region_id IN (SELECT region_id FROM top_regions)
  AND orders_in_last_6m_count IS NULL
  AND spend_6m > (SELECT AVG(spend_6m) FROM spent_last_year);


-- 4

WITH spent AS
         (
             SELECT orders.client_id, SUM(total) AS client_spend
             FROM orders
             GROUP BY 1
         ),
     reviews AS (
         SELECT driver_name, AVG(driver_rating) AS avg_rating
         FROM shipments
         WHERE date_delivered > DATE_TRUNC('month', NOW())
         GROUP BY 1
     )
SELECT orders.order_id, order_number
FROM orders
         INNER JOIN spent
                    ON orders.client_id = spent.client_id
         INNER JOIN shipments
                    ON orders.order_id = shipments.order_id
         INNER JOIN reviews
                    ON reviews.driver_name = shipments.driver_name
WHERE date_delivered > DATE_TRUNC('week', NOW())
  AND client_spend > (SELECT AVG(client_spend) FROM spent)
  AND avg_rating < (SELECT AVG(avg_rating) FROM reviews);
