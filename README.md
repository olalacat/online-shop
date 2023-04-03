# online-shop
1) The structure of the internet store database tables.sql for PostgreSQL.

2) Queries queries.sql:

- Query 1
```
Goal: List of customers (full name).
Condition: Made orders during the period from 01.01.18 to 02.01.18.
Orders contained product X from manufacturer Y.

``` 
- Query 2
```
Goal: List of orders from customers with the name Ivan.
Condition: Made orders during the period from 01.01.18 to 02.01.18.
Total amount of orders from customers during the period is greater than or equal to 10,000 rubles.
Orders did not contain product X, but contained product Y.

``` 
- Query 3
```
Goal: List of customers who have not made purchases for 6 months.
Conditions: Customers who had above-average turnover in a similar period last year.
These customers are from the top 3 regions in terms of sales.

```
- Query 4
```
Goal: List of orders with conditionally problematic deliveries.
Condition: Delivery was made this week by drivers with poor feedback from customers for the current month.
These customers are high-income for the entire period of operation.

```
