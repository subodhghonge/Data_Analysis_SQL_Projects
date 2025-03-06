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

-- Q2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
SELECT * 
FROM sql_project_1.retail_sales
WHERE category = 'Clothing' AND quantity >=4 AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11';

-- Q3. Write a SQL query to calculate the total sales (total_sale) for each category.:
SELECT category,
	SUM(total_sale) as net_sale,
	COUNT(*) as total_order
FROM sql_project_1.retail_sales
GROUP BY category;

-- Q4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
SELECT category, ROUND(AVG(age), 2)
FROM sql_project_1.retail_sales
WHERE category='Beauty';

-- Q5. Write a SQL query to find all transactions where the total_sale is greater than 1000.:
SELECT *
FROM sql_project_1.retail_sales
WHERE total_sale > 1000;

-- Q6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
SELECT category, gender, COUNT(*) as total_transaction
FROM sql_project_1.retail_sales
GROUP BY category, gender
ORDER BY 1;

-- Q7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
SELECT
	  year,
      month,
      avg_sale
FROM
(
	SELECT YEAR(sale_date) AS year,
		   MONTH(sale_date) AS month,
		   AVG(total_sale) as avg_sale,
		   RANK() OVER(PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) as raank
	FROM sql_project_1.retail_sales
	GROUP BY year, month
) AS t1
WHERE raank = 1;

-- Q8. Write a SQL query to find the top 5 customers based on the highest total sales :
SELECT customer_id, SUM(total_sale) as total_sales
FROM sql_project_1.retail_sales
GROUP BY customer_id
ORDER BY 2 DESC
LIMIT 5;

-- Q9. Write a SQL query to find the number of unique customers who purchased items from each category.:
SELECT
	category,
    COUNT(customer_id) as unique_cust_cnt
FROM sql_project_1.retail_sales
GROUP BY category;

-- Q10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
WITH hourly_sale
AS
(
SELECT *,
	CASE
		WHEN HOUR(sale_time)<12 THEN 'Morning'
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
	END AS Shift
FROM sql_project_1.retail_sales
)
SELECT
	Shift,
	COUNT(*) as total_orders
FROM hourly_sale
GROUP BY shift;


-- *** END OF PROJECT ***-- 