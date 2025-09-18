DELIMITER //

CREATE PROCEDURE add_new_product(
    IN p_title VARCHAR(255),
    IN p_description TEXT,
    IN p_characteristics JSON,
    IN p_producer_id INT,
    IN p_supplier_id INT,
    IN p_category_ids JSON,
    IN p_price DECIMAL(10, 2)
)
BEGIN
    DECLARE v_product_id INT;
    DECLARE v_category_id INT;
    DECLARE v_index INT;
    DECLARE v_categories_count INT;
    DECLARE v_exists INT;
    DECLARE v_error VARCHAR(255);

    -- проверки
    SELECT COUNT(*) INTO v_exists FROM producers WHERE id = p_producer_id;
    IF v_exists = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Producer not exists';
    END IF;

    SELECT COUNT(*) INTO v_exists FROM suppliers WHERE id = p_supplier_id;
    IF v_exists = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Supplier not exists';
    END IF;

    SET v_categories_count = JSON_LENGTH(p_category_ids);
    SET v_index = 0;
    WHILE v_index < v_categories_count DO
        SET v_category_id = JSON_EXTRACT(p_category_ids, CONCAT('$[', v_index, ']'));
        
        SELECT COUNT(*) INTO v_exists FROM categories WHERE id = v_category_id;
        IF v_exists = 0 THEN
            SET v_error = CONCAT('Category ID ', v_category_id, ' not exists');
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error;
        END IF;
        
        SET v_index = v_index + 1;
    END WHILE;
    
    -- транзакция со вставкой данных
    START TRANSACTION;
    
    INSERT INTO products (title, description, characteristics, producer_id, supplier_id)
    VALUES (p_title, p_description, p_characteristics, p_producer_id, p_supplier_id);
    
    SET v_product_id = LAST_INSERT_ID();
    
    SET v_index = 0;
    WHILE v_index < v_categories_count DO
        SET v_category_id = JSON_EXTRACT(p_category_ids, CONCAT('$[', v_index, ']'));
        
        INSERT INTO product_category (product_id, category_id)
        VALUES (v_product_id, v_category_id);
        
        SET v_index = v_index + 1;
    END WHILE;
    
    INSERT INTO prices (product_id, value, start_date)
    VALUES (v_product_id, p_price, CURRENT_TIMESTAMP);
    
    COMMIT;
    
    -- вывод айдишника добавленного товара
    SELECT v_product_id AS new_product_id;    
END //

DELIMITER ;