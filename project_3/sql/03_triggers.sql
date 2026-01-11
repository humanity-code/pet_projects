create or replace function update_order_total()
returns TRIGGER as $$
begin
    update orders 
    set total_amount = (
        select COALESCE(SUM(quantity * price_at_order), 0)
        from order_items 
        where order_id = COALESCE(NEW.order_id, OLD.order_id)
    )
    where order_id = COALESCE(NEW.order_id, OLD.order_id);
    
    return NEW;
end;
$$ language plpgsql;

create trigger trig_update_order_total_insert
after insert on order_items
for each row execute function update_order_total();

create trigger trig_update_order_total_update
after update on order_items
for each row execute function update_order_total();

create trigger trig_update_order_total_delete
after delete on order_items
for each row execute function update_order_total();

create or replace function set_price_at_order()
returns trigger as $$
begin
	declare
		current_price DECIMAL;
	begin
		select price into current_price
 		from dishes 
		where dish_id = new.dish_id;

		if new.price_at_order is null
			or new.price_at_order = 0 
			or new.price_at_order != current_price then
			 new.price_at_order := current_price;
		end if;
	end;

	return new;
end;
$$ language plpgsql;

create trigger trig_set_price_at_order
before insert on order_items
for each row execute function set_price_at_order();

create or replace function check_dish_availability()
returns trigger as $$
declare
	dish_available BOOLEAN;
	dish_restaurant_id INTEGER;
	order_restaurant_id INTEGER;
begin
	select is_available, restaurant_id
	into dish_available, dish_restaurant_id
	from dishes
	where dish_id = new.dish_id;
	
	select restaurant_id
	into order_restaurant_id
	from orders
	where order_id = new.order_id;
	
	if not dish_available then 
		raise exception 'Блюдо с ID % недоступно для заказа', new.dish_id;
	end if;
	
	if dish_restaurant_id != order_restaurant_id then
		raise exception 'Блюдо с ID % не принадлежит ресторану заказа', new.dish_id;
    end if;
	
	return new;
end;
$$ language plpgsql;

create trigger trig_check_dish_availability
before insert or update on order_items
for each row execute function check_dish_availability();

create or replace function update_restaurants_rating()
returns trigger as $$
begin
	update restaurants r
	set rating = (
		select round(avg(rv.rating), 2)
		from orders o
		join reviews rv on o.order_id = rv.order_id
		where o.restaurant_id = r.restaurant_id
	)
	where restaurant_id = (
		select restaurant_id
		from orders
		where order_id = new.order_id
	);

	return new;
end;
$$ language plpgsql;

create trigger trig_update_restaurants_rating
after insert or update or delete on reviews
for each row execute function update_restaurants_rating();

create or replace function validate_view_order()
returns trigger as $$
declare 
	order_status VARCHAR(50);
begin
	select status into order_status
	from orders
	where order_id = new.order_id;

	if order_status != 'delivered' then
		raise exception 'Отзыв можно оставить только на доставленный заказ. Текущий статус: %', order_status;
	end if;
	
	return new;
end;
$$ language plpgsql;

create trigger trig_validate_review_order
before insert on reviews
for each row execute function validate_view_order();

create or replace function assign_available_courier()
returns trigger as $$
declare 
	available_courier_id INTEGER;
begin 
	if new.courier_id is null and new.status = 'ready' then
		select courier_id into available_courier_id 
		from couriers 
		where is_available = true 
		order by random()
		limit 1;
	
		if available_courier_id is not null then
			new.courier_id := available_courier_id;
		
			update couriers 
            set is_available = false 
            where courier_id = available_courier_id;
		end if;
	end if;
		
	return new;
end;
$$ language plpgsql;

create trigger trig_assign_available_courier
before update on orders
for each row execute function assign_available_courier();

create or replace function free_courier_after_delivery()
returns trigger as $$
begin
	if new.status = 'delivered' and old.status != 'delivered' and new.courier_id is not null then
		update couriers 
		set is_available = true
		where courier_id = new.courier_id;
	
		if new.actual_delivery is null then
			new.actual_delivery := current_timestamp;
		end if;
	end if;
		
	return new;
end;
$$ language plpgsql;

create trigger trig_free_courier_after_delivery
before update on orders
for each row execute function free_courier_after_delivery();