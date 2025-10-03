USE otus;

DROP PROCEDURE IF EXISTS get_orders;

DELIMITER //

CREATE PROCEDURE get_orders(
    IN p_date_begin TIMESTAMP,
    IN p_date_end TIMESTAMP,
    IN p_group VARCHAR(255)
)
BEGIN
    SET p_group = COALESCE(p_group, 'product');

    SELECT 
        CASE p_group
            WHEN 'product' THEN ANY_VALUE(pr.title)
            WHEN 'category' THEN ANY_VALUE(c.title)
            WHEN 'producer' THEN ANY_VALUE(po.title)
            ELSE ANY_VALUE(pr.title)
        END AS group_title,
        MIN(p.purchase_date) AS min_purchase_date,
        MAX(p.purchase_date) AS max_purchase_date,
        SUM(pi.quantity * pi.unit_price) AS total  
    FROM purchases p
    INNER JOIN purchase_items pi ON pi.purchase_id = p.id
    INNER JOIN products pr ON pr.id = pi.product_id
    LEFT JOIN product_category pc ON pc.product_id = pr.id
    LEFT JOIN categories c ON c.id = pc.category_id
    LEFT JOIN producers po ON po.id = pr.producer_id
    WHERE (p_date_begin IS NULL OR p.purchase_date >= p_date_begin)
        AND (p_date_end IS NULL OR p.purchase_date <= p_date_end)
    GROUP BY group_title
    ORDER BY group_title;
END //

DELIMITER ;