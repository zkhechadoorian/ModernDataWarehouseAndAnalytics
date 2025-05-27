/*
===============================================================================
Dimensions Exploration
===============================================================================
Purpose:
    - To explore the structure of dimension tables.

SQL Functions Used:
    - DISTINCT
    - ORDER BY
===============================================================================
*/

-- 1. Explore all distinct countries our customers come from.
SELECT
    DISTINCT country
FROM
    gold.dim_customers;

-- 2. Explore all distinct categories, subcategories, and product names.

SELECT
    DISTINCT category
FROM
    gold.dim_products;

SELECT
    DISTINCT category,
    subcategory,
    product_name  
FROM
    gold.dim_products
ORDER BY
    category, subcategory, product_name
LIMIT 10;

--3. Explore all distinct genders
SELECT
    DISTINCT gender
FROM
    gold.dim_customers;

SELECT 
    gender,
    COUNT(*) AS count
FROM 
    gold.dim_customers
GROUP BY 
    gender
ORDER BY 
    count DESC;

-- 4. Explore marital status
SELECT 
    DISTINCT marital_status
FROM gold.dim_customers;

-- Count the number of each marital status
SELECT
    marital_status,
    COUNT(*) AS count
FROM 
    gold.dim_customers
GROUP BY 
    marital_status
ORDER BY
    count DESC;

-- 5. Explore all distinct 'maintenance' values in dim_products
SELECT
    DISTINCT maintenance
FROM gold.dim_products;