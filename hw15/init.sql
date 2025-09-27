SET NAMES utf8mb4;

CREATE database otus;
USE otus;

CREATE TABLE stores (
    store_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    address VARCHAR(50) NOT NULL
);

CREATE TABLE sales (
    sale_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    store_id BIGINT UNSIGNED NOT NULL,
    date TIMESTAMP NOT NULL,
    sale_amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (store_id) REFERENCES stores(store_id)
);
