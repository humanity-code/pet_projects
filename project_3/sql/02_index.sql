CREATE INDEX idx_restaurants_cuisine ON restaurants(cuisine_type);
CREATE INDEX idx_restaurants_active ON restaurants(is_active) WHERE is_active=true;

CREATE INDEX idx_couriers_avaliable ON couriers(is_available) WHERE is_available=true;
CREATE INDEX idx_couriers_vechile ON couriers(vehicle_type);

CREATE INDEX idx_dishes_restaurant ON dishes(restaurant_id);
CREATE INDEX idx_dishes_category ON dishes(category);
CREATE INDEX idx_dishes_price ON dishes(price);
CREATE INDEX idx_dishes_available ON dishes(is_available) WHERE is_available = TRUE;

CREATE INDEX idx_orders_customer ON orders(customer_id);
CREATE INDEX idx_orders_restaurant ON orders(restaurant_id);
CREATE INDEX idx_orders_courier ON orders(courier_id);
CREATE INDEX idx_orders_status ON orders(status);
CREATE INDEX idx_orders_datetime ON orders(order_datetime);
CREATE INDEX idx_orders_delivery_date ON orders(actual_delivery);

CREATE INDEX idx_orders_customer_date ON orders(customer_id, order_datetime DESC);
CREATE INDEX idx_orders_restaurant_status ON orders(restaurant_id, status, order_datetime);

CREATE INDEX idx_order_items_order ON order_items(order_id);

CREATE INDEX idx_reviews_rating ON reviews(rating);
CREATE INDEX idx_reviews_date ON reviews(review_date);