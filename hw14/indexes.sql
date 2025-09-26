-- создание полнотекстового индекса по названию, описанию, характеристикам

ALTER TABLE products 
ADD COLUMN characteristics_text TEXT AS (
    REPLACE(REPLACE(REPLACE(JSON_EXTRACT(characteristics, '$'), '{', ' '), '}', ' '), '"', ' ')
) STORED;


CREATE FULLTEXT INDEX idx_search ON products(title, description, characteristics_text);

SELECT title, description, characteristics, MATCH(title, description, characteristics_text) AGAINST('OLED 120Гц') AS score
FROM products 
WHERE MATCH(title, description, characteristics_text) AGAINST('OLED 120Гц');


-- обычные индексы
-- индексы для join не создаем, т.к. движок InnoDB создает индексы для внешних ключей автоматически
-- на поля с ограничением UNIQUE индексы создаются автоматически, некотрые потенциальные индексы тоже уже созданы

--------------------- СПИСКИ ----------------------------------------------------------
-- query 1
CREATE INDEX idx_prices_optimized ON prices(end_date, value DESC, product_id);

-- query 2
CREATE INDEX idx_products_title ON products(title);

-- query 3
CREATE INDEX idx_suppliers_title_address ON suppliers(
    title, 
    (CAST(address->>'$.city' AS CHAR(32)) COLLATE utf8mb4_bin), 
    (CAST(address->>'$.street' AS CHAR(32)) COLLATE utf8mb4_bin), 
    (CAST(address->>'$.building' AS CHAR(32)) COLLATE utf8mb4_bin)
);

-- query 4
CREATE INDEX idx_customers_registration_name ON customers(registration_date, last_name, first_name);

------------------- КОРЗИНА -------------------------------------------------------------
-- query 5, 6
-

------------------- АНАЛИЗ ---------------------------------------------------------------
-- query 7, 8, 9
CREATE INDEX idx_purchase_items_quantity_price ON purchase_items(product_id, quantity, unit_price);

------------------- ВЫБОРКИ ---------------------------------------------------------------
-- query 10, 13
CREATE INDEX idx_products_title ON products(title);

-- query 11
CREATE INDEX idx_purchases_year_month ON purchases((YEAR(purchase_date)), (MONTH(purchase_date)));

-- query 12
CREATE INDEX idx_customers_registration ON customers((YEAR(registration_date)));