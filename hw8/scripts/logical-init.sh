#!/bin/bash
set -e

until pg_isready -h postgres-master -p 5432; do
  sleep 2
done

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
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
    
    CREATE SUBSCRIPTION employees_subscription
    CONNECTION 'host=postgres-master port=5432 dbname=logical_test user=postgres password=postgres'
    PUBLICATION employees_publication;
EOSQL
