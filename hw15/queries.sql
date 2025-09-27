-- нарастающий итог продаж по каждому магазину с группировкой по месяцам
WITH calendar AS (
    SELECT 
        DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL n MONTH), '%Y/%m') AS short_date
    FROM (
        SELECT 23 AS n UNION SELECT 22 UNION SELECT 21 UNION SELECT 20 UNION SELECT 19 UNION SELECT 18
        UNION SELECT 17 UNION SELECT 16 UNION SELECT 15 UNION SELECT 14 UNION SELECT 13 UNION SELECT 12
        UNION SELECT 11 UNION SELECT 10 UNION SELECT 9 UNION SELECT 8 UNION SELECT 7 UNION SELECT 6
        UNION SELECT 5 UNION SELECT 4 UNION SELECT 3 UNION SELECT 2 UNION SELECT 1 UNION SELECT 0
    ) months
    ORDER BY 1
),
cte AS (
    SELECT
        store_id,
        DATE_FORMAT(date, '%Y/%m') AS sale_month,
        SUM(sale_amount) AS total_amount
    FROM sales
    GROUP BY store_id, sale_month
    ORDER BY store_id, sale_month
)
SELECT 
    cte.store_id, 
    stores.address,
    calendar.short_date, 
    SUM(cte.total_amount) OVER(PARTITION BY cte.store_id ORDER BY cte.sale_month) AS running_amount
FROM calendar
LEFT JOIN cte ON cte.sale_month = calendar.short_date
LEFT JOIN stores ON stores.store_id = cte.store_id;

-- 7-дневное скользящее среднее за последний месяц по самому плодовитому магазину
WITH RECURSIVE calendar AS (
    SELECT DATE(CURDATE() - INTERVAL 1 MONTH) AS day_date
    UNION 
    
    SELECT DATE(DATE_ADD(day_date, INTERVAL 1 DAY)) AS day_date
    FROM calendar
    WHERE DATE_ADD(day_date, INTERVAL 1 DAY) < DATE(CURDATE())
),
cte1 AS (
    SELECT store_id
    FROM sales
    GROUP BY store_id
    ORDER BY SUM(sale_amount) DESC
    LIMIT 1
),
cte2 AS (
    SELECT 
        store_id, 
        calendar.day_date AS sale_day,
        COALESCE(SUM(sale_amount), 0) AS day_amount
    FROM calendar
    LEFT JOIN sales ON DATE(sales.date) = calendar.day_date
    WHERE store_id = (SELECT store_id FROM cte1) AND date >= NOW() - INTERVAL 1 MONTH
    GROUP BY store_id, sale_day
    ORDER BY sale_day
)
SELECT 
    cte2.store_id,
    stores.address,
    cte2.sale_day,
    cte2.day_amount,
    AVG(cte2.day_amount) OVER (ORDER BY cte2.sale_day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS moving_avg_7d
FROM cte2
LEFT JOIN stores ON stores.store_id = cte2.store_id;