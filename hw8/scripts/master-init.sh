#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER replicator WITH REPLICATION ENCRYPTED PASSWORD 'replicator_password';
    SELECT pg_create_physical_replication_slot('physical_slot');
    GRANT ALL PRIVILEGES ON DATABASE $POSTGRES_DB TO replicator;

    CREATE DATABASE logical_test;
    \c logical_test

    CREATE TABLE employees (
        id SERIAL PRIMARY KEY,
        name VARCHAR(100) NOT NULL,
        email VARCHAR(100) UNIQUE NOT NULL,
        department VARCHAR(50),
        salary DECIMAL(10,2),
        created_at TIMESTAMP DEFAULT NOW()
    );

    INSERT INTO employees (name, email, department, salary) VALUES
    ('Иван Иванов', 'ivan@company.com', 'IT', 75000),
    ('Петр Петров', 'petr@company.com', 'HR', 60000),
    ('Мария Сидорова', 'maria@company.com', 'Finance', 80000),
    ('Анна Козлова', 'anna@company.com', 'IT', 70000);
    
    CREATE PUBLICATION employees_publication FOR TABLE employees;
EOSQL
