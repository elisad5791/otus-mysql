-- самый дорогой и самый дешевый товар в каждой категории

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
    c.title AS category_title,
    (SELECT 
		GROUP_CONCAT(title SEPARATOR '; ') AS title
	FROM cte2 
    WHERE category_id = c.id AND price = (SELECT max_price FROM cte1 WHERE id = c.id)
    ) AS most_expensive_product,
    (SELECT 
		GROUP_CONCAT(title SEPARATOR '; ') AS title
	FROM cte2 
    WHERE category_id = c.id AND price = (SELECT min_price FROM cte1 WHERE id = c.id)
    ) AS cheapest_product
FROM categories c
ORDER BY c.id;
