-- РОЛИ

-- полные права на базу otus
CREATE ROLE otus_admin;
GRANT ALL PRIVILEGES ON DATABASE otus TO otus_admin;
GRANT USAGE ON SCHEMA core, ref TO otus_admin;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA core, ref TO otus_admin;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA core, ref TO otus_admin;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA core, ref TO otus_admin;
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA core, ref TO otus_admin;
GRANT ALL PRIVILEGES ON ALL PROCEDURES IN SCHEMA core, ref TO otus_admin;

-- только чтение базы otus
CREATE ROLE otus_reader;
GRANT CONNECT ON DATABASE otus TO otus_reader;
GRANT USAGE ON SCHEMA core, ref TO otus_reader;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA core, ref TO otus_reader;
GRANT SELECT ON ALL TABLES IN SCHEMA core, ref TO otus_reader;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA core, ref TO otus_reader;


-- ПОЛЬЗОВАТЕЛИ

CREATE USER admin_user WITH PASSWORD 'admin_user';
GRANT otus_admin TO admin_user;

CREATE USER reader_user WITH PASSWORD 'reader_user';
GRANT otus_reader TO reader_user;
