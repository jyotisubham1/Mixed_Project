

-- How many customers are there in the database?

SELECT COUNT(*) AS num_customers
FROM customers;


-- How many purchases have been made?

SELECT COUNT(*) AS num_purchases
FROM purchases;


-- What is the average purchase price?

SELECT AVG(price) AS avg_purchase_price
FROM purchases;


-- 