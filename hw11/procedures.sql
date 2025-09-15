-- заполнение таблиц данными
DELIMITER //

CREATE PROCEDURE fill_products_table()
BEGIN
    DECLARE i INT;
    DECLARE j INT;
    DECLARE current_category_id BIGINT;
    DECLARE current_price DECIMAL(10,2);
    
    SET current_price = 10000;

    SET i = 1;
    WHILE i <= 20 DO
        INSERT INTO categories1 (title) 
        VALUES (CONCAT('Category ', i));
        
        SET current_category_id = LAST_INSERT_ID();
        
        SET j = 1;
        
        WHILE j <= 10000 DO
            INSERT INTO products1 (title, category_id, price, rating, status)
            VALUES (
                CONCAT('Product ', j, ' Cat ', i),
                current_category_id,
                current_price,
                ROUND(RAND() * 10, 2),
                IF(RAND() > 0.1, 'available', 'sold_out')
            );
            
            SET current_price = current_price + 1;
            SET j = j + 1;
        END WHILE;
        
        SELECT CONCAT('Category ', i, ' completed -  10 000 products') AS result;
        SET i = i + 1;
    END WHILE;
    
    SELECT 'Generation completed: 20 categories and 200 000 products' AS result;
END //

DELIMITER ;

-- постраничная выдача товаров
DELIMITER //

CREATE PROCEDURE get_products_page(IN pagination INT)
BEGIN
    DECLARE for_page INT;
    DECLARE current_offset INT;

    SET for_page = 50;
    SET current_offset = for_page * (pagination - 1);

    SELECT * FROM products1 
    ORDER BY status, price ASC
    LIMIT for_page OFFSET current_offset;
END //

DELIMITER ;
