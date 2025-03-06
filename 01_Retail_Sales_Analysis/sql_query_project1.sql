CREATE DATABASE sql_project_1;

drop table if exists retail_sales;
CREATE TABLE retail_sales
		(
			transaction_id INT PRIMARY KEY,
			sale_date DATE,
			sale_time TIME,
			customer_id INT,
			gender VARCHAR(10),
			age INT,
			category VARCHAR(20),
			quantity INT,
			price_per_sale FLOAT,
			cogs FLOAT,
			total_sale INT
		);
         
SELECT * FROM sql_project_1.retail_sales
LIMIT 10;

-- Total Count of rows
SELECT count(*) 
FROM sql_project_1.retail_sales;

-- Check Null Values in all column
SELECT * FROM sql_project_1.retail_sales
WHERE
    transaction_id IS NULL
        OR sale_date IS NULL
        OR sale_time IS NULL
        OR customer_id IS NULL
        OR gender IS NULL
        OR age IS NULL
        OR category IS NULL
        OR quantity IS NULL
        OR price_per_sale IS NULL
        OR cogs IS NULL
        OR total_sale IS NULL;

-- Delete all Null Values from all columns
DELETE FROM sql_project_1.retail_sales 
WHERE
    transaction_id IS NULL
    OR sale_date IS NULL
    OR sale_time IS NULL
    OR customer_id IS NULL
    OR gender IS NULL
    OR age IS NULL
    OR category IS NULL
    OR quantity IS NULL
    OR price_per_sale IS NULL
    OR cogs IS NULL
    OR total_sale IS NULL;

--  ***Data Exploration ***

-- How Many Sales We Have?
SELECT COUNT(*) as total_sales FROM sql_project_1.retail_sales;

-- How Many unique Customer We Have?
SELECT COUNT(DISTINCT customer_id) as total_sales FROM sql_project_1.retail_sales;

-- How Many Distinct Category We Have?
SELECT DISTINCT category FROM sql_project_1.retail_sales;

--  ***Data Analysis***

-- Q1. Write a SQL query to retrieve all columns for sales made on '2022-11-05':
SELECT * 
FROM sql_project_1.retail_sales
WHERE sale_date = '2022-11-05'; 

-- Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
SELECT * 
FROM sql_project_1.retail_sales
WHERE category = 'Clothing' AND quantity >=4 AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11';
