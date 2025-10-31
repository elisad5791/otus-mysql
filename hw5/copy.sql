COPY prices (product_id, value, start_date) 
FROM 'C:\Otus\dbapp\hw5\prices_data.csv' 
WITH (FORMAT csv, HEADER true, DELIMITER ',');
