
/*
===============================================================================
Date Range Exploration 
===============================================================================
Purpose:
    - To determine the temporal boundaries of key data points.
    - To understand the range of historical data.

SQL Functions Used:
    - MIN(), MAX(), EXTRACT(), AGE()
===============================================================================
*/

-- 1. Explore all countries our customers come from and determine the sales data range.
-- How many years of sales are available?
SELECT
    MIN(order_date) AS first_order_date,  -- Earliest order date
    MAX(order_date) AS last_order_date,   -- Latest order date
    EXTRACT(YEAR FROM AGE(MAX(order_date), MIN(order_date))) AS order_range_years, -- Calculate the difference in years between the first and last order dates
    AGE(MAX(order_date), MIN(order_date)) AS order_range -- Calculate the full time difference between the first and last order dates
FROM
    gold.fact_sales;

-- Find the date range of shipping dates
SELECT
    MIN(shipping_date) AS first_ship_date,     -- Earliest shipping date
    MAX(shipping_date) AS last_ship_date,      -- Latest shipping date
    EXTRACT(YEAR FROM AGE(MAX(shipping_date), MIN(shipping_date))) AS ship_range_years, -- Calculate the difference in years between the first and last shipping dates
    AGE(MAX(shipping_date), MIN(shipping_date)) AS ship_range -- Calculate the full time difference between the first and last shipping dates
FROM
    gold.fact_sales;

-- Find the date range between each order date and shipping date
SELECT
    MIN(shipping_date - order_date) AS first_time_to_ship,  -- Earliest time to ship  
    MAX(shipping_date - order_date) AS last_time_to_ship   -- Latest time to sip
FROM
    gold.fact_sales;

-- 2. Find the youngest and the oldest customer and their ages.
SELECT
    MIN(birth_date) AS oldest_birthdate,      -- Oldest customer's birthdate
    EXTRACT(YEAR FROM AGE(NOW(), MIN(birth_date))) AS oldest_age, -- Calculate the age of the oldest customer
    MAX(birth_date) AS youngest_birthdate,    -- Youngest customer's birthdate
    EXTRACT(YEAR FROM AGE(NOW(), MAX(birth_date))) AS youngest_age  -- Calculate the age of the youngest customer
FROM
    gold.dim_customers;