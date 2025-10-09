SET NAMES utf8mb4;

CREATE database otus;
USE otus;

-- 1. категории
CREATE TABLE categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL UNIQUE,
    description TEXT NOT NULL
);

-- 2. производители
CREATE TABLE producers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL UNIQUE,
    country VARCHAR(50) NOT NUll,
    details JSON NOT NULL
);

-- 3. поставщики
CREATE TABLE suppliers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL UNIQUE,
    address JSON NOT NULL
);

-- 4. товары
CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    characteristics JSON NOT NULL,
    producer_id INT NOT NULL,
    supplier_id INT NOT NULL,
    FOREIGN KEY (producer_id) REFERENCES producers(id),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(id)
);

-- 5. таблица для множественной привязки товара к категориям
CREATE TABLE product_category (
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    category_id INT NOT NULL,
    FOREIGN KEY (category_id) REFERENCES categories(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- 6. цены
CREATE TABLE prices (
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    value DECIMAL(10, 2) UNSIGNED NOT NULL,
    start_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    end_date TIMESTAMP NULL,
    FOREIGN KEY (product_id) REFERENCES products(id)
);


-- 7. покупатели
CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    registration_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);


-- 8. покупки
CREATE TABLE purchases (
    id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    purchase_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);


-- 9. состав покупок
CREATE TABLE purchase_items (
    id INT PRIMARY KEY AUTO_INCREMENT,
    purchase_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT UNSIGNED NOT NULL DEFAULT 1,
    unit_price DECIMAL(10, 2) UNSIGNED NOT NULL,
    FOREIGN KEY (purchase_id) REFERENCES purchases(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- 10. телефоны
CREATE TABLE phones (
    id INT PRIMARY KEY AUTO_INCREMENT,
    phone VARCHAR(20) NOT NULL CHECK (phone REGEXP '^\\+7[0-9\\-]{7,}$'),
    supplier_id INT,
    customer_id INT,
    FOREIGN KEY (supplier_id) REFERENCES suppliers(id),
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

-- 11. email
CREATE TABLE emails (
    id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(100) NOT NULL CHECK (email REGEXP '^[^@]+@[^@]+\\.[^@]{2,}$'),
    supplier_id INT,
    customer_id INT,
    FOREIGN KEY (supplier_id) REFERENCES suppliers(id),
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

-- тестовые данные

-- 1. категории - 7
INSERT INTO categories (title, description) VALUES
('Смартфоны', 'Мобильные телефоны с сенсорным экраном и расширенными функциями'),
('Ноутбуки', 'Портативные компьютеры для работы и развлечений'),
('Телевизоры', 'Техника для просмотра телепередач и видео'),
('Наушники', 'Аудиоустройства для прослушивания музыки'),
('Фотоаппараты', 'Техника для создания фотографий и видео'),
('Игровые консоли', 'Устройства для видеоигр'),
('Умные часы', 'Носимые устройства с функциями смартфона');

-- 2. производители - 8
INSERT INTO producers (title, country, details) VALUES
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

-- 3. поставщики - 5
INSERT INTO suppliers (title, address) VALUES
('TechSupply Ltd', '{ "city": "Москва", "street": "Ленинский проспект", "building": "42" }'),
('ElectroTrade', '{ "city": "Санкт-Петербург", "street": "Невский проспект", "building": "28" }'),
('GadgetWorld', '{ "city": "Москва", "street": "Тверская", "building": "15" }'),
('DigitalPartner', '{ "city": "Екатеринбург", "street": "проспект Ленина", "building": "50" }'),
('MegaTech', '{ "city": "Новосибирск", "street": "Красный проспект", "building": "25" }');

