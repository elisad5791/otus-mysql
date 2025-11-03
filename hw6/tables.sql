-- производители
CREATE TABLE producers (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL UNIQUE,
    country VARCHAR(50) NOT NULL,
    details JSONB NOT NULL
);

-- поставщики
CREATE TABLE suppliers (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL UNIQUE,
    address JSONB NOT NULL
);

-- товары
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    characteristics JSONB NOT NULL,
    producer_id INT NOT NULL,
    supplier_id INT NOT NULL,
    FOREIGN KEY (producer_id) REFERENCES producers(id),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(id)
);
