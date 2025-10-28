SET default_tablespace = 'tspace_fast';

-- категории
CREATE TABLE core.categories (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL UNIQUE,
    description TEXT NOT NULL
);

-- товары
CREATE TABLE core.products (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    characteristics JSONB NOT NULL,
    producer_id INT NOT NULL,
    supplier_id INT NOT NULL
);

-- таблица для множественной привязки товара к категориям
CREATE TABLE core.product_category (
    id SERIAL PRIMARY KEY,
    product_id INT NOT NULL,
    category_id INT NOT NULL,
    FOREIGN KEY (category_id) REFERENCES core.categories(id),
    FOREIGN KEY (product_id) REFERENCES core.products(id)
);

-- цены
CREATE TABLE core.prices (
    id SERIAL PRIMARY KEY,
    product_id INT NOT NULL,
    value DECIMAL(10, 2) NOT NULL CHECK (value >= 0),
    start_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    end_date TIMESTAMP NULL,
    FOREIGN KEY (product_id) REFERENCES core.products(id)
);

-- покупатели
CREATE TABLE core.customers (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    registration_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- покупки
CREATE TABLE core.purchases (
    id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    purchase_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES core.customers(id)
);

-- состав покупок
CREATE TABLE core.purchase_items (
    id SERIAL PRIMARY KEY,
    purchase_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1 CHECK (quantity >= 0),
    unit_price DECIMAL(10, 2) NOT NULL CHECK (unit_price >= 0),
    FOREIGN KEY (purchase_id) REFERENCES core.purchases(id),
    FOREIGN KEY (product_id) REFERENCES core.products(id)
);

-----------------------------------------------------------------
-----------------------------------------------------------------

SET default_tablespace = 'tspace_slow';

-- производители
CREATE TABLE ref.producers (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL UNIQUE,
    country VARCHAR(50) NOT NULL,
    details JSONB NOT NULL
);

-- поставщики
CREATE TABLE ref.suppliers (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL UNIQUE,
    address JSONB NOT NULL
);

-- телефоны
CREATE TABLE ref.phones (
    id SERIAL PRIMARY KEY,
    phone VARCHAR(20) NOT NULL CHECK (phone ~ '^\+7[0-9\-]{7,}$'),
    supplier_id INT,
    customer_id INT,
    FOREIGN KEY (supplier_id) REFERENCES ref.suppliers(id),
    FOREIGN KEY (customer_id) REFERENCES core.customers(id)
);

-- email
CREATE TABLE ref.emails (
    id SERIAL PRIMARY KEY,
    email VARCHAR(100) NOT NULL CHECK (email ~ '^[^@]+@[^@]+\.[^@]{2,}$'),
    supplier_id INT,
    customer_id INT,
    FOREIGN KEY (supplier_id) REFERENCES ref.suppliers(id),
    FOREIGN KEY (customer_id) REFERENCES core.customers(id)
);

RESET default_tablespace;

---------------------------------------------------------------------------
---------------------------------------------------------------------------

ALTER TABLE core.products 
ADD CONSTRAINT fk_products_producer 
FOREIGN KEY (producer_id) REFERENCES ref.producers(id);

ALTER TABLE core.products 
ADD CONSTRAINT fk_products_supplier 
FOREIGN KEY (supplier_id) REFERENCES ref.suppliers(id);
