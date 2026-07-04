SELECT * FROM ecommerce.customers;
SELECT * FROM ecommerce.products;
SELECT * FROM ecommerce.sellers;
SELECT * FROM ecommerce.orders;
SELECT * FROM ecommerce.order_items;
SELECT * FROM ecommerce.payments;
SELECT * FROM ecommerce.reviews;
SELECT * FROM ecommerce.geolocation;
SELECT * FROM ecommerce.category_translation;

--checking nulls in columns in customers
SELECT *
FROM ecommerce.customers
WHERE customer_unique_id IS NULL;

SELECT *
FROM ecommerce.customers
WHERE customer_city IS NULL;

--duplicates check
SELECT customer_unique_id,count(*)
FROM ecommerce.customers
GROUP BY customer_unique_id
HAVING COUNT(*)>=2;

--checking nulls in columns in products 
SELECT COUNT(*) AS nul_count
FROM ecommerce.products
WHERE product_category_name IS NULL;

SELECT *
FROM ecommerce.products
WHERE product_category_name IS NULL-----in this there are nulls we will keep it as unknown category later

--cheking nulls in sellers
SELECT COUNT(*)
FROM ecommerce.sellers
WHERE seller_city is null

--checking nulls in orders

SELECT COUNT(*) as null_count
FROM ecommerce.orders
WHERE customer_Id IS NULL

SELECT COUNT(*) 
FROM ecommerce.orders
WHERE order_status IS NULL

SELECT count(*)
FROM ecommerce.orders
WHERE order_purchase_timestamp>order_delivered_carrier_date-----ERROR purchase date cant be greater than carrier date order can only be sent to the carrier after i purchase 

SELECT *
FROM ecommerce.orders
WHERE order_purchase_timestamp>order_delivered_carrier_date;

SELECT *
FROM ecommerce.orders
where order_purchase_timestamp>order_delivered_customer_date

SELECT *
FROM ecommerce.orders
where order_delivered_customer_date is null and order_status = 'delivered';--some order has status as delivered but thier si delivere dat is null measn they havent got the orer yet

-- checking nulls in order_items;

SELECT * FROM ecommerce.order_items;

SELECT * 
FROM ecommerce.order_items 
where order_item_id is null;

SELECT * 
FROM ecommerce.order_items 
where product_id is null;

SELECT * 
FROM ecommerce.order_items 
where seller_id is null;

SELECT * 
FROM ecommerce.order_items 
where price is null;

SELECT * 
FROM ecommerce.order_items 
where freight_value is null;

--checking nulls in payments;

SELECT * FROM ecommerce.payments;

SELECT DISTINCT payment_type
FROM ecommerce.payments;

SELECT * 
FROM ecommerce.payments
where payment_type is null;

SELECT * 
FROM ecommerce.payments
where payment_installments is null;

SELECT * 
FROM ecommerce.payments
where payment_value is null;

SELECT  order_id,payment_sequential,count(*)
FROM ecommerce.payments
group by order_id,payment_sequential
HAVING COUNT(*)>1

SELECT order_id,count(*) 
from ecommerce.payments
group by order_id
having count(*)>1;

select distinct(payment_type)
from ecommerce.payments;



--checking nulls in reviews;
SELECT * FROM ecommerce.reviews;

SELECT DISTINCT review_score FROM ecommerce.reviews;

SELECT * 
FROM ecommerce.reviews
where review_score is null;

SELECT * 
FROM ecommerce.reviews
where review_creation_date is null;

SELECT * 
FROM ecommerce.reviews
where review_answer_timestamp is null;

--checking nulls in geolocation

SELECT * FROM ecommerce.geolocation;

