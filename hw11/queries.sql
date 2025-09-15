-- товары с актуальными ценами (inner join)
SELECT pro.id, pro.title, pro.description, pri.value
FROM products pro 
INNER JOIN prices pri ON pri.product_id = pro.id AND end_date IS NULL
ORDER BY pri.value DESC;

-- товары с названиями категорий, поставщиков, производителей (left join)
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

-- покупки текущего месяца (where)
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

-- товары категории Смартфоны (where)
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

-- производители конкретной страны (Япония) (where)
SELECT 
    id,
    title,
    country,
    details->'$.founded_year' AS founded_year,
    details->'$.website' AS website,
    REPLACE(REPLACE(REPLACE(details->'$.main_products', '[', ''), ']', ''), '"', '') as main_products
FROM producers
WHERE country = 'Япония'
ORDER BY title;

-- товары дороже 100 000
SELECT pro.id, pro.title, pro.description, pri.value
FROM products pro 
INNER JOIN prices pri ON pri.product_id = pro.id AND end_date IS NULL
WHERE pri.value > 100000
ORDER BY pri.value DESC;

-- покупатели, зарегистрированные в этом году (where)
SELECT 
    first_name,
    last_name,
    DATE_FORMAT(registration_date, '%d.%m.%Y') AS registration_date
FROM customers
WHERE YEAR(registration_date) = YEAR(CURDATE())
ORDER BY first_name, last_name;