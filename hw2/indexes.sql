-- Возможные индексы для соединений в запросах

CREATE INDEX idx_prices_product_id ON prices(product_id, end_date); -- еще и для фильтрации по end_date

CREATE INDEX idx_products_producer_supplier ON products(producer_id, supplier_id);

CREATE INDEX idx_product_category_id ON product_category(category_id);
CREATE INDEX idx_product_product_id ON product_category(product_id);

CREATE INDEX idx_phones_supplier_id ON phones(supplier_id);
CREATE INDEX idx_phones_customer_id ON phones(customer_id);

CREATE INDEX idx_emails_supplier_id ON emails(supplier_id);
CREATE INDEX idx_emails_customer_id ON emails(customer_id);

CREATE INDEX idx_purchases_customer_id ON purchases(customer_id);

CREATE INDEX idx_purchase_items_purchase_id ON purchase_items(purchase_id);
CREATE INDEX idx_purchase_items_product_id ON purchase_items(product_id);

-- Возможные индексы для сортировки

CREATE INDEX idx_products_title ON products(title);
CREATE INDEX idx_customers_name ON customers(first_name, last_name);
CREATE INDEX idx_suppliers_title ON suppliers(title);
CREATE INDEX idx_purchases_purchase_date ON purchases(purchase_date);

-- индексы используются при больших данных
-- надо смотреть explain, оставлять те, которые база берет в работу
