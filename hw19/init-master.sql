CREATE USER 'repl'@'%' IDENTIFIED BY 'replpassword';
GRANT REPLICATION SLAVE ON *.* TO 'repl'@'%';

CREATE USER 'dba'@'%' IDENTIFIED BY 'dbapassword';
GRANT ALL PRIVILEGES ON *.* TO 'dba'@'%' WITH GRANT OPTION;

CREATE DATABASE important_db;
CREATE DATABASE excluded_db;

USE important_db;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    amount DECIMAL(10,2),
    status ENUM('pending', 'completed', 'cancelled'),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO users (name, email) VALUES 
('John Doe', 'john@example.com'),
('Jane Smith', 'jane@example.com');

INSERT INTO orders (user_id, amount, status) VALUES 
(1, 100.50, 'completed'),
(2, 75.25, 'pending');

USE excluded_db;
CREATE TABLE secret_data (
    id INT AUTO_INCREMENT PRIMARY KEY,
    secret_info TEXT
);

INSERT INTO secret_data (secret_info) VALUES ('This should not be replicated');