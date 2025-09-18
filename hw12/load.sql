-- загрузка через запросы в MySQL Workbench
use otus;
SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE '/home/elisad5791/otus/dbapp/hw12/data/data-categories.csv'
INTO TABLE categories
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
IGNORE 1 LINES
(id, title, description);

LOAD DATA LOCAL INFILE '/home/elisad5791/otus/dbapp/hw12/data/data-producers.csv'
INTO TABLE producers
FIELDS TERMINATED BY '#'
OPTIONALLY ENCLOSED BY '"'
IGNORE 1 LINES
(id, title, country, details);

LOAD DATA LOCAL INFILE '/home/elisad5791/otus/dbapp/hw12/data/data-suppliers.csv'
INTO TABLE suppliers
FIELDS TERMINATED BY '#'
OPTIONALLY ENCLOSED BY '"'
IGNORE 1 LINES
(id, title, address);

LOAD DATA LOCAL INFILE '/home/elisad5791/otus/dbapp/hw12/data/data-products.csv'
INTO TABLE products
FIELDS TERMINATED BY '#'
OPTIONALLY ENCLOSED BY '"'
IGNORE 1 LINES
(id, title, description, characteristics, producer_id, supplier_id);

-- загрузка через утилиту командной строки mysqlimport

docker exec -it hw12-otusdb-1 bash
mysqlimport -u root -p --local --columns="id,product_id,category_id" --fields-terminated-by='#' --ignore-lines=1 otus /data/product_category.csv
mysqlimport -u root -p --local --columns="id,product_id,value,start_date" --fields-terminated-by=',' --ignore-lines=1 otus /data/prices.csv
