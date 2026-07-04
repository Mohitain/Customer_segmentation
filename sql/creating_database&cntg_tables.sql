SELECT * FROM ecommerce.customers;
SELECT * FROM ecommerce.products;
SELECT * FROM ecommerce.sellers;
SELECT * FROM ecommerce.orders;
SELECT * FROM ecommerce.order_items;
SELECT * FROM ecommerce.payments;
SELECT * FROM ecommerce.reviews;
SELECT * FROM ecommerce.geolocation;
SELECT * FROM ecommerce.category_translation;

-- Customers

DROP TABLE IF EXISTS ecommerce.customers CASCADE;

CREATE TABLE ecommerce.customers (
    customer_id VARCHAR(255) PRIMARY KEY,
    customer_unique_id VARCHAR(255),
    customer_zip_code_prefix INT,
    customer_city VARCHAR(50),
    customer_state VARCHAR(10)
);

-- Products

DROP TABLE IF EXISTS ecommerce.products CASCADE;

CREATE TABLE ecommerce.products (
    product_id VARCHAR(255) PRIMARY KEY,
    product_category_name VARCHAR(255),
    product_name_length INT,
    product_description_length INT,
    product_photos_qty INT,
    product_weight_g INT,
    product_length_cm NUMERIC(10,2),
    product_height_cm NUMERIC(10,2),
    product_width_cm NUMERIC(10,2)
);

-- Sellers

DROP TABLE IF EXISTS ecommerce.sellers CASCADE;

CREATE TABLE ecommerce.sellers (
    seller_id VARCHAR(255) PRIMARY KEY,
    seller_zip_code_prefix INT,
    seller_city VARCHAR(50),
    seller_state VARCHAR(10)
);

-- Orders

DROP TABLE IF EXISTS ecommerce.orders CASCADE;

CREATE TABLE ecommerce.orders (
    order_id VARCHAR(255) PRIMARY KEY,
    customer_id VARCHAR(255),
    order_status VARCHAR(100),
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP,

    CONSTRAINT orders_customer_fk
        FOREIGN KEY (customer_id)
        REFERENCES ecommerce.customers(customer_id)
);

-- Order Items

DROP TABLE IF EXISTS ecommerce.order_items CASCADE;

CREATE TABLE ecommerce.order_items (
    order_id VARCHAR(255),
    order_item_id INT,
    product_id VARCHAR(255),
    seller_id VARCHAR(255),
    shipping_limit_date TIMESTAMP,
    price NUMERIC(10,2),
    freight_value NUMERIC(10,2),

    CONSTRAINT order_items_pk
        PRIMARY KEY (order_id, order_item_id),

    CONSTRAINT order_items_order_fk
        FOREIGN KEY (order_id)
        REFERENCES ecommerce.orders(order_id),

    CONSTRAINT order_items_product_fk
        FOREIGN KEY (product_id)
        REFERENCES ecommerce.products(product_id),

    CONSTRAINT order_items_seller_fk
        FOREIGN KEY (seller_id)
        REFERENCES ecommerce.sellers(seller_id)
);

-- Payments

DROP TABLE IF EXISTS ecommerce.payments CASCADE;

CREATE TABLE ecommerce.payments (
    order_id VARCHAR(255),
    payment_sequential INT,
    payment_type VARCHAR(50),
    payment_installments INT,
    payment_value NUMERIC(10,2),

    CONSTRAINT payments_pk
        PRIMARY KEY (order_id, payment_sequential),

    CONSTRAINT payments_order_fk
        FOREIGN KEY (order_id)
        REFERENCES ecommerce.orders(order_id)
);

-- Reviews

DROP TABLE IF EXISTS ecommerce.reviews CASCADE;

CREATE TABLE ecommerce.reviews (
    review_id VARCHAR(255),
    order_id VARCHAR(255),
    review_score INT,
    review_comment_title VARCHAR(255),
    review_comment_message TEXT,
    review_creation_date TIMESTAMP,
    review_answer_timestamp TIMESTAMP,

    CONSTRAINT reviews_pk
        PRIMARY KEY (review_id, order_id),

    CONSTRAINT reviews_order_fk
        FOREIGN KEY (order_id)
        REFERENCES ecommerce.orders(order_id)
);

-- Geolocation

DROP TABLE IF EXISTS ecommerce.geolocation CASCADE;

CREATE TABLE ecommerce.geolocation (
    geolocation_zip_code_prefix INT PRIMARY KEY,
    geolocation_lat NUMERIC(10,6),
    geolocation_lng NUMERIC(10,6),
    geolocation_city VARCHAR(50),
    geolocation_state VARCHAR(10)
);

ALTER TABLE ecommerce.geolocation
DROP CONSTRAINT geolocation_pkey;

-- Category Translation

DROP TABLE IF EXISTS ecommerce.category_translation CASCADE;

CREATE TABLE ecommerce.category_translation (
    product_category_name VARCHAR(255) PRIMARY KEY,
    product_category_name_english VARCHAR(255)
);
