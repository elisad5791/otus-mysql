-- запрос суммы очков с группировкой и сортировкой по годам
SELECT year_game, SUM(points) AS year_points
FROM  statistic
GROUP BY year_game
ORDER BY year_game;

-- cte показывающее тоже самое
WITH cte AS (
    SELECT year_game, SUM(points) AS year_points
    FROM statistic
    GROUP BY year_game
)
SELECT * FROM cte ORDER BY year_game;

-- используя функцию LAG вывести кол-во очков по всем игрокам за текущий год и за предыдущий
SELECT 
    player_name, 
    year_game, points AS current_year_points, 
    LAG(points) OVER (PARTITION BY player_name ORDER BY year_game) AS previous_year_points
FROM statistic;