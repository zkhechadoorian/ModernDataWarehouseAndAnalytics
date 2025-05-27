/*
===============================================================================
Ranking Analysis
===============================================================================
Purpose:
    - To rank items (e.g., products, customers) based on performance or other metrics.
    - To identify top performers or laggards.

SQL Functions Used:
    - Window Ranking Functions: RANK(), DENSE_RANK(), ROW_NUMBER()
    - Clauses: GROUP BY, ORDER BY, LIMIT
===============================================================================
*/

\echo
\echo Which 5 products generate the highest revenue? (Simple Ranking)
\echo

-- 1. Which 5 products generate the highest revenue? (Simple Ranking)
SELECT
    p.product_name, 
    COUNT(DISTINCT f.order_number) as total_units_sold,
    SUM(f.sales_amount) AS total_revenue
FROM 
    gold.fact_sales f
LEFT JOIN gold.dim_products p
    ON f.product_key = p.product_key
GROUP BY p.product_name
ORDER BY total_revenue DESC
LIMIT 5;

\echo
\echo Complex but Flexible Ranking Using Window Functions (Top 5)
\echo

-- 2. Complex but Flexible Ranking Using Window Functions (Top 5)
SELECT
    p.product_name, 
    SUM(f.sales_amount) AS total_revenue,
    ROW_NUMBER() OVER (ORDER BY SUM(f.sales_amount) DESC) AS rank_product
FROM 
    gold.fact_sales f
LEFT JOIN gold.dim_products p
    ON f.product_key = p.product_key
GROUP BY p.product_name
ORDER BY rank_product DESC
LIMIT 5;  

\echo
\echo What are the 5 worst-performing products in terms of sales?
\echo

-- 3. What are the 5 worst-performing products in terms of sales?
SELECT
    p.product_name,  -- Corrected typo
    SUM(f.sales_amount) AS total_revenue
FROM 
    gold.fact_sales f
LEFT JOIN gold.dim_products p
    ON f.product_key = p.product_key
GROUP BY p.product_name
ORDER BY total_revenue ASC  
LIMIT 5;

\echo
\echo Find the top 10 customers who have generated the highest revenue
\echo

-- 4. Find the top 10 customers who have generated the highest revenue
SELECT 
    c.customer_key, 
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    SUM(f.sales_amount) AS total_revenue
FROM 
    gold.fact_sales f
LEFT JOIN gold.dim_customers c
    ON f.customer_key = c.customer_key
GROUP BY 
    c.customer_key,  -- Or c.customer_id
    full_name
ORDER BY 
    total_revenue DESC
LIMIT 
    10;

\echo
\echo The 3 customers with the fewest orders placed
\echo

-- 5. The 3 customers with the fewest orders placed
SELECT
    c.customer_key,  -- Or c.customer_id
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    COUNT(DISTINCT f.order_number) AS total_orders  
FROM 
    gold.fact_sales f
LEFT JOIN gold.dim_customers c
    ON f.customer_key = c.customer_key
GROUP BY
    c.customer_key,  
    full_name
ORDER BY 
    total_orders ASC  
LIMIT 
    3;