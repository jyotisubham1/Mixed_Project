
-- Importing customer data to server

COPY customers
(id, name, email, phone_number, address, city, state, zip_code, date_of_birth)
FROM '/tmp/customers.csv' 
DELIMITER ',' CSV HEADER;


-- Importing purchase data to server

COPY purchases
(purchase_id, customer_id, product_name, purchase_date, price)
FROM '/tmp/purchases.csv' 
DELIMITER ',' CSV HEADER;
