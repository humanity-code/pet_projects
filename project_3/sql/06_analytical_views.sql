create or replace view order_details_vw as 
select 
	o.order_id,
	o.order_datetime,
	date(o.order_datetime) as order_date,
	extract(hour from o.order_datetime) as order_hour,
	o.status,
	o.total_amount,
	o.payment_method,
	o.payment_status,
	
	c.customer_id,
	c.full_name as customer_name,
	c.registration_date,
	extract(day from o.order_datetime - c.registration_date) as days_since_registration,
	
	r.restaurant_id,
	r.name as restaurant_name,
	r.cuisine_type,
	r.rating as restaurant_rating,
	
	cr.courier_id,
	cr.full_name as courier_name,
	cr.vehicle_type,
	
	o.estimated_delivery,
	o.actual_delivery,
	extract(epoch from (o.actual_delivery - o.order_datetime))/60 as delivery_time_minutes,
	
	(select count(*) from order_items oi where oi.order_id = o.order_id) as items_count,
	(select sum(quantity) from order_items oi where oi.order_id = o.order_id) as total_items
	
from orders o 
join customers c on o.customer_id = c.customer_id 
join restaurants r on o.restaurant_id = r.restaurant_id 
left join couriers cr on o.courier_id = cr.courier_id 
where o.status = 'delivered';

create or replace view customer_analytics_vw as
select 
	c.customer_id,
	c.full_name,
	c.registration_date,
	c.delivery_address,
	count(o.order_id) as total_orders,
	sum(o.total_amount) as total_spent,
	avg(o.total_amount) as avg_order_value,
	min(o.order_datetime) as first_order_date,
	max(o.order_datetime) as last_order_date,
	extract(day from now() - max(o.order_datetime)) as dat_since_last_order
from customers c
left join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.full_name, c.registration_date, c.delivery_address

create or replace view dish_analytics_vw as
select
	d.dish_id,
	d.name as dish_name,
	d.category,
	d.price,
	d.is_available,
	
	r.restaurant_id,
	r.name as restaurant_name,
	r.cuisine_type,
	
	count(oi.order_item_id) as times_ordered,
	sum(oi.quantity) as total_quantity_sold,
	sum(oi.quantity * oi.price_at_order) as total_revenue,
	
	(select avg(rating)
	 from reviews rev
	 join orders ord on rev.order_id = ord.order_id
	 join order_items oi2 on ord.order_id = oi2.order_id
	 where oi2.dish_id = d.dish_id) as avg_rating,
		
	(select count(*)
	 from order_items oi2
	 join orders o2 on oi2.order_id = o2.order_id
	 where oi2.dish_id = d.dish_id
	 	and extract(hour from o2.order_datetime) between 12 and 16) as lunch_orders,
	 	
	 (select count(*)
	 from order_items oi2
	 join orders o2 on oi2.order_id = o2.order_id
	 where oi2.dish_id = d.dish_id
	 	and extract(hour from o2.order_datetime) between 18 and 22) as dinner_orders
	 	
from dishes d
join restaurants r on d.restaurant_id = r.restaurant_id 
left join order_items oi on d.dish_id = oi.dish_id 
group by d.dish_id, d.name, d.category, d.price, d.is_available, r.restaurant_id, r.name, r.cuisine_type