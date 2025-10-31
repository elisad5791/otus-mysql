-- запрос с регулярным выражением (клиенты с email на gmail.com, yandex.ru)
SELECT 
    c.first_name,
    c.last_name,
    e.email
FROM customers c
INNER JOIN emails e ON c.id = e.customer_id
WHERE e.email ~ '^[^@]+@(gmail\.com|yandex\.ru)$';

-- запросы с LEFT JOIN, INNER JOIN
-- все поставщики
SELECT 
    s.title AS supplier_name,
    p.phone
FROM suppliers s
LEFT JOIN phones p ON s.id = p.supplier_id;

-- только поставщики, у которых есть телефоны
SELECT 
    s.title AS supplier_name,
    p.phone
FROM suppliers s
INNER JOIN phones p ON s.id = p.supplier_id;

-- когда порядок важен, на моих данных в первом варианте теряется строка с пустым телефоном
SELECT phone, email
FROM suppliers s
LEFT JOIN phones p ON s.id = p.supplier_id
INNER JOIN emails e ON p.supplier_id = e.supplier_id;

SELECT phone, email
FROM suppliers s
INNER JOIN emails e ON s.id = e.supplier_id
LEFT JOIN phones p ON e.supplier_id = p.supplier_id; 

--  запрос на добавление данных с выводом информации о добавленных строках
INSERT INTO phones(phone, supplier_id) VALUES('+7-999-123-45-67', 1)
RETURNING id, phone, supplier_id;

--  запрос с обновлением данных используя UPDATE FROM
--  обновление актуальных цен поставщика ElectroTrade
UPDATE prices p1
SET value = value * 1.1
FROM products p2
WHERE p1.product_id = p2.id 
    AND p2.supplier_id = (SELECT id FROM suppliers WHERE title = 'ElectroTrade')
    AND p1.end_date IS NULL;

-- запрос DELETE с JOIN USING
-- удаление телефонов клиентов, у которых нет покупок и дата регистрации более 2 лет назад
DELETE FROM phones
USING customers c
LEFT JOIN purchases p ON c.id = p.customer_id
WHERE phones.customer_id = c.id
    AND c.registration_date < CURRENT_TIMESTAMP - INTERVAL '2 years'
    AND p.id IS NULL;
