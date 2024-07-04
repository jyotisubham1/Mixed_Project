

-- Who are the top 5 customers by the number of purchases?


SELECT c.name, COUNT(p.purchase_id) AS num_purchases
FROM customers c
JOIN purchases p ON c.id = p.customer_id
GROUP BY c.name
ORDER BY num_purchases DESC
LIMIT 5;


-- What is the total revenue generated from purchases?

SELECT SUM(price) AS total_revenue
FROM purchases;


-- List all customers who have made at least one purchase.

SELECT DISTINCT c.name,
FROM customers c
JOIN purchases p ON c.id = p.customer_id;

-- What are the monthly trends in purchases?

SELECT 
    EXTRACT(MONTH FROM purchase_date) AS month,
    COUNT(*) AS num_purchases
FROM purchases
GROUP BY month
ORDER BY month;




