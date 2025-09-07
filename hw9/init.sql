CREATE database otus;
USE otus;

CREATE TABLE drivers ( 
	driver_id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(100) NOT NULL,
	phone VARCHAR(20) NOT NULL,
	status VARCHAR(20) NOT NULL,
    details VARCHAR(500) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE vehicle_types ( 
	vehicle_type_id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(50) NOT NULL,
	description VARCHAR(300) NOT NULL,
	min_capacity_kg DECIMAL(10,2) NOT NULL,
	max_capacity_kg DECIMAL(10,2) NOT NULL,
	min_capacity_m3 DECIMAL(10,2) NOT NULL,
	max_capacity_m3 DECIMAL(10,2) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE vehicles (
    vehicle_id INT PRIMARY KEY AUTO_INCREMENT,
    model VARCHAR(50) NOT NULL,
    vehicle_type_id INT NOT NULL,
    capacity_kg DECIMAL(10,2) NOT NULL,
    capacity_m3 DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) NOT NULL,
    details VARCHAR(500) NOT NULL,
    CONSTRAINT vehicles_vehicle_type_id_fkey FOREIGN KEY (vehicle_type_id) REFERENCES vehicle_types(vehicle_type_id)
) ENGINE=InnoDB;

CREATE TABLE addresses ( 
	address_id INT PRIMARY KEY AUTO_INCREMENT,
	country VARCHAR(50) NOT NULL,
	city VARCHAR(50) NOT NULL,
	postal_code VARCHAR(20),
	address_text VARCHAR(200) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE warehouses ( 
	warehouse_id INT PRIMARY KEY AUTO_INCREMENT,
	address_id INT NOT NULL UNIQUE,
	name VARCHAR(100) NOT NULL,
	capacity_m2 DECIMAL(10,2) NOT NULL,
	current_occupancy_m2 DECIMAL(10,2) NOT NULL,
	CONSTRAINT warehouses_address_id_fkey FOREIGN KEY (address_id) REFERENCES addresses(address_id)
) ENGINE=InnoDB;

CREATE TABLE customers ( 
	customer_id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(100) NOT NULL,
	contact_person VARCHAR(50) NOT NULL,
	phone VARCHAR(20) NOT NULL,
	email VARCHAR(50) NOT NULL,
	address_id INT NOT NULL UNIQUE,
	CONSTRAINT customers_address_id_fkey FOREIGN KEY (address_id) REFERENCES addresses(address_id)
) ENGINE=InnoDB;

INSERT INTO drivers (name, phone, status, details) VALUES
('Ivan Petrov', '+7-911-123-4501', 'free', '{"license":"RU-AB12345","experience_years":5}'),
('Sergey Ivanov', '+7-921-234-5602', 'resting', '{"license":"RU-BC23456","experience_years":7}'),
('Dmitry Sokolov', '+7-931-345-6703', 'busy', '{"license":"RU-CD34567","experience_years":3}'),
('Alexey Smirnov', '+7-912-456-7804', 'busy', '{"license":"RU-DE45678","experience_years":10}'),
('Nikolay Volkov', '+7-922-567-8905', 'free', '{"license":"RU-EF56789","experience_years":8}'),
('Pavel Morozov', '+7-932-678-9006', 'busy', '{"license":"RU-FG67890","experience_years":2}'),
('Andrey Lebedev', '+7-913-789-0107', 'resting', '{"license":"RU-GH78901","experience_years":6}'),
('Mikhail Kozlov', '+7-923-890-1208', 'resting', '{"license":"RU-HI89012","experience_years":4}'),
('Vladimir Novikov', '+7-933-901-2309', 'busy', '{"license":"RU-IJ90123","experience_years":9}'),
('Yuri Fedorov', '+7-914-012-3410', 'sick', '{"license":"RU-JK01234","experience_years":1}');

INSERT INTO vehicle_types (
    name, 
    description, 
    min_capacity_kg, 
    max_capacity_kg, 
    min_capacity_m3,
    max_capacity_m3
) VALUES 
-- Легковые автомобили
('Small Van', 'Compact delivery van for urban areas', 800, 1000, 6, 8),
('Medium Van', 'Mid-size van for regional deliveries', 1600, 2000, 12, 15),
('Large Van', 'Full-size van for heavy urban deliveries', 3000, 3500, 20, 25),

-- Грузовики
('Light Truck', 'Small truck for intercity deliveries', 4500, 5000, 35, 40),
('Medium Truck', 'Standard truck for regional logistics', 10000, 12000, 50, 60);

INSERT INTO vehicles (
    vehicle_type_id, 
    capacity_kg, 
    capacity_m3, 
    status, 
    model,
    details
) VALUES
-- Small Vans (тип 1)
(1, 950, 7.5, 'busy', 'Mercedes Sprinter', '{"license_plate": "А123БВ777", "year": 2020, "last_maintenance": "2023-05-15", "fuel_type": "diesel", "mileage": 45000}'),
(1, 980, 7.8, 'free', 'Ford Transit', '{"license_plate": "В456УК178", "year": 2019, "last_maintenance": "2023-06-20", "fuel_type": "diesel", "mileage": 52000}'),
(1, 990, 8.0, 'busy', 'Volkswagen Crafter', '{"license_plate": "Е789ТТ198", "year": 2021, "last_maintenance": "2023-04-10", "fuel_type": "diesel", "mileage": 32000}'),
(1, 900, 7.0, 'repair', 'Fiat Ducato', '{"license_plate": "К321ОС777", "year": 2018, "last_maintenance": "2023-03-01", "fuel_type": "diesel", "mileage": 68000, "maintenance_notes": "Требуется замена тормозных колодок"}'),
(1, 1000, 8.0, 'free', 'Peugeot Boxer', '{"license_plate": "М555АВ123", "year": 2022, "last_maintenance": "2023-07-12", "fuel_type": "diesel", "mileage": 15000}'),

-- Medium Vans (тип 2)
(2, 1900, 14.0, 'busy', 'Mercedes Sprinter LWB', '{"license_plate": "Н777ХХ777", "year": 2020, "last_maintenance": "2023-05-30", "fuel_type": "diesel", "mileage": 48000}'),
(2, 1950, 14.5, 'free', 'Ford Transit Custom', '{"license_plate": "О123СС123", "year": 2021, "last_maintenance": "2023-06-15", "fuel_type": "diesel", "mileage": 35000}'),
(2, 1800, 13.5, 'inspection', 'Volkswagen LT', '{"license_plate": "Р456ММ456", "year": 2019, "last_maintenance": "2023-02-28", "fuel_type": "diesel", "mileage": 72000, "status_reason": "Списание по пробегу"}'),
(2, 2000, 15.0, 'free', 'Iveco Daily', '{"license_plate": "С789АА789", "year": 2018, "last_maintenance": "2023-08-01", "fuel_type": "diesel", "mileage": 65000}'),
(2, 1950, 14.8, 'busy', 'Renault Master', '{"license_plate": "Т321КК321", "year": 2022, "last_maintenance": "2023-07-20", "fuel_type": "diesel", "mileage": 12000}');

INSERT INTO addresses (country, city, postal_code, address_text) 
VALUES 
('Россия', 'Пермь', '614000', '{"street": "ул. Ленина", "house": "15"}'),
('Россия', 'Пермь', '614045', '{"street": "ул. Куйбышева", "house": "48"}'),
('Россия', 'Екатеринбург', '620000', '{"street": "ул. Ленина", "house": "24"}'),
('Россия', 'Екатеринбург', '620014', '{"street": "пр. Ленина", "house": "5"}'),
('Россия', 'Челябинск', '454000', '{"street": "ул. Кирова", "house": "159"}'),
('Россия', 'Челябинск', '454091', '{"street": "пр. Ленина", "house": "21"}'),

('Россия', 'Пермь', '614000', '{"street": "ул. Ленина", "house": "10"}'),
('Россия', 'Пермь', '614000', '{"street": "ул. Куйбышева", "house": "42"}'),
('Россия', 'Пермь', '614045', '{"street": "ул. Петропавловская", "house": "65"}'),
('Россия', 'Пермь', '614045', '{"street": "ул. Советская", "house": "18"}'),
('Россия', 'Пермь', '614068', '{"street": "ул. Попова", "house": "12"}'),
('Россия', 'Пермь', '614068', '{"street": "ул. Борчанинова", "house": "5"}'),
('Россия', 'Пермь', '614070', '{"street": "ул. Мира", "house": "30"}'),
('Россия', 'Пермь', '614070', '{"street": "ул. Крупской", "house": "8"}'),
('Россия', 'Пермь', '614077', '{"street": "ул. Уральская", "house": "93"}'),
('Россия', 'Пермь', '614077', '{"street": "ул. Пушкина", "house": "76"}');

INSERT INTO warehouses (address_id, name, capacity_m2, current_occupancy_m2)
VALUES 
(1, 'Склад товаров для ремонта (Пермь)', 1000, 500),
(2, 'Склад бытовой химии (Пермь)', 800, 400),
(3, 'Склад товаров для ремонта (Екатеринбург)', 1200, 600),
(4, 'Склад бытовой химии (Екатеринбург)', 900, 450),
(5, 'Склад товаров для ремонта (Челябинск)', 1100, 550),
(6, 'Склад бытовой химии (Челябинск)', 850, 425);

INSERT INTO customers (name, contact_person, phone, email, address_id) VALUES
('Строймаркет "Профи"', 'Иванов Иван', '+79161112233', 'profi1@stroymat.ru', 7),
('Хозтовары "Чистота"', 'Петрова Мария', '+79262223344', 'chistota2@chemistry.ru', 8),
('Стройбаза "Фундамент"', 'Сидоров Алексей', '+79363334455', 'fundament3@stroymat.ru', 9),
('Бытхим "Уют"', 'Кузнецова Анна', '+79464445566', 'uyut4@chemistry.ru', 10),
('Стройцентр "МастерОК"', 'Васильев Дмитрий', '+79565556677', 'masterok5@stroymat.ru', 11),
('Хозмаркет "Блеск"', 'Павлова Елена', '+79666667788', 'blesk6@chemistry.ru', 12),
('Стройдвор "Крепеж"', 'Николаев Сергей', '+79767778899', 'krepezh7@stroymat.ru', 13),
('Химия для дома "Чистюля"', 'Михайлова Ольга', '+79868889900', 'chistyulya8@chemistry.ru', 14),
('Стройресурс "Топаз"', 'Андреев Андрей', '+79969990011', 'topaz9@stroymat.ru', 15),
('Бытхимцентр "Фреш"', 'Федорова Татьяна', '+79171001122', 'fresh10@chemistry.ru', 16);