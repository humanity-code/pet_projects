create or replace procedure create_order_with_items(
    p_customer_id INTEGER,
    p_restaurant_id INTEGER,
    p_delivery_address TEXT,
    p_items JSONB
)
language plpgsql
as $$
declare 
	v_order_id INTEGER;
	v_item JSONB;
begin
	insert into orders (customer_id, restaurant_id, delivery_address, status)
    values (p_customer_id, p_restaurant_id, p_delivery_address, 'created')
    returning order_id into v_order_id;

	for v_item in select * from jsonb_array_elements(p_items)
	loop 
		insert into order_items (order_id, dish_id, quantity, price_at_order)
        values (
			v_order_id,
            (v_item->>'dish_id')::INTEGER,
            (v_item->>'quantity')::INTEGER,
            (select price from dishes where dish_id = (v_item->>'dish_id')::INTEGER)
        );
	end loop;
    
exception
    when others then
        raise notice 'Ошибка создания заказа: %', sqlerrm;
        raise;
end $$;
