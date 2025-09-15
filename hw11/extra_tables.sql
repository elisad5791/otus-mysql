CREATE TABLE IF NOT EXISTS categories1 (
    category_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(32) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS products1 (
    product_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(32) NOT NULL UNIQUE,
    category_id BIGINT UNSIGNED,
    price DECIMAL(10, 2) UNSIGNED NOT NULL CHECK (price > 0),
    rating DECIMAL(4,2) UNSIGNED NOT NULL CHECK (rating BETWEEN 0 AND 10),
    status ENUM('В наличии', 'Распродан') NOT NULL,
    FOREIGN KEY (category_id) REFERENCES categories1(category_id)
);
