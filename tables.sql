DROP TABLE IF EXISTS clients;
CREATE TABLE clients
(
    client_id  INTEGER PRIMARY KEY,
    first_name TEXT    NOT NULL,
    last_name  TEXT    NOT NULL,
    mobile     TEXT    NOT NULL,
    region_id  INTEGER NOT NULL,
    address    TEXT
);
DROP TABLE IF EXISTS products;
CREATE TABLE products
(
    product_id        INTEGER PRIMARY KEY,
    product_name      TEXT  NOT NULL,
    manufacturer_name TEXT  NOT NULL,
    price             FLOAT NOT NULL
);

DROP TABLE IF EXISTS orders;
CREATE TABLE orders
(
    order_id     INTEGER PRIMARY KEY,
    order_number TEXT      NOT NULL,
    placed_date  TIMESTAMP NOT NULL,
    total        FLOAT     NOT NULL,
    client_id    INTEGER   NOT NULL
);

DROP TABLE IF EXISTS orders_items;
CREATE TABLE orders_items
(
    order_id   INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    price      FLOAT   NOT NULL
);

DROP TABLE IF EXISTS shipments;
CREATE TABLE shipments
(
    shipment_id    INTEGER PRIMARY KEY,
    order_id       INTEGER   NOT NULL,
    date_shipped   TIMESTAMP NOT NULL,
    date_delivered TIMESTAMP NULL,
    driver_name    TEXT      NOT NULL,
    driver_rating  INTEGER
);
