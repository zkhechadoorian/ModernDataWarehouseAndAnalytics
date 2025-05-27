/*
===============================================================================
Cumulative Analysis
===============================================================================
Purpose:
    - To calculate running totals or moving averages for key metrics.
    - To track performance over time cumulatively.
    - Useful for growth analysis or identifying long-term trends.

SQL Functions Used:
    - Window Functions: SUM() OVER(), AVG() OVER()
===============================================================================
*/

-- 1. Calculate the total sales per year and the running total of sales over time 
SELECT
    order_year,
    total_sales,
    SUM(total_sales) OVER (ORDER BY order_year) AS running_total_sales,
    ROUND(AVG(avg_price) OVER (ORDER BY order_year), 2) AS moving_average_price
FROM (
    SELECT 
        EXTRACT(YEAR FROM order_date) AS order_year,
        SUM(sales_amount) AS total_sales,
        ROUND(AVG(price), 2) AS avg_price
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY EXTRACT(YEAR FROM order_date)
) t;

-- 2. Calculate the total sales per month & the running total of sales over time 
SELECT
    month,
    total_sales,
    SUM(total_sales) OVER (ORDER BY month) AS running_total_sums,
    ROUND(AVG(avg_total) OVER (ORDER BY month), 2) AS moving_average_price
FROM (
    SELECT 
        EXTRACT(MONTH FROM order_date) AS month,
        SUM(sales_amount) AS total_sales,
        AVG(price) AS avg_total
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY EXTRACT(MONTH FROM order_date)
) subquery
ORDER BY month;
