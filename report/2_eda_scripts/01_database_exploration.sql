/*
===============================================================================
Database Exploration
===============================================================================
Purpose:
    - To explore the structure of the database, including the list of tables and their schemas.
    - To inspect the columns and metadata for specific tables.

Table Used:
    - INFORMATION_SCHEMA.TABLES
    - INFORMATION_SCHEMA.COLUMNS
===============================================================================
*/

\pset pager on 
-- if on, ouput that is too big is piped through a pager program
\setenv PAGER 'less -S' 
-- disable line wrapping
-- \x
-- expanded display

-- Get current database
SELECT current_database();

-- List all user tables
SELECT table_schema, table_name
FROM information_schema.tables
WHERE table_type = 'BASE TABLE'
  AND table_schema NOT IN ('pg_catalog', 'information_schema')
ORDER BY table_schema, table_name;

-- Explore All Columns in the Database
SELECT 
	*
FROM 
	INFORMATION_SCHEMA.COLUMNS
WHERE 
	TABLE_NAME= 'dim_customers';

-- Explore details about foreign key relationships
SELECT 
	*
FROM
	INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS;

-- Explore information about shemas in the database
SELECT 
	*
FROM
	INFORMATION_SCHEMA.SCHEMATA;

-- Explore All Objects in the Database
-- SELECT 
-- 	*
-- FROM 
-- 	INFORMATION_SCHEMA.TABLES;

-- Describe dim_customers table
\d gold.dim_customers
\d gold.dim_products
\d gold.fact_sales

