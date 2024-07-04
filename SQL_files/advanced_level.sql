

-- Identify customers with a high lifetime value (total spent).

SELECT 
    c.name,
    SUM(p.price) AS total_spent
FROM customers c
JOIN purchases p ON c.id = p.customer_id
GROUP BY c.name
ORDER BY total_spent DESC;


-- What is the average interval between consecutive purchases for each customer?

SELECT 
    customer_id,
    AVG(days_between_purchases) AS avg_purchase_interval
FROM (
     SELECT 
        customer_id,
        purchase_date - LAG(purchase_date) OVER (PARTITION BY customer_id ORDER BY purchase_date) AS days_between_purchases
    FROM purchases
) AS purchase_intervals
GROUP BY customer_id;

/* 
Inner query: calculates the number of days between each customer's consecutive purchases
Uses the LAG window function to find the previous purchase date for each customer
then subtracts it from the current purchase date
*/



        
-- How many customers are returning versus new each month?

WITH customer_purchase_counts AS (
    SELECT 
        c.id AS customer_id,
        EXTRACT(MONTH FROM p.purchase_date) AS month,
        COUNT(*) AS num_purchases
    FROM customers c
    JOIN purchases p ON c.id = p.customer_id
    GROUP BY c.id, month
)
SELECT 
    month,
    COUNT(CASE WHEN num_purchases > 1 THEN 1 END) AS returning_customers,
    COUNT(CASE WHEN num_purchases = 1 THEN 1 END) AS new_customers
FROM customer_purchase_counts
GROUP BY month
ORDER BY month;


-- Has the introduction of a new loyalty program affected purchase frequency?

WITH before_after_purchase_counts AS (
    SELECT 
        CASE WHEN purchase_date < '2024-03-24' THEN 'Before' ELSE 'After' END AS period,
        COUNT(*) AS num_purchases
    FROM purchases
    GROUP BY period
)
SELECT 
    period,
    num_purchases
FROM before_after_purchase_counts;


-- Which top 3 states contribute the most to total revenue?

SELECT 
    c.state,
    SUM(p.price) AS total_revenue
FROM customers c
JOIN purchases p ON c.id = p.customer_id
GROUP BY c.state
ORDER BY total_revenue DESC
LIMIT 3;

-- What is the average purchase value for different age groups of customers?

SELECT 
    CASE 
        WHEN EXTRACT(YEAR FROM age(current_date, date_of_birth)) < 18 THEN 'Teen'
        WHEN EXTRACT(YEAR FROM age(current_date, date_of_birth)) BETWEEN 18 AND 50 THEN 'Adult'
        ELSE 'Senior'
    END AS age_group,
    ROUND(AVG(p.price), 3) AS avg_purchase_value
FROM customers c
JOIN purchases p ON c.id = p.customer_id
GROUP BY age_group
ORDER BY age_group;


-- Are there seasonal trends in purchase patterns?

SELECT 
    EXTRACT(MONTH FROM purchase_date) AS month,
    AVG(price) AS avg_purchase_price
FROM purchases
GROUP BY month
ORDER BY month;


-- What is the monthly revenue growth rate over the last year?

SELECT 
    EXTRACT(MONTH FROM purchase_date) AS month,
    SUM(price) AS total_revenue,
    ROUND(
        (SUM(price) - LAG(SUM(price)) OVER (ORDER BY EXTRACT(MONTH FROM purchase_date))) / 
        LAG(SUM(price)) OVER (ORDER BY EXTRACT(MONTH FROM purchase_date)) * 100, 
        3
    ) AS revenue_growth_rate
FROM purchases
WHERE purchase_date >= CURRENT_DATE - INTERVAL '1 year'
GROUP BY month
ORDER BY month;

-- How are purchases distributed across different cities?

SELECT 
    city,
    COUNT(*) AS num_purchases
FROM customers c
JOIN purchases p ON c.id = p.customer_id
GROUP BY city
ORDER BY num_purchases DESC;










