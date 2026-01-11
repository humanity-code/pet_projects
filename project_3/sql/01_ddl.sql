CREATE TABLE customers (
	customer_id SERIAL PRIMARY KEY,
	full_name VARCHAR(100) NOT NULL,
	phone_number VARCHAR(20) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE,
    registration_date DATE DEFAULT CURRENT_DATE NOT NULL,
    delivery_address TEXT NOT NULL
);

COMMENT ON TABLE customers IS 'Таблица клиентов службы доставки';
COMMENT ON COLUMN customers.customer_id IS 'Уникальный идентификатор клиента';
COMMENT ON COLUMN customers.phone_number IS 'Уникальный номер телефона для входа';
COMMENT ON COLUMN customers.delivery_address IS 'Адрес доставки по умолчанию';

CREATE TABLE restaurants (
	restaurant_id SERIAL PRIMARY KEY,
	name VARCHAR(200) NOT NULL,
	cuisine_type VARCHAR(50) NOT NULL,
    address TEXT NOT NULL,
    is_active BOOLEAN DEFAULT true,
    rating DECIMAL(3,2) CHECK (rating >= 1 AND rating <= 5)
);

COMMENT ON TABLE restaurants IS 'Таблица ресторанов-партнеров';
COMMENT ON COLUMN restaurants.cuisine_type IS 'Тип кухни: Итальянская, Азиатская, и т.д.';
COMMENT ON COLUMN restaurants.rating IS 'Средний рейтинг от клиентов (0-5)';

CREATE TABLE couriers (
    courier_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(20) UNIQUE NOT NULL,
    vehicle_type VARCHAR(50) NOT NULL,
    is_available BOOLEAN DEFAULT TRUE
);

COMMENT ON TABLE couriers IS 'Таблица курьеров';
COMMENT ON COLUMN couriers.vehicle_type IS 'Тип транспорта: пеший, велосипед, авто, электросамокат';
COMMENT ON COLUMN couriers.is_available IS 'Флаг доступности для новых заказов';

CREATE TABLE dishes (
    dish_id SERIAL PRIMARY KEY,
    restaurant_id INTEGER NOT null,
    name VARCHAR(200) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL CHECK (price > 0),
    is_available BOOLEAN DEFAULT TRUE,
    category VARCHAR(100),
    
    CONSTRAINT fk_dishes_restaurants 
    	FOREIGN KEY (restaurant_id) 
    	REFERENCES restaurants(restaurant_id)
    	ON DELETE CASCADE
);

COMMENT ON TABLE dishes IS 'Меню ресторанов';
COMMENT ON COLUMN dishes.price IS 'Текущая цена блюда';
COMMENT ON COLUMN dishes.category IS 'Категория: закуска, основное, десерт, напиток';

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    restaurant_id INTEGER NOT NULL,
    courier_id INTEGER,
    status VARCHAR(50) NOT NULL DEFAULT 'created',
    order_datetime TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    estimated_delivery TIMESTAMP,
    actual_delivery TIMESTAMP,
    delivery_address TEXT NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL DEFAULT 0 CHECK (total_amount >= 0),
    payment_method VARCHAR(50) DEFAULT 'card',
    payment_status VARCHAR(50) DEFAULT 'pending',
    notes TEXT,
    
    CONSTRAINT fk_orders_customers 
    FOREIGN KEY (customer_id) 
    REFERENCES customers(customer_id),
    
    CONSTRAINT fk_orders_restaurants 
        FOREIGN KEY (restaurant_id) 
        REFERENCES restaurants(restaurant_id),
    
    CONSTRAINT fk_orders_couriers 
        FOREIGN KEY (courier_id) 
        REFERENCES couriers(courier_id),
    
    CONSTRAINT check_order_status 
        CHECK (status IN (
            'created', 
            'confirmed', 
            'preparing', 
            'ready', 
            'on_the_way', 
            'delivered', 
            'cancelled'
        ))
); 

COMMENT ON TABLE orders IS 'Основная таблица заказов';
COMMENT ON COLUMN orders.status IS 'Статус заказа: created, confirmed, preparing, ready, on_the_way, delivered, cancelled';
COMMENT ON COLUMN orders.total_amount IS 'Итоговая сумма заказа (вычисляется триггером)';
COMMENT ON COLUMN orders.estimated_delivery IS 'Расчетное время доставки';
COMMENT ON COLUMN orders.actual_delivery IS 'Фактическое время доставки';

CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INTEGER NOT NULL,
    dish_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    price_at_order DECIMAL(10,2) NOT NULL CHECK (price_at_order > 0),
    
    CONSTRAINT fk_order_items_orders 
        FOREIGN KEY (order_id) 
        REFERENCES orders(order_id)
        ON DELETE CASCADE,
    
    CONSTRAINT fk_order_items_dishes 
        FOREIGN KEY (dish_id) 
        REFERENCES dishes(dish_id),
    
    CONSTRAINT unique_order_dish 
        UNIQUE (order_id, dish_id)
);

COMMENT ON TABLE order_items IS 'Состав заказа (связь M:N между orders и dishes)';
COMMENT ON COLUMN order_items.price_at_order IS 'Цена блюда на момент создания заказа (фиксируется)';

CREATE TABLE reviews (
    review_id SERIAL PRIMARY KEY,
    order_id INTEGER UNIQUE NOT NULL,
    rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment TEXT,
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_reviews_orders 
        FOREIGN KEY (order_id) 
        REFERENCES orders(order_id)
        ON DELETE CASCADE
);

COMMENT ON TABLE reviews IS 'Отзывы клиентов на заказы';
COMMENT ON COLUMN reviews.order_id IS 'Ссылка на заказ (один отзыв на заказ)';


 