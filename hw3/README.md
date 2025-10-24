# Установка СУБД PostgreSQL

### Запущен контейнер с PostgreSQL 15

```
docker run --name my-postgres -e POSTGRES_PASSWORD=password -d -p 5432:5432 postgres:15
```

### Заходим в контейнер через командную строку, создаем БД и таблицу

```
docker exec -it my-postgres psql -U postgres

CREATE DATABASE otus;
\c otus
CREATE TABLE users (id SERIAL PRIMARY KEY, name VARCHAR(100));
INSERT INTO users (name) VALUES ('Alice'), ('Bob');
```

### Выполнение подключение также через DBeaver

### Скриншоты

[Папка со скриншотами](https://github.com/elisad5791/otus-mysql/tree/main/hw3/screenshots)