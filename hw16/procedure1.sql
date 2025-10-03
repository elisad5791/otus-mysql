USE otus;

DROP PROCEDURE IF EXISTS get_product_list;

DELIMITER //

CREATE PROCEDURE get_product_list(
    IN p_category_ids VARCHAR(255),
    IN p_producer_ids VARCHAR(255),
    IN p_price_min DECIMAL(10, 2),
    IN p_price_max DECIMAL(10, 2),
    IN p_display TEXT,
    IN p_storage TEXT,
    IN p_ram TEXT,
    IN p_processor TEXT,
    IN p_sort VARCHAR(255),
    IN p_page INT,
    IN p_limit INT
)
BEGIN
    DECLARE v_offset INT;

    SET p_page = COALESCE(p_page, 1);
    SET p_limit = COALESCE(p_limit, 10);
    SET v_offset = p_limit * (p_page - 1);

    SELECT 
        p.id, 
        p.title, 
        p.description, 
        p.characteristics, 
        po.title AS producer_title,
        s.title AS supplier_title,
        GROUP_CONCAT(c.title SEPARATOR ', ') AS category_titles,
        pr.value AS price
    FROM products p
    LEFT JOIN product_category pc ON pc.product_id = p.id
    LEFT JOIN categories c ON c.id = pc.category_id
    LEFT JOIN prices pr ON pr.product_id = p.id AND pr.end_date IS NULL
    LEFT JOIN producers po ON po.id = p.producer_id
    LEFT JOIN suppliers s ON s.id = p.supplier_id  
    WHERE 
        (p_category_ids IS NULL OR FIND_IN_SET(pc.category_id, p_category_ids))
        AND (p_producer_ids IS NULL OR FIND_IN_SET(p.producer_id, p_producer_ids))
        AND (p_price_min IS NULL OR pr.value >= p_price_min)
        AND (p_price_max IS NULL OR pr.value <= p_price_max)
        AND (p_display IS NULL OR p.characteristics->>'$.display' LIKE CONCAT('%', p_display, '%'))
        AND (p_storage IS NULL OR p.characteristics->>'$.storage' LIKE CONCAT('%', p_storage, '%'))
        AND (p_ram IS NULL OR p.characteristics->>'$.ram' LIKE CONCAT('%', p_ram, '%'))
        AND (p_processor IS NULL OR p.characteristics->>'$.processor' LIKE CONCAT('%', p_processor, '%'))
    GROUP BY p.id, po.title, s.title, pr.value
    ORDER BY 
        CASE 
            WHEN p_sort = 'id' THEN p.id
            ELSE NULL
        END,
        CASE 
            WHEN p_sort = 'title' THEN p.title
            WHEN p_sort = 'producer_title' THEN po.title
            WHEN p_sort = 'supplier_title' THEN s.title
            ELSE NULL
        END,
        CASE 
            WHEN p_sort = 'price' THEN pr.value
            ELSE NULL
        END,
        p.id
    LIMIT v_offset, p_limit;
END //

DELIMITER ;
