USE SAKILA;

-- Step 1: Create a view that summarizes rental information for each customer
DROP VIEW IF EXISTS rental_summary;
CREATE VIEW rental_summary AS
SELECT 
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    c.email,
    COUNT(r.rental_id) AS rental_count
FROM
    customer c
JOIN
    rental r ON c.customer_id = r.customer_id
GROUP BY
    c.customer_id, c.first_name, c.last_name, c.email;

-- Step 1: Create a view that summarizes rental information for each customer
CREATE VIEW rental_summary AS
SELECT 
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    c.email,
    COUNT(r.rental_id) AS rental_count
FROM
    customer c
JOIN
    rental r ON c.customer_id = r.customer_id
GROUP BY
    c.customer_id, c.first_name, c.last_name, c.email;

-- Step 3: Create a CTE and the final Customer Summary Report
WITH customer_summary_cte AS (
    SELECT 
        c.customer_name,
        c.email,
        c.rental_count,
        cps.total_paid,
        cps.total_paid / c.rental_count AS average_payment_per_rental
    FROM
        rental_summary c
    JOIN
        customer_payment_summary cps ON c.customer_id = cps.customer_id
)
-- Final query to generate the customer summary report
SELECT 
    customer_name,
    email,
    rental_count,
    total_paid,
    average_payment_per_rental
FROM
    customer_summary_cte
ORDER BY
    rental_count DESC;
