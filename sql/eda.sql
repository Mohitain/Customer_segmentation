SELECT * FROM ecommerce.customers;
SELECT * FROM ecommerce.products;
SELECT * FROM ecommerce.sellers;
SELECT * FROM ecommerce.orders;
SELECT * FROM ecommerce.order_items;
SELECT * FROM ecommerce.payments;
SELECT * FROM ecommerce.reviews;
SELECT * FROM ecommerce.geolocation;
SELECT * FROM ecommerce.category_translation;

--Who are the highest-value customers?

select distinct order_status
from ecommerce.orders 


select c.customer_unique_id,
	sum(payment_value) as revenue_per_customer
from ecommerce.customers c
join ecommerce.orders o
	on c.customer_id = o.customer_id
join ecommerce.payments p
	on o.order_id = p.order_id
where o.order_status = 'delivered'
group by c.customer_unique_id 
order by revenue_per_customer desc
limit 10;

--Which customers are likely to stop purchasing?

with recency as (
select c.customer_unique_id,
	max(o.order_purchase_timestamp)::date as last_orders
from ecommerce.customers c
join ecommerce.orders o
	on c.customer_id = o.customer_id
group by c.customer_unique_id
),
curr_date as (
select * ,
	max(last_orders) over() as max_date
from recency
),
last_purchase as (
select *,
	max_date-last_orders as date_diff
from curr_date
order by date_diff asc
)
select *,
	case
		when date_diff between 0 and 30 then 'Active'
		when date_diff between 31 and 90 then 'At_Risk'
		when date_diff<=120 then 'Most_likely_leave'
		else 'Churned'
	end as chur_category
from last_purchase



