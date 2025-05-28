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

-- Explore all distinct countries and how many customers they contain
SELECT
    DISTINCT country,
    COUNT(*) AS count
FROM
    gold.dim_customers
GROUP BY 
    country
ORDER BY
    country ASC;

-- Explore all distinct genders and no. of customers per gender
SELECT 
    gender,
    COUNT(*) AS count
FROM 
    gold.dim_customers
GROUP BY 
    gender
ORDER BY 
    count DESC;

-- Explore marital status and count the number of customers in each marital status

SELECT
    marital_status,
    COUNT(*) AS count
FROM 
    gold.dim_customers
GROUP BY 
    marital_status
ORDER BY
    count DESC;

-- Explore all distinct categories, subcategories, and product names.
SELECT
    DISTINCT category,
    COUNT(DISTINCT subcategory) AS no_subcategories,
    COUNT(*) AS no_products
FROM
    gold.dim_products
GROUP BY
    category;

-- display each category with a list of its subcategories
SELECT
  category,
  string_agg(DISTINCT subcategory, ', ' ORDER BY subcategory) AS subcategories_list
FROM
  gold.dim_products
GROUP BY
  category;

SELECT
    DISTINCT category,
    subcategory,
    product_name  
FROM
    gold.dim_products
ORDER BY
    category, subcategory, product_name
LIMIT 10;

-- 5. Explore all distinct 'maintenance' values in dim_products
SELECT
    DISTINCT maintenance
FROM gold.dim_products;