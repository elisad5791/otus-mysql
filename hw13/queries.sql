-- 1. группировки с ипользованием CASE, HAVING, ROLLUP, GROUPING()

-- количество телефонов и email для каждого поставщика
SELECT
    s.id,
    s.title,
    SUM(CASE WHEN p.phone IS NOT NULL THEN 1 ELSE 0 END) AS phone_count,
    SUM(CASE WHEN e.email IS NOT NULL THEN 1 ELSE 0 END) AS email_count
FROM suppliers s 
LEFT JOIN phones p ON p.supplier_id = s.id 
LEFT JOIN emails e ON e.supplier_id = s.id
GROUP BY s.id
ORDER BY s.id;

-- покупатели, у которых больше одной покупки
SELECT
    c.id,
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    COUNT(*) AS purchase_count
FROM customers c
LEFT JOIN purchases p ON p.customer_id = c.id 
GROUP BY c.id
HAVING purchase_count > 1
ORDER BY purchase_count DESC;

-- количество товаров по поставщикам
SELECT
    IF (GROUPING(s.title), 'ИТОГО', s.title) AS title,
    COUNT(*) AS product_count
FROM suppliers s 
LEFT JOIN products p ON p.supplier_id = s.id
GROUP BY s.title
WITH ROLLUP;

-- 2. для магазина к предыдущему списку продуктов добавить максимальную и минимальную цену и кол-во предложений

-- здесь неясна формулировка. написан запрос, показывающий для каждого товара минимальную и максимальную цену 
-- за все время и общее количество цен, т.е. получилась некоторая аналитика динамики цен
SELECT 
    p.id, 
    p.title, 
    MIN(pr.value) AS min_price, 
    MAX(pr.value) AS max_price, 
    COUNT(*) AS price_count
FROM products p
LEFT JOIN prices pr ON pr.product_id = p.id
GROUP BY p.id
ORDER BY p.id;

-- 3. сделать выборку показывающую самый дорогой и самый дешевый товар в каждой категории

SELECT c.id, c.title, MAX(pr.value) AS max_price, MIN(pr.value) AS min_price
FROM categories c
LEFT JOIN product_category pc ON pc.category_id = c.id
LEFT JOIN products p ON p.id = pc.product_id
LEFT JOIN prices pr ON pr.product_id = p.id AND (pr.end_date IS NULL OR pr.end_date >= CURDATE())
GROUP BY c.id
ORDER BY c.id;

WITH cte1 AS (
    SELECT c.id, MAX(pr.value) AS max_price, MIN(pr.value) AS min_price
    FROM categories c
    LEFT JOIN product_category pc ON pc.category_id = c.id
    LEFT JOIN products p ON p.id = pc.product_id
    LEFT JOIN prices pr ON pr.product_id = p.id AND (pr.end_date IS NULL OR pr.end_date >= CURDATE())
    GROUP BY c.id
), 
cte2 AS (
    SELECT p.id, p.title, pr.value AS price, c.id AS category_id
    FROM products p
    LEFT JOIN prices pr ON pr.product_id = p.id AND (pr.end_date IS NULL OR pr.end_date >= CURDATE())
    LEFT JOIN product_category pc ON pc.product_id = p.id
    LEFT JOIN categories c ON c.id = pc.category_id
)
SELECT
    c.id, 
    c.title,
    (SELECT 
		title 
	FROM cte2 
    WHERE category_id = c.id AND price = (SELECT max_price FROM cte1 WHERE id = c.id)
    ) AS most_expensive_product,
    (SELECT 
		title 
	FROM cte2 
    WHERE category_id = c.id AND price = (SELECT min_price FROM cte1 WHERE id = c.id)
    ) AS cheapest_product
FROM categories c
ORDER BY c.id;

-- 4. сделать rollup с количеством товаров по категориям
SELECT
    IF (GROUPING(c.title), 'ИТОГО', c.title) AS title,
    COUNT(*) AS product_count
FROM categories c 
LEFT JOIN product_category pc ON pc.category_id = c.id
GROUP BY c.title
WITH ROLLUP;
