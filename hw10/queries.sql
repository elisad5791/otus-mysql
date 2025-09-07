-- смартфоны с характеристиками
SELECT 
    p.title AS product_title,
    pr.title AS producer,
    p.characteristics->'$.processor' AS processor,
    p.characteristics->'$.storage' AS storage,
    p.characteristics->'$.display' AS display
FROM products p
JOIN producers pr ON p.producer_id = pr.id
WHERE p.category_id = 1;

-- смартфоны с памятью 256 ГБ
SELECT 
    title,
    characteristics->'$.display' AS display,
    characteristics->'$.processor' AS processor,
    characteristics->'$.storage' AS storage
FROM products
WHERE 
    characteristics->'$.storage' LIKE '%256%'
    AND category_id = 1
ORDER BY title;

-- компании-производители с их возрастом
SELECT 
    title,
    country,
    details->'$.founded_year' AS founded_year,
    details->'$.website' AS website,
    CONCAT('Основана ', YEAR(CURDATE()) - CAST(details->'$.founded_year' AS UNSIGNED), ' лет назад') AS company_age
FROM producers
ORDER BY company_age DESC;

-- поиск товаров с дисплеем retina или amoled
SELECT 
    p.title,
    c.title AS category,
    p.characteristics->'$.display' AS display
FROM products p
JOIN categories c ON c.id = p.category_id
WHERE 
    JSON_SEARCH(LOWER(p.characteristics), 'one', '%amoled%', NULL, '$.display') IS NOT NULL
    OR JSON_SEARCH(LOWER(p.characteristics), 'one', '%retina%', NULL, '$.display') IS NOT NULL
ORDER BY p.title;