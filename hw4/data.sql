-- 1. категории
INSERT INTO core.categories (title, description) VALUES
('Смартфоны', 'Мобильные телефоны с сенсорным экраном и расширенными функциями'),
('Ноутбуки', 'Портативные компьютеры для работы и развлечений'),
('Телевизоры', 'Техника для просмотра телепередач и видео'),
('Наушники', 'Аудиоустройства для прослушивания музыки'),
('Фотоаппараты', 'Техника для создания фотографий и видео'),
('Игровые консоли', 'Устройства для видеоигр'),
('Умные часы', 'Носимые устройства с функциями смартфона');

-- 2. производители
INSERT INTO ref.producers (title, country, details) VALUES
('Samsung', 'Южная Корея',
'{ "founded_year": 1938, "website": "samsung.com", "main_products": ["smartphones", "tv", "appliances"] }'),
('Apple', 'США',
'{ "founded_year": 1976, "website": "apple.com", "main_products": ["iphone", "mac", "ipad", "watch"] }'),
('Xiaomi', 'Китай',
'{ "founded_year": 2010, "website": "mi.com", "main_products": ["smartphones", "smart_home", "laptops"] }'),
('Sony', 'Япония',
'{ "founded_year": 1946, "website": "sony.com", "main_products": ["electronics", "gaming", "entertainment"] }'),
('LG', 'Южная Корея',
'{ "founded_year": 1947, "website": "lg.com", "main_products": ["tv", "appliances", "smartphones"] }'),
('Canon', 'Япония',
'{ "founded_year": 1937, "website": "canon.com", "main_products": ["cameras", "printers", "scanners"] }'),
('Microsoft', 'США',
'{ "founded_year": 1975, "website": "microsoft.com", "main_products": ["software", "xbox", "surface"] }'),
('Huawei', 'Китай',
'{ "founded_year": 1987, "website": "huawei.com", "main_products": ["smartphones", "networking", "5g"] }');

-- 3. поставщики
INSERT INTO ref.suppliers (title, address) VALUES
('TechSupply Ltd', '{ "city": "Москва", "street": "Ленинский проспект", "building": "42" }'),
('ElectroTrade', '{ "city": "Санкт-Петербург", "street": "Невский проспект", "building": "28" }'),
('GadgetWorld', '{ "city": "Москва", "street": "Тверская", "building": "15" }'),
('DigitalPartner', '{ "city": "Екатеринбург", "street": "проспект Ленина", "building": "50" }'),
('MegaTech', '{ "city": "Новосибирск", "street": "Красный проспект", "building": "25" }');

-- 4. товары
INSERT INTO core.products (title, description, producer_id, supplier_id, characteristics) VALUES
('iPhone 14 Pro', 'Флагманский смартфон с камерой 48 Мп', 2, 1,
'{ "display": "6.1″ Super Retina XDR", "processor": "A16 Bionic", "storage": "256 ГБ" }'),
('Samsung Galaxy S23', 'Мощный Android-смартфон с экраном 120 Гц', 1, 2,
'{ "display": "6.1″ Dynamic AMOLED 2X, 120 Гц", "processor": "Snapdragon 8 Gen 2", "storage": "512 ГБ"}'),
('MacBook Air M2', 'Ультрабук на процессоре Apple Silicon', 2, 1,
'{ "display": "13.6″ Liquid Retina", "processor": "Apple M2", "ram": "16 ГБ" }'),
('Xiaomi Notebook Pro', 'Производительный ноутбук для работы', 3, 3,
'{ "display": "14″ 2.8K OLED, 90 Гц", "processor": "Intel Core i7-1260P", "ram": "16 ГБ LPDDR5" }'),
('Sony Bravia XR', '4K телевизор с технологией Cognitive Processor', 4, 4,
'{ "diagonal": "55″", "resolution": "4K UHD (3840x2160)", "hdr": "Dolby Vision, HDR10" }'),
('LG OLED C2', 'OLED телевизор с идеальным черным цветом', 5, 5,
'{ "diagonal": "65″", "resolution": "4K UHD (3840x2160)", "technology": "OLED evo" }'),
('AirPods Pro', 'Беспроводные наушники с шумоподавлением', 2, 1,
'{ "type": "внутриканальные", "battery_life": "6 часов (с шумоподавлением)", "charging": "MagSafe, Qi, Lightning" }'),
('Sony WH-1000XM5', 'Наушники с продвинутым шумоподавлением', 4, 4,
'{ "type": "накладные", "battery_life": "30 часов (с шумоподавлением)", "charging": "USB-C, 3 мин = 3 часа" }'),
('Canon EOS R6', 'Беззеркальная камера для профессионалов', 6, 2,
'{ "sensor": "20.1 Мп Full-Frame CMOS", "iso": "100-102400", "burst": "12 fps mechanical, 20 fps electronic" }'),
('Xbox Series X', 'Игровая консоль нового поколения', 7, 3,
'{ "processor": "8-core AMD Zen 2, 3.8 ГГц", "gpu": "AMD RDNA 2, 12 TFLOPS", "memory": "16 ГБ GDDR6" }'),
('Apple Watch Series 8', 'Умные часы с функциями здоровья', 2, 1,
'{ "case_size": "45 мм", "display": "Always-On Retina", "processor": "S8 SiP" }');

-- 5. цены
INSERT INTO core.prices (product_id, value, start_date, end_date) VALUES
(1, 99990.00, '2023-09-01', NULL),
(2, 84990.00, '2023-08-15', NULL),
(3, 119990.00, '2023-07-01', NULL),
(4, 75990.00, '2023-06-10', NULL),
(5, 129990.00, '2023-05-20', NULL),
(6, 99990.00, '2023-04-15', NULL),
(7, 24990.00, '2023-03-01', NULL),
(8, 34990.00, '2023-02-10', NULL),
(9, 159990.00, '2023-01-15', NULL),
(10, 45990.00, '2022-12-01', NULL),
(11, 39990.00, '2022-11-10', NULL);

-- 6. покупатели
INSERT INTO core.customers (first_name, last_name, registration_date) VALUES
('Иван', 'Петров', '2023-01-15'),
('Елена', 'Сидорова', '2023-02-20'),
('Алексей', 'Кузнецов', '2023-03-10'),
('Ольга', 'Иванова', '2023-04-05'),
('Дмитрий', 'Смирнов', '2023-05-12'),
('Мария', 'Попова', '2023-06-18'),
('Сергей', 'Васильев', '2023-07-22');

-- 7. покупки
INSERT INTO core.purchases (customer_id, purchase_date) VALUES
(1, '2023-09-01 14:30:00'),
(2, '2023-09-02 16:45:00'),
(3, '2023-09-03 11:20:00'),
(4, '2023-09-04 13:15:00'),
(5, '2023-09-05 18:30:00'),
(1, '2023-09-06 10:00:00'),
(6, '2023-09-07 15:45:00'),
(7, '2023-09-08 12:30:00');

-- 8. состав покупок
INSERT INTO core.purchase_items (purchase_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 99990.00),
(1, 7, 1, 24990.00),
(2, 3, 1, 119990.00),
(3, 2, 1, 84990.00),
(3, 8, 1, 34990.00),
(4, 5, 1, 129990.00),
(5, 10, 1, 45990.00),
(5, 11, 1, 39990.00),
(6, 4, 1, 75990.00),
(7, 6, 1, 99990.00),
(8, 9, 1, 159990.00),
(8, 8, 1, 34990.00);

-- 9. привязка товаров к категориям
INSERT INTO core.product_category (product_id, category_id) VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 2),
(5, 3),
(6, 3),
(7, 4),
(8, 4),
(9, 5),
(10, 6),
(11, 7);

-- 10. телефоны
INSERT INTO ref.phones(phone, customer_id, supplier_id) VALUES
('+7-495-123-45-67', 1, NULL),
('+7-495-132-45-67', 2, NULL),
('+7-495-123-87-67', 3, NULL),
('+7-495-123-45-45', 4, NULL),
('+7-495-123-45-78', 5, NULL),
('+7-495-123-12-67', 6, NULL),
('+7-495-852-45-67', 7, NULL),
('+7-495-856-45-67', NULL, 1),
('+7-495-159-45-67', NULL, 2),
('+7-495-123-75-67', NULL, 3),
('+7-495-123-86-67', NULL, 4),
('+7-495-123-45-45', NULL, 5);

-- 11. email
INSERT INTO ref.emails(email, customer_id, supplier_id) VALUES
('ivan.petrov@mail.ru', 1, NULL),
('elena.sidorova@gmail.com', 2, NULL),
('alex.kuznetsov@yandex.ru', 3, NULL),
('olga.ivanova@mail.ru', 4, NULL),
('dmitry.smirnov@gmail.com', 5, NULL),
('maria.popova@yandex.ru', 6, NULL),
('sergey.vasiliev@mail.ru', 7, NULL),
('info@techsupply.ru', NULL, 1),
('sales@electrotrade.ru', NULL, 2),
('order@gadgetworld.ru', NULL, 3),
('partner@digital.ru', NULL, 4),
('contact@megatech.ru', NULL, 5);
