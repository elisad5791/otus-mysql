------------------- СПИСКИ -----------------------------------------
--------------------------------------------------------------------

-- 1. список товаров с ценами
SELECT p.id, p.title, p.description, pr.value AS actual_price
FROM products p 
INNER JOIN prices pr ON pr.product_id = p.id AND pr.end_date IS NULL
ORDER BY pr.value DESC;

-- 2. список товаров с названиями категорий, поставщиков, производителей
SELECT 
    p.title AS product_title,
    p.description AS product_description,
    pr.title AS producer_title,
    su.title AS supplier_title,
    GROUP_CONCAT(ca.title SEPARATOR ', ') AS category_titles
FROM products p
LEFT JOIN producers pr ON p.producer_id = pr.id
LEFT JOIN suppliers su ON p.supplier_id = su.id
LEFT JOIN product_category pc ON pc.product_id = p.id
LEFT JOIN categories ca ON ca.id = pc.category_id
GROUP BY p.title, p.description, pr.title, su.title
ORDER BY product_title;

-- 3. список поставщиков (с телефонами, email)
SELECT 
    s.title,
    s.address->'$.city' AS city,
    s.address->'$.street' AS street,
    s.address->'$.building' AS building,
    GROUP_CONCAT(e.email SEPARATOR ', ') AS emails,
    GROUP_CONCAT(p.phone SEPARATOR ', ') AS phones
FROM suppliers s
LEFT JOIN emails e ON e.supplier_id = s.id 
LEFT JOIN phones p ON p.supplier_id = s.id
GROUP BY s.title, city, street, building
ORDER BY s.title;

-- 4. список покупателей (с телефонами, email)
SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    DATE_FORMAT(c.registration_date, '%d.%m.%Y') AS registration_date,
    GROUP_CONCAT(e.email SEPARATOR ', ') AS emails,
    GROUP_CONCAT(p.phone SEPARATOR ', ') AS phones
FROM customers c
LEFT JOIN emails e ON e.customer_id = c.id 
LEFT JOIN phones p ON p.customer_id = c.id
GROUP BY full_name, registration_date
ORDER BY full_name;

--------------- КОРЗИНА ---------------------------------------------
---------------------------------------------------------------------

-- 5. покупки определенного покупателя
SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    DATE_FORMAT(p.purchase_date, '%d.%m.%Y') AS purchase_date,
    SUM(pi.unit_price * pi.quantity) AS total
FROM customers c
LEFT JOIN purchases p ON p.customer_id = c.id
LEFT JOIN purchase_items pi ON pi.purchase_id = p.id
WHERE c.id = 1
GROUP BY c.first_name, c.last_name, p.purchase_date
ORDER BY p.purchase_date;

-- 6. описание конкретной покупки
SELECT 
    p.id,
    DATE_FORMAT(p.purchase_date, '%d.%m.%Y') AS purchase_date,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    pr.title,
    pi.quantity,
    pi.unit_price,
    pi.quantity * pi.unit_price AS item_total
FROM purchases p
LEFT JOIN customers c ON c.id = p.customer_id
LEFT JOIN purchase_items pi ON pi.purchase_id = p.id
LEFT JOIN products pr ON pr.id = pi.product_id
WHERE p.id = 1;

----------------- АНАЛИЗ -------------------------------------
--------------------------------------------------------------

-- 7. анализ покупок по товарам
SELECT
    p.id,
    p.title,
    SUM(pi.quantity * pi.unit_price) AS product_total
FROM products p
LEFT JOIN purchase_items pi ON pi.product_id = p.id
GROUP BY p.id, p.title
ORDER BY product_total DESC;

-- 8. анализ покупок по категориям
SELECT
    c.id,
    c.title,
    SUM(pi.quantity * pi.unit_price) AS category_total
FROM categories c
LEFT JOIN product_category pc ON pc.category_id = c.id
LEFT JOIN products p ON p.id = pc.product_id
LEFT JOIN purchase_items pi ON pi.product_id = p.id
GROUP BY c.id, c.title
ORDER BY category_total DESC;

-- 9. анализ покупок по поставщикам
SELECT
    s.id,
    s.title,
    SUM(pi.quantity * pi.unit_price) AS supplier_total
FROM suppliers s
LEFT JOIN products p ON p.supplier_id = s.id
LEFT JOIN purchase_items pi ON pi.product_id = p.id
GROUP BY s.id, s.title
ORDER BY supplier_total DESC;

---------------- ВЫБОРКИ ---------------------------------------------------
----------------------------------------------------------------------------

-- 10. выборка - товары с дисплеем oled
SELECT 
    p.title,
    c.title AS category,
    p.characteristics->'$.display' AS display
FROM products p
JOIN product_category pc ON pc.product_id = p.id
JOIN categories c ON c.id = pc.category_id
WHERE JSON_SEARCH(LOWER(p.characteristics), 'one', '%oled%', NULL, '$.display') IS NOT NULL
ORDER BY p.title;

-- 11. выборка - покупки текущего месяца
SELECT 
    p.id,
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    DATE_FORMAT(p.purchase_date, '%d.%m.%Y') AS purchase_date,
    SUM(pi.unit_price * pi.quantity) AS total
FROM purchases p 
LEFT JOIN purchase_items pi ON pi.purchase_id = p.id
LEFT JOIN customers c ON c.id = p.customer_id
WHERE YEAR(p.purchase_date) = YEAR(CURDATE()) AND MONTH(p.purchase_date) = MONTH(CURDATE())
GROUP BY p.id, c.first_name, c.last_name, p.purchase_date
ORDER BY p.purchase_date;

-- 12. выборка - покупатели, зарегистрированные в этом году (where)
SELECT 
    first_name,
    last_name,
    DATE_FORMAT(registration_date, '%d.%m.%Y') AS registration_date
FROM customers
WHERE YEAR(registration_date) = YEAR(CURDATE())
ORDER BY first_name, last_name;

-- 13. выборка - товары конкретной категории (например, Смартфоны)
SELECT 
    p.id,
    p.title,
    p.description,
    'Смартфоны' AS category
FROM products p
LEFT JOIN product_category pc ON pc.product_id = p.id
LEFT JOIN categories ca ON ca.id = pc.category_id
WHERE ca.title = 'Смартфоны'
ORDER BY p.title;