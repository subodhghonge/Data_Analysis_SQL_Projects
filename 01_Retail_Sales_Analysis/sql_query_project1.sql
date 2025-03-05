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

SELECT count(*) 
FROM sql_project_1.retail_sales;