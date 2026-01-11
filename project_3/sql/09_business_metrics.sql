with daily_metrics as (
	select 
		date(o.order_datetime) as report_date,
		
		count(distinct o.order_id) as total_orders,
		sum(o.total_amount) as total_revenue,
		avg(o.total_amount) as average_revenue,
		count(distinct o.customer_id) as unique_customers,
		
		avg(extract(epoch from (o.actual_delivery - o.order_datetime))/60) as avg_delivery_time,
		sum(case when o.actual_delivery > o.estimated_delivery then 1 else 0 end) as late_deliveries,
		
		count(distinct o.restaurant_id) as active_restaurants,
		
		count(distinct o.courier_id) as active_couriers
		
	from orders o
	left join couriers cr on o.courier_id = cr.courier_id
	where o.status = 'delivered'
	group by date(o.order_datetime)
)
select
	*,
	total_revenue - lag(total_revenue) over(order by report_date) as revenue_growth,
    total_orders - lag(total_orders) over(order by report_date) as orders_growth,
    round(
        (total_revenue - lag(total_revenue) over(order by report_date)) * 100.0 / 
        nullif(lag(total_revenue) over(order by report_date), 0), 
        2
    ) as revenue_growth_percent
from daily_metrics