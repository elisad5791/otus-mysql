CREATE INDEX idx_prices_optimized ON prices(product_id, end_date, value);

CREATE INDEX idx_products_title ON products(id, title);