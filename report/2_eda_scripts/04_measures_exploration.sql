/*
===============================================================================
Measures Exploration (Key Metrics)
===============================================================================
Purpose:
    - To calculate aggregated metrics (e.g., totals, averages) for quick insights.
    - To identify overall trends or spot anomalies.

SQL Functions Used:
    - COUNT(), SUM(), AVG(), DISTINCT()
===============================================================================
*/

-- 1. Find the Total Sales
SELECT 
    SUM(sales_amount) AS total_sales_amount  
FROM 
    gold.fact_sales;


-- 2. Find how many items are sold
SELECT 
    SUM(quantity) AS total_quantity  
FROM 
    gold.fact_sales;


-- 3. Find the average selling price
SELECT 
    AVG(price) AS avg_price 
FROM 
    gold.fact_sales;


-- 4. Find the Total number of Orders
SELECT 
    COUNT(DISTINCT order_number) AS total_orders 
FROM
    gold.fact_sales;

-- 5. Find the total number of products
SELECT 
    COUNT(DISTINCT product_key) AS total_products 
FROM
    gold.fact_sales;

-- 6. Find the total number of customers that have placed an order 
SELECT 
    COUNT(DISTINCT customer_key) AS total_customers_with_orders
FROM
    gold.fact_sales;

-- Find the total number of orders by country
SELECT
    c.country,
    COUNT(DISTINCT s.order_number) AS total_orders_by_country,
    SUM(s.sales_amount) AS total_sales_by_country
FROM
    gold.dim_customers c
JOIN
    gold.fact_sales s ON c.customer_key = s.customer_key
GROUP BY
    c.country;

-- Find the total orders and sales by product category
SELECT
    p.category,
    COUNT(DISTINCT s.order_number) AS total_orders_by_category,
    SUM(s.sales_amount) AS total_sales_by_category
FROM
    gold.dim_products p
JOIN
    gold.fact_sales s ON p.product_key = s.product_key
GROUP BY
    p.category;

-- Find the total sales by product category broken down by year
SELECT
    p.category,
    EXTRACT(YEAR FROM s.order_date) AS year,
    COUNT(DISTINCT s.order_number) AS total_orders_by_category,
    SUM(s.sales_amount) AS total_sales_by_category
FROM
    gold.dim_products p
JOIN
    gold.fact_sales s ON p.product_key = s.product_key
GROUP BY
    p.category,
    EXTRACT(YEAR FROM s.order_date)
ORDER BY
    p.category,
    year;


-- Find total sales per gender
SELECT
    c.gender,
    COUNT(DISTINCT s.order_number) as total_orders_by_gender,
    SUM(s.sales_amount) AS total_sales_by_gender
FROM
    gold.dim_customers c
JOIN
    gold.fact_sales s ON c.customer_key = s.customer_key
GROUP BY 
    c.gender;

-- Find total sales per marital status
SELECT
    c.marital_status,
    COUNT(DISTINCT c.customer_key) as total_customers_by_status,
    COUNT(DISTINCT s.order_number) as total_orders_by_status,
    SUM(s.sales_amount) AS total_sales_by_status
FROM
    gold.dim_customers c
JOIN
    gold.fact_sales s ON c.customer_key = s.customer_key
GROUP BY 
    c.marital_status;

-- 7. Generate a Report that shows all key metrics of the business
SELECT 'Total Sales' AS measure_name, SUM(sales_amount) AS measure_values FROM gold.fact_sales
UNION ALL
SELECT 'Total Quantity', SUM(quantity) FROM gold.fact_sales 
UNION ALL
SELECT 'Avg Price', AVG(price) FROM gold.fact_sales
UNION ALL
SELECT 'Total No. Orders', COUNT(DISTINCT order_number) FROM gold.fact_sales
UNION ALL
SELECT 'Total No. Products', COUNT(DISTINCT product_key) FROM gold.fact_sales
UNION ALL
SELECT 'Total No. Customers with Orders', COUNT(DISTINCT customer_key) FROM gold.fact_sales; 