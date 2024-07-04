-- Creating the table for customer

CREATE TABLE customers (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    phone_number VARCHAR(20),
    address VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    zip_code VARCHAR(20),
    date_of_birth DATE
);


-- Drop the phone_number column 
ALTER TABLE customers
DROP COLUMN phone_number;

-- Loook into the data 
SELECT * FROM customers;

-- Create Purchases table 

CREATE TABLE purchases (
    purchase_id SERIAL PRIMARY KEY,
    customer_id INT,
    product_name VARCHAR(100),
    purchase_date DATE,
    price NUMERIC(10, 2)
);

-- Loook into the data 
SELECT * FROM purchases;


