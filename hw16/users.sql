CREATE USER 'client'@'localhost' IDENTIFIED BY 'client_password';
GRANT EXECUTE ON PROCEDURE otus.get_product_list TO 'client'@'localhost';

CREATE USER 'manager'@'localhost' IDENTIFIED BY 'manager_password';
GRANT EXECUTE ON PROCEDURE otus.get_orders TO 'manager'@'localhost';

FLUSH PRIVILEGES;
