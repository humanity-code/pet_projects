with dish_combinations as (
	select
		oi1.dish_id as dish_1,
		oi2.dish_id as dish_2,
		count(distinct oi1.order_id) as times_ordered_together,
		d1.name as dish_1_name,
		d2.name as dish_2_name,
		d1.category as dish_1_category,
		d2.category as dish_2_category
	from order_items oi1
	join order_items oi2 on oi1.order_id = oi2.order_id and oi1.dish_id < oi2.dish_id
	join dishes d1 on oi1.dish_id = d1.dish_id
    join dishes d2 on oi2.dish_id = d2.dish_id
    group by oi1.dish_id, oi2.dish_id, d1.name, d2.name, d1.category, d2.category, d1.restaurant_id, d2.restaurant_id
    having count(distinct oi1.order_id) >= 3
),
combination_rank as (
	select
		*,
		rank() over(partition by dish_1_category order by times_ordered_together desc) as rank_in_category
	from dish_combinations
)
select
	dish_1_name,
	dish_2_name,
	dish_1_category,
	dish_2_category,
	times_ordered_together,
	rank_in_category
from combination_rank
where rank_in_category <= 5
order by dish_1_category, rank_in_category