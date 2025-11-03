---------
INSERT INTO producers (title, country, details) 
SELECT 
    'Producer_' || gs,
    CASE (gs % 5) 
        WHEN 0 THEN 'USA' 
        WHEN 1 THEN 'Germany' 
        WHEN 2 THEN 'China' 
        WHEN 3 THEN 'Japan' 
        ELSE 'South Korea' 
    END,
    ('{"founded_year": ' || (1950 + gs % 30) ||', "website": "company' || gs || '.com"}')::jsonb
FROM generate_series(1, 100) gs;

-----------
INSERT INTO suppliers (title, address) 
SELECT 
    'Supplier_' || gs,
    ('{"city": "City_' || (gs % 10 + 1) || '", "street": "Street_' || gs || '", "building": ' || floor(random() * 100 + 1) || '}')::jsonb
FROM generate_series(1, 50) gs;

------------
INSERT INTO products (title, description, characteristics, producer_id, supplier_id)
SELECT 
    'Product_' || gs,
    'High-quality product with advanced features. ' ||
    CASE (gs % 3)
        WHEN 0 THEN 'Includes warranty and technical support. '
        WHEN 1 THEN 'Premium version with extended functionality. '
        ELSE 'Professional grade equipment for industrial use. '
    END,
    ('{"color": "' || 
        CASE (gs % 6) 
            WHEN 0 THEN 'Black' 
            WHEN 1 THEN 'White' 
            WHEN 2 THEN 'Silver' 
            WHEN 3 THEN 'Blue'
            WHEN 4 THEN 'Red'
            ELSE 'Green'
        END || '", "is_available": ' || (gs % 10 != 0) || '}')::jsonb,
    floor(random() * 100 + 1)::int,
    floor(random() * 50 + 1)::int
FROM generate_series(1, 10000) gs;