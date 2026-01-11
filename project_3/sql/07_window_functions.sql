with restaurant_dish_rank as (
	select 
		r.name as restaurant_name,
		d.name as dish_name,
		d.category,
		sum(oi.quantity) as total_sold,
		sum(oi.quantity * oi.price_at_order) as total_revenue,
		dense_rank() over(partition by r.restaurant_id order by sum(oi.quantity) desc) as rank_by_quantity,
		dense_rank() over(partition by r.restaurant_id order by sum(oi.quantity * oi.price_at_order) desc) as rank_by_revenue,
		row_number() over(partition by r.restaurant_id, d.category order by sum(oi.quantity) desc) as rank_in_category
	from dishes d
	join restaurants r on d.restaurant_id = r.restaurant_id
    join order_items oi on d.dish_id = oi.dish_id
    join orders o on oi.order_id = o.order_id
    where o.status = 'delivered'
    group by r.restaurant_id, r.name, d.dish_id, d.name, d.category
)
select * 
from restaurant_dish_rank
where rank_by_quantity <= 3
order by restaurant_name, rank_by_quantity;

with daily_revenue as (
	select
		date(order_datetime) as order_date,
		sum(total_amount) as daily_revenue,
		count(distinct order_id) as daily_orders,
		avg(total_amount) as avg_order_value
	from orders
	where status = 'delivered'
	group by date(order_datetime)
)
select 
	order_date,
	daily_revenue,
	daily_orders,
	avg_order_value,
	
	avg(daily_revenue) over (
		order by order_date
		rows between 6 preceding and current row
	) as revenue_7day_avg,
	
	sum(daily_revenue) over(
		order by order_date
		rows between unbounded preceding and current row
	) as cumulative_revenue,
	
	daily_revenue * 100.0 / sum(daily_revenue) over() as revenue_percentage,
    
    daily_revenue - lag(daily_revenue, 1) over(order by order_date) as revenue_change,
    
    round(
        (daily_revenue - lag(daily_revenue, 1) over(order by order_date)) * 100.0 / 
        lag(daily_revenue, 1) over(order by order_date), 
        2
    ) as revenue_change_percent
    
from daily_revenue
order by order_date;