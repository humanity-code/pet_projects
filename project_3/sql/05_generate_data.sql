insert into customers (full_name, phone_number, email, registration_date, delivery_address)
select 
	case (i % 10)
		when 0 then 'Иванов Иван ' || (i/10 + 1)
        when 1 then 'Петрова Анна ' || (i/10 + 1)
        when 2 then 'Сидоров Алексей ' || (i/10 + 1)
        when 3 then 'Козлова Мария ' || (i/10 + 1)
        when 4 then 'Смирнов Дмитрий ' || (i/10 + 1)
        when 5 then 'Васильева Елена ' || (i/10 + 1)
        when 6 then 'Попов Андрей ' || (i/10 + 1)
        when 7 then 'Новикова Ольга ' || (i/10 + 1)
        when 8 then 'Федоров Сергей ' || (i/10 + 1)
        when 9 then 'Морозова Татьяна ' || (i/10 + 1)
    end,
    
    '+7916' || (1000000 + i * 12345)::VARCHAR,
    
    'client' || i || case 
    	when i % 3 = 0 then '@mail.ru'
        when i % 3 = 1 then '@gmail.com'
        else '@yandex.ru'
    end,
    
    current_date - (random() * 730)::INTEGER,
    
    case (i % 15)
    	when 0 then 'Москва, ул. Тверская, д. ' || (10 + i%20) || ', кв. ' || (i%100 + 1)
        when 1 then 'Москва, ул. Арбат, д. ' || (20 + i%15) || ', кв. ' || (i%50 + 1)
        when 2 then 'Москва, пр. Мира, д. ' || (30 + i%25) || ', кв. ' || (i%80 + 1)
        when 3 then 'Москва, ул. Ленина, д. ' || (5 + i%10) || ', кв. ' || (i%40 + 1)
        when 4 then 'Москва, ул. Пушкина, д. ' || (15 + i%18) || ', кв. ' || (i%60 + 1)
        when 5 then 'Москва, ул. Гагарина, д. ' || (25 + i%22) || ', кв. ' || (i%70 + 1)
        when 6 then 'Москва, ул. Садовая, д. ' || (8 + i%12) || ', кв. ' || (i%30 + 1)
        when 7 then 'Москва, ул. Лесная, д. ' || (3 + i%8) || ', кв. ' || (i%25 + 1)
        when 8 then 'Москва, ул. Советская, д. ' || (12 + i%16) || ', кв. ' || (i%45 + 1)
        when 9 then 'Москва, ул. Кирова, д. ' || (18 + i%20) || ', кв. ' || (i%55 + 1)
        when 10 then 'Москва, ул. Новая, д. ' || (7 + i%9) || ', кв. ' || (i%35 + 1)
        when 11 then 'Москва, ул. Центральная, д. ' || (22 + i%24) || ', кв. ' || (i%65 + 1)
        when 12 then 'Москва, ул. Школьная, д. ' || (14 + i%17) || ', кв. ' || (i%75 + 1)
        when 13 then 'Москва, ул. Заводская, д. ' || (28 + i%30) || ', кв. ' || (i%85 + 1)
        when 14 then 'Москва, ул. Парковая, д. ' || (9 + i%11) || ', кв. ' || (i%90 + 1)
    end
    
from generate_series(1, 100) i;    


with restaurant_data as (
	select
		name,
		cuisine_type,
		address,
		is_active,
		rating
	from (values
		('Pizza Italia', 'Итальянская', 'Москва, ул. Итальянская, 15', true, 4.7),
        ('Токио Суши', 'Японская', 'Москва, пр. Японский, 8', true, 4.8),
        ('Burger King', 'Американская', 'Москва, ул. Американская, 22', true, 4.3),
        ('Паста Мания', 'Итальянская', 'Москва, ул. Макаронная, 5', true, 4.6),
        ('Вок Мастер', 'Китайская', 'Москва, ул. Китайская, 12', true, 4.4),
        ('Шаурма Люкс', 'Восточная', 'Москва, ул. Восточная, 7', true, 4.2),
        ('Green Food', 'Здоровая', 'Москва, ул. Здоровая, 3', true, 4.9),
        ('Steak House', 'Американская', 'Москва, ул. Мясная, 18', true, 4.5),
        ('Coffee & Cake', 'Десерты', 'Москва, ул. Сладкая, 4', true, 4.8),
        ('Борщ & Блины', 'Русская', 'Москва, ул. Русская, 9', true, 4.1),
        ('Тайская Кухня', 'Тайская', 'Москва, ул. Тайская, 6', true, 4.7),
        ('Индийский Специи', 'Индийская', 'Москва, ул. Индийская, 11', true, 4.4),
        ('Мексикано', 'Мексиканская', 'Москва, ул. Мексиканская, 14', true, 4.3),
        ('Веган Кафе', 'Веганская', 'Москва, ул. Веганская, 2', true, 4.6),
        ('Французский Ужин', 'Французская', 'Москва, ул. Французская, 10', true, 4.5)
    ) as t(name, cuisine_type, address, is_active, rating)
)
insert into restaurants (name, cuisine_type, address, is_active, rating)
select * from restaurant_data;


insert into couriers (full_name, phone_number, vehicle_type, is_available)
select 
	case (i % 8)
	        when 0 then 'Иванов Александр ' || (i/8 + 1)
	        when 1 then 'Петров Максим ' || (i/8 + 1)
	        when 2 then 'Сидорова Ольга ' || (i/8 + 1)
	        when 3 then 'Кузнецов Дмитрий ' || (i/8 + 1)
	        when 4 then 'Васильев Артем ' || (i/8 + 1)
	        when 5 then 'Николаева Анна ' || (i/8 + 1)
	        when 6 then 'Алексеев Сергей ' || (i/8 + 1)
	        when 7 then 'Михайлова Екатерина ' || (i/8 + 1)
	end,
	    
	'+7917' || (2000000 + i * 23456)::VARCHAR,
	
	case (i % 10)
        when 0 then 'авто'
        when 1 then 'авто'
        when 2 then 'велосипед'
        when 3 then 'велосипед'
        when 4 then 'электросамокат'
        when 5 then 'электросамокат'
        when 6 then 'пеший'
        when 7 then 'мотоцикл'
        
        when 8 then 'авто'
        when 9 then 'велосипед'
    end,
    
    random() > 0.3
    
from generate_series(1, 25) i;


INSERT INTO dishes (restaurant_id, name, description, price, is_available, category)
SELECT 
    r.restaurant_id,
    
    CASE r.cuisine_type
        WHEN 'Итальянская' THEN 
            CASE 
                WHEN dish_num = 1 THEN 'Пицца Маргарита'
                WHEN dish_num = 2 THEN 'Пицца Пепперони'
                WHEN dish_num = 3 THEN 'Паста Карбонара'
                WHEN dish_num = 4 THEN 'Лазанья Болоньезе'
                WHEN dish_num = 5 THEN 'Брускетта с помидорами'
                WHEN dish_num = 6 THEN 'Тирамису'
                WHEN dish_num = 7 THEN 'Салат Капрезе'
                WHEN dish_num = 8 THEN 'Ризотто с грибами'
                WHEN dish_num = 9 THEN 'Фокачча'
                WHEN dish_num = 10 THEN 'Панна котта'
                WHEN dish_num = 11 THEN 'Греческий салат'
                WHEN dish_num = 12 THEN 'Лимончелло'
            END
        WHEN 'Японская' THEN
            CASE 
                WHEN dish_num = 1 THEN 'Ролл Филадельфия'
                WHEN dish_num = 2 THEN 'Ролл Калифорния'
                WHEN dish_num = 3 THEN 'Суши с лососем'
                WHEN dish_num = 4 THEN 'Темпура креветок'
                WHEN dish_num = 5 THEN 'Мисо суп'
                WHEN dish_num = 6 THEN 'Рамен с курицей'
                WHEN dish_num = 7 THEN 'Унаги дона'
                WHEN dish_num = 8 THEN 'Гёдза'
                WHEN dish_num = 9 THEN 'Сашими из тунца'
                WHEN dish_num = 10 THEN 'Моти'
                WHEN dish_num = 11 THEN 'Зеленый чай'
                WHEN dish_num = 12 THEN 'Якитори'
            END
        WHEN 'Американская' THEN
            CASE 
                WHEN dish_num = 1 THEN 'Чизбургер'
                WHEN dish_num = 2 THEN 'Бургер с беконом'
                WHEN dish_num = 3 THEN 'Картофель фри'
                WHEN dish_num = 4 THEN 'Куриные крылышки'
                WHEN dish_num = 5 THEN 'Молочный коктейль'
                WHEN dish_num = 6 THEN 'Стейк Рибай'
                WHEN dish_num = 7 THEN 'Клаб-сендвич'
                WHEN dish_num = 8 THEN 'Чили кон карне'
                WHEN dish_num = 9 THEN 'Яблочный пирог'
                WHEN dish_num = 10 THEN 'Кола'
                WHEN dish_num = 11 THEN 'Картофель по-деревенски'
                WHEN dish_num = 12 THEN 'Буффало бургер'
            END
        WHEN 'Китайская' THEN
            CASE 
                WHEN dish_num = 1 THEN 'Лапша с курицей'
                WHEN dish_num = 2 THEN 'Рис с овощами'
                WHEN dish_num = 3 THEN 'Спринг-роллы'
                WHEN dish_num = 4 THEN 'Утка по-пекински'
                WHEN dish_num = 5 THEN 'Кисло-сладкая свинина'
                WHEN dish_num = 6 THEN 'Димплинги'
                WHEN dish_num = 7 THEN 'Кунг Пао'
                WHEN dish_num = 8 THEN 'Том Ям'
                WHEN dish_num = 9 THEN 'Баклажан в чесночном соусе'
                WHEN dish_num = 10 THEN 'Китайский чай'
                WHEN dish_num = 11 THEN 'Вонтоны'
                WHEN dish_num = 12 THEN 'Свинина в кисло-сладком соусе'
            END
        WHEN 'Русская' THEN
            CASE 
                WHEN dish_num = 1 THEN 'Борщ с говядиной'
                WHEN dish_num = 2 THEN 'Пельмени'
                WHEN dish_num = 3 THEN 'Блины с икрой'
                WHEN dish_num = 4 THEN 'Салат Оливье'
                WHEN dish_num = 5 THEN 'Квас'
                WHEN dish_num = 6 THEN 'Щи'
                WHEN dish_num = 7 THEN 'Гречневая каша с грибами'
                WHEN dish_num = 8 THEN 'Селедка под шубой'
                WHEN dish_num = 9 THEN 'Вареники с картошкой'
                WHEN dish_num = 10 THEN 'Медовик'
                WHEN dish_num = 11 THEN 'Морс'
                WHEN dish_num = 12 THEN 'Котлеты по-киевски'
            END
        WHEN 'Тайская' THEN
            CASE 
                WHEN dish_num = 1 THEN 'Том Ям Кунг'
                WHEN dish_num = 2 THEN 'Пад Тай'
                WHEN dish_num = 3 THEN 'Зеленое карри'
                WHEN dish_num = 4 THEN 'Сом Там'
                WHEN dish_num = 5 THEN 'Тайский суп'
                WHEN dish_num = 6 THEN 'Жареный рис'
                WHEN dish_num = 7 THEN 'Спринг-роллы по-тайски'
                WHEN dish_num = 8 THEN 'Манго sticky rice'
                WHEN dish_num = 9 THEN 'Тайский чай'
                WHEN dish_num = 10 THEN 'Сатай'
                WHEN dish_num = 11 THEN 'Лапша с морепродуктами'
                WHEN dish_num = 12 THEN 'Красное карри'
            END
        WHEN 'Индийская' THEN
            CASE 
                WHEN dish_num = 1 THEN 'Баттер Чикен'
                WHEN dish_num = 2 THEN 'Тикка Масала'
                WHEN dish_num = 3 THEN 'Наан'
                WHEN dish_num = 4 THEN 'Бириани'
                WHEN dish_num = 5 THEN 'Палак Панир'
                WHEN dish_num = 6 THEN 'Самоса'
                WHEN dish_num = 7 THEN 'Тандури'
                WHEN dish_num = 8 THEN 'Корма'
                WHEN dish_num = 9 THEN 'Ласси'
                WHEN dish_num = 10 THEN 'Гулаб Джамун'
                WHEN dish_num = 11 THEN 'Чаат'
                WHEN dish_num = 12 THEN 'Роган Джош'
            END
        WHEN 'Мексиканская' THEN
            CASE 
                WHEN dish_num = 1 THEN 'Такос'
                WHEN dish_num = 2 THEN 'Буррито'
                WHEN dish_num = 3 THEN 'Кесадилья'
                WHEN dish_num = 4 THEN 'Начос'
                WHEN dish_num = 5 THEN 'Гуакамоле'
                WHEN dish_num = 6 THEN 'Энчилада'
                WHEN dish_num = 7 THEN 'Фахитас'
                WHEN dish_num = 8 THEN 'Чимичанга'
                WHEN dish_num = 9 THEN 'Маргарита'
                WHEN dish_num = 10 THEN 'Чуррос'
                WHEN dish_num = 11 THEN 'Сальса'
                WHEN dish_num = 12 THEN 'Тамалес'
            END
        WHEN 'Веганская' THEN
            CASE 
                WHEN dish_num = 1 THEN 'Веганский бургер'
                WHEN dish_num = 2 THEN 'Киноа салат'
                WHEN dish_num = 3 THEN 'Фалафель'
                WHEN dish_num = 4 THEN 'Тофу с овощами'
                WHEN dish_num = 5 THEN 'Смузи боул'
                WHEN dish_num = 6 THEN 'Чечевичный суп'
                WHEN dish_num = 7 THEN 'Овощной вок'
                WHEN dish_num = 8 THEN 'Авокадо тост'
                WHEN dish_num = 9 THEN 'Веганские суши'
                WHEN dish_num = 10 THEN 'Кокосовый йогурт'
                WHEN dish_num = 11 THEN 'Роллы с овощами'
                WHEN dish_num = 12 THEN 'Грибной стейк'
            END
        WHEN 'Французская' THEN
            CASE 
                WHEN dish_num = 1 THEN 'Круассан'
                WHEN dish_num = 2 THEN 'Луковый суп'
                WHEN dish_num = 3 THEN 'Рататуй'
                WHEN dish_num = 4 THEN 'Бёф Бургиньон'
                WHEN dish_num = 5 THEN 'Киш Лорен'
                WHEN dish_num = 6 THEN 'Конфи из утки'
                WHEN dish_num = 7 THEN 'Эклер'
                WHEN dish_num = 8 THEN 'Тарт Татен'
                WHEN dish_num = 9 THEN 'Сырная тарелка'
                WHEN dish_num = 10 THEN 'Вино Бордо'
                WHEN dish_num = 11 THEN 'Мусс из шоколада'
                WHEN dish_num = 12 THEN 'Салат Нисуаз'
            END
        ELSE
            CASE 
                WHEN dish_num = 1 THEN 'Суп дня'
                WHEN dish_num = 2 THEN 'Салат Цезарь'
                WHEN dish_num = 3 THEN 'Стейк из лосося'
                WHEN dish_num = 4 THEN 'Картофельное пюре'
                WHEN dish_num = 5 THEN 'Шоколадный торт'
                WHEN dish_num = 6 THEN 'Минеральная вода'
                WHEN dish_num = 7 THEN 'Греческий йогурт'
                WHEN dish_num = 8 THEN 'Фруктовая тарелка'
                WHEN dish_num = 9 THEN 'Кофе латте'
                WHEN dish_num = 10 THEN 'Брускетта'
                WHEN dish_num = 11 THEN 'Мороженое'
                WHEN dish_num = 12 THEN 'Свежевыжатый сок'
            END
    END,
    
    CASE r.cuisine_type
        WHEN 'Итальянская' THEN 
            CASE 
                WHEN dish_num = 1 THEN 'Классическая пицца с томатным соусом, моцареллой и базиликом. Идеальна для ужина в кругу семьи.'
                WHEN dish_num = 2 THEN 'Острая пицца с пепперони, сыром и томатами. Для любителей пикантных блюд.'
                WHEN dish_num = 3 THEN 'Паста с беконом, яйцами, пармезаном и сливочным соусом. Сытное итальянское блюдо.'
                WHEN dish_num = 4 THEN 'Лазанья с мясным соусом болоньезе и сыром. Традиционное блюдо для семейного обеда.'
                WHEN dish_num = 5 THEN 'Хрустящие гренки со свежими помидорами, базиликом и оливковым маслом. Отличная закуска.'
                WHEN dish_num = 6 THEN 'Нежный кофейный десерт с сыром маскарпоне. Лучшее завершение трапезы.'
                WHEN dish_num = 7 THEN 'Салат с моцареллой, помидорами и базиликом, заправленный оливковым маслом.'
                WHEN dish_num = 8 THEN 'Кремовое ризотто с шампиньонами и пармезаном.'
                WHEN dish_num = 9 THEN 'Итальянская лепешка с оливковым маслом и розмарином.'
                WHEN dish_num = 10 THEN 'Ванильный крем с ягодным соусом.'
                WHEN dish_num = 11 THEN 'Салат с огурцами, помидорами, оливками и фетой.'
                WHEN dish_num = 12 THEN 'Традиционный итальянский лимонный ликер.'
            END
        WHEN 'Японская' THEN
            CASE 
                WHEN dish_num = 1 THEN 'Ролл с лососем, сливочным сыром и огурцом. Самый популярный ролл в меню.'
                WHEN dish_num = 2 THEN 'Ролл с крабовым мясом, авокадо и икрой. Нежный и сочный.'
                WHEN dish_num = 3 THEN 'Нигири с лососем на рисовой подушке. Свежая рыба высшего качества.'
                WHEN dish_num = 4 THEN 'Креветки в хрустящем кляре. Подается с соусом тэнцу.'
                WHEN dish_num = 5 THEN 'Традиционный японский суп с тофу и водорослями вакамэ.'
                WHEN dish_num = 6 THEN 'Горячий суп с лапшой, курицей и яйцом. Сытное основное блюдо.'
                WHEN dish_num = 7 THEN 'Рисовая тарелка с угрем и соусом унаги.'
                WHEN dish_num = 8 THEN 'Жареные пельмени с курицей и овощами.'
                WHEN dish_num = 9 THEN 'Свежий тунец, нарезанный тонкими ломтиками.'
                WHEN dish_num = 10 THEN 'Рисовые шарики с начинкой из красной фасоли.'
                WHEN dish_num = 11 THEN 'Зеленый чай сорта сенча.'
                WHEN dish_num = 12 THEN 'Куриные шашлычки в соевом соусе.'
            END
        WHEN 'Американская' THEN
            CASE 
                WHEN dish_num = 1 THEN 'Классический бургер с говяжьей котлетой, сыром, салатом и соусом. Подается с булочкой бриошь.'
                WHEN dish_num = 2 THEN 'Бургер с беконом, сыром чеддер и соусом BBQ. Для настоящих мясоедов.'
                WHEN dish_num = 3 THEN 'Хрустящий картофель фри с солью. Идеальная закуска.'
                WHEN dish_num = 4 THEN 'Хрустящие куриные крылышки в медово-чесночном соусе. Подаются с сельдереем.'
                WHEN dish_num = 5 THEN 'Густой ванильный молочный коктейль со взбитыми сливками.'
                WHEN dish_num = 6 THEN 'Сочный стейк Рибай с розмарином. Подается с овощами гриль.'
                WHEN dish_num = 7 THEN 'Сендвич с индейкой, беконом, салатом и помидорами.'
                WHEN dish_num = 8 THEN 'Пряный суп с фаршем, бобами и томатами.'
                WHEN dish_num = 9 THEN 'Домашний яблочный пирог с ванильным мороженым.'
                WHEN dish_num = 10 THEN 'Газированный напиток 0.5л.'
                WHEN dish_num = 11 THEN 'Запеченный картофель с травами.'
                WHEN dish_num = 12 THEN 'Бургер с острым соусом буффало.'
            END
        WHEN 'Китайская' THEN
            CASE 
                WHEN dish_num = 1 THEN 'Жареная лапша с курицей, овощами и соевым соусом. Классическое китайское блюдо.'
                WHEN dish_num = 2 THEN 'Жареный рис с яйцом, горошком, морковью и кукурузой.'
                WHEN dish_num = 3 THEN 'Хрустящие роллы с овощами. Подаются с соевым соусом.'
                WHEN dish_num = 4 THEN 'Хрустящая утка с тонкими блинчиками и соусом хоisin.'
                WHEN dish_num = 5 THEN 'Свинина в кисло-сладком соусе с ананасами и перцем.'
                WHEN dish_num = 6 THEN 'Китайские пельмени на пару с свининой.'
                WHEN dish_num = 7 THEN 'Острое блюдо с курицей, арахисом и перцем.'
                WHEN dish_num = 8 THEN 'Острый тайский суп с креветками и грибами.'
                WHEN dish_num = 9 THEN 'Баклажаны в пряном чесночном соусе.'
                WHEN dish_num = 10 THEN 'Традиционный китайский чай.'
                WHEN dish_num = 11 THEN 'Пельмени в прозрачном тесте.'
                WHEN dish_num = 12 THEN 'Нежное мясо в кисло-сладком соусе.'
            END
        ELSE 
            CASE 
                WHEN dish_num % 4 = 0 THEN 'Вкусная закуска с свежими ингредиентами. Отлично подходит для начала трапезы.'
                WHEN dish_num % 4 = 1 THEN 'Сытное основное блюдо, приготовленное по традиционному рецепту. Идеально для обеда или ужина.'
                WHEN dish_num % 4 = 2 THEN 'Нежный десерт, который станет прекрасным завершением вашей трапезы.'
                WHEN dish_num % 4 = 3 THEN 'Освежающий напиток, отлично сочетающийся с любыми блюдами.'
            END
    END,
    
    CASE r.cuisine_type
        WHEN 'Итальянская' THEN 
            CASE 
                WHEN dish_num IN (1, 2, 3, 4) THEN (550 + random() * 200)::DECIMAL(10,2) 
                WHEN dish_num IN (5, 7, 8, 11) THEN (300 + random() * 150)::DECIMAL(10,2) 
                WHEN dish_num IN (6, 9, 10) THEN (250 + random() * 100)::DECIMAL(10,2)    
                ELSE (150 + random() * 100)::DECIMAL(10,2)                               
            END
        WHEN 'Японская' THEN
            CASE 
                WHEN dish_num IN (1, 2, 3, 6, 7, 8) THEN (450 + random() * 250)::DECIMAL(10,2)
                WHEN dish_num IN (4, 5, 9, 11) THEN (300 + random() * 150)::DECIMAL(10,2)
                WHEN dish_num = 10 THEN (200 + random() * 100)::DECIMAL(10,2)
                ELSE (150 + random() * 50)::DECIMAL(10,2)
            END
        WHEN 'Американская' THEN
            CASE 
                WHEN dish_num IN (1, 2, 6, 12) THEN (400 + random() * 200)::DECIMAL(10,2)
                WHEN dish_num IN (3, 4, 7, 8, 11) THEN (250 + random() * 150)::DECIMAL(10,2)
                WHEN dish_num IN (5, 9) THEN (200 + random() * 100)::DECIMAL(10,2)
                ELSE (100 + random() * 50)::DECIMAL(10,2)
            END
        WHEN 'Китайская' THEN
            CASE 
                WHEN dish_num IN (1, 2, 4, 5, 7, 8, 12) THEN (350 + random() * 200)::DECIMAL(10,2)
                WHEN dish_num IN (3, 6, 9, 11) THEN (250 + random() * 100)::DECIMAL(10,2)
                ELSE (120 + random() * 80)::DECIMAL(10,2)
            END
        ELSE  
            CASE 
                WHEN dish_num % 4 = 0 THEN (250 + random() * 150)::DECIMAL(10,2)
                WHEN dish_num % 4 = 1 THEN (400 + random() * 250)::DECIMAL(10,2)  
                WHEN dish_num % 4 = 2 THEN (200 + random() * 100)::DECIMAL(10,2)  
                ELSE (120 + random() * 80)::DECIMAL(10,2)                       
            END
    END,
    
    random() > 0.15,
    
    CASE r.cuisine_type
        WHEN 'Итальянская' THEN 
            CASE 
                WHEN dish_num IN (1, 2, 3, 4) THEN 'Основное'
                WHEN dish_num IN (5, 7, 8, 11) THEN 'Закуска'
                WHEN dish_num IN (6, 9, 10) THEN 'Десерт'
                ELSE 'Напиток'
            END
        WHEN 'Японская' THEN
            CASE 
                WHEN dish_num IN (1, 2, 3, 6, 7, 8) THEN 'Основное'
                WHEN dish_num IN (4, 5, 9, 11) THEN 'Закуска'
                WHEN dish_num = 10 THEN 'Десерт'
                ELSE 'Напиток'
            END
        WHEN 'Американская' THEN
            CASE 
                WHEN dish_num IN (1, 2, 6, 12) THEN 'Основное'
                WHEN dish_num IN (3, 4, 7, 8, 11) THEN 'Закуска'
                WHEN dish_num IN (5, 9) THEN 'Десерт'
                ELSE 'Напиток'
            END
        WHEN 'Китайская' THEN
            CASE 
                WHEN dish_num IN (1, 2, 4, 5, 7, 8, 12) THEN 'Основное'
                WHEN dish_num IN (3, 6, 9, 11) THEN 'Закуска'
                ELSE 'Напиток'
            END
        ELSE
            CASE 
                WHEN dish_num % 4 = 0 THEN 'Закуска'
                WHEN dish_num % 4 = 1 THEN 'Основное'
                WHEN dish_num % 4 = 2 THEN 'Десерт'
                ELSE 'Напиток'
            END
    END
    
FROM restaurants r
CROSS JOIN generate_series(1, 8 + (r.restaurant_id % 5)) dish_num
WHERE r.is_active = TRUE
ORDER BY r.restaurant_id, dish_num;

with 
active_restaurants as (
    select restaurant_id, row_number() over () as rn
    from restaurants 
    where is_active = true
),
 
available_couriers as (
    select courier_id, row_number() over () as rn
    from couriers 
    where is_available = true
),

counts as (
	select
		(select count(*) from active_restaurants) as restaurant_count,
		(select count(*) from available_couriers) as courier_count
),
		
random_data as (
    select 
        floor(random() * 100 + 1)::INTEGER as cust_id,
        floor(random() * (select restaurant_count from counts) + 1)::INTEGER as rest_rn,
        case 
	        when random() > 0.2 
	        then floor(random() * (select courier_count from counts) + 1)::INTEGER
            else null
        end as cour_rn,

        NOW() - (random() * interval '90 days') 
            + (interval '10 hours' + random() * interval '8 hours') as order_time
    from generate_series(1, 500) i
)

insert into orders (
    customer_id, restaurant_id, courier_id, status, 
    order_datetime, estimated_delivery, actual_delivery,
    delivery_address, total_amount, payment_method, payment_status, notes
)
select 
    rd.cust_id,
    ar.restaurant_id,
    ac.courier_id,

    case 
	    when (random() * 100)::int < 2 then 'created'
	    when (random() * 100)::int < 3 then 'confirmed'
	    when (random() * 100)::int < 11 then 'preparing'
	    when (random() * 100)::int < 16 then 'ready'
	    when (random() * 100)::int < 26 then 'on_the_way'
	    else 'delivered'
	end,
    
    rd.order_time,
    rd.order_time + (interval '30 minutes' + random() * interval '60 minutes'),
    
    case 
        when random() > 0.25 then 
            rd.order_time + (interval '25 minutes' + random() * interval '50 minutes')
        else null
    end,
    
    c.delivery_address,
    
    0,
    
    case when random() > 0.8 then 'cash' else 'card' end,
    
    case 
        when random() > 0.05 then 'completed'
        when random() > 0.5 then 'pending'
        else 'failed'
    end,
    
    case 
        when random() > 0.7 then 'Позвонить перед доставкой'
        when random() > 0.8 then 'Оставить у двери'
        when random() > 0.9 then 'Вегетарианский заказ'
        else null
    end
    
from random_data rd
join customers c on c.customer_id = rd.cust_id
left join active_restaurants ar on ar.rn = rd.rest_rn
left join available_couriers ac on ac.rn = rd.cour_rn;

insert into order_items (order_id, dish_id, quantity, price_at_order)
with numbered_dishes as (
    select 
        o.order_id,
        o.restaurant_id,
        d.dish_id,
        ROW_NUMBER() over (partition by o.order_id order by random()) as rn
    from orders o
    cross join lateral (
        select dish_id 
        from dishes 
        where restaurant_id = o.restaurant_id 
          and is_available = true
        order by random()
        limit 20  
    ) d
    where o.order_id <= 3000
),
order_item_counts as (
    select 
        order_id,
        floor(random() * 4 + 1)::INT as item_count 
    from orders 
    where order_id <= 3000
)
select 
    nd.order_id,
    nd.dish_id,
    case 
        when random() > 0.7 then floor(random() * 2 + 3)::INT  -- 3-4
        else floor(random() * 2 + 1)::INT  -- 1-2
    end as quantity,
    0 as price_at_order
from numbered_dishes nd
join order_item_counts oc on nd.order_id = oc.order_id
where nd.rn <= oc.item_count;

insert into reviews (order_id, rating, comment, review_date)
select o.order_id,
	case 
		when random() > 0.85 then floor(random() * 3 + 1)::INT
		else floor(random() * 2 + 4)::INT
	end, 
	
	case
		when random() * 10 < 8 then
			case floor(random() * 3)::INT
				when 0 then 'Все понравилось, доставили быстро'
                when 1 then 'Вкусно, закажу еще раз'
                when 2 then 'Нормально, но можно лучше'
            end
        else
        	case floor(random() * 3)::INT 
        		when 0 then 'Долго ждал доставку, еда остыла'
                when 1 then 'Не все позиции соответствуют описанию'
                when 2 then 'Курьер грубо себя вел'
            end
	end,
	
	coalesce(o.actual_delivery, o.order_datetime, o.estimated_delivery) 
	+ (interval '1 hour' * random() * 48)
	
from orders o
where o.status = 'delivered'
	and random() > 0.4
	and not exists (select 1 from reviews where order_id = o.order_id)
limit 200;