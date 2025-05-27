/*
================================================================
CREATE DATABASE & SCHEMAS
================================================================
Script Purpose:
    This script creates a new database named 'zkhechadoorian' after checking if it already exists.
    First, it terminates active connections if the database is active, then it is dropped and recreated.
    Additionally, the script sets up three schemas within the database: 'bronze', 'silver', and 'gold'.

WARNING:
    Running this script will drop the entire 'zkhechadoorian' database if it exists.
    All data in the database will be permanently deleted. Proceed with caution
    and ensure you have proper backups before running this script.

How to use:
    Before running this script, make sure to update the project_dir in config.sql
    to match your environment.
*/
-- Load configuration
\i ./config.sql

-- Terminate active connections to the 'zkhechadoorian' database
-- Avoid terminating the current connection
SELECT pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE datname = 'zkhechadoorian' AND pid <> pg_backend_pid(); 

-- Drop the database if it exists
DROP DATABASE IF EXISTS zkhechadoorian;

-- Recreate the database
CREATE DATABASE zkhechadoorian;

-- Connect to the newly created database
\c zkhechadoorian;

-- Create Schemas
CREATE SCHEMA bronze;
CREATE SCHEMA silver;
CREATE SCHEMA gold;
