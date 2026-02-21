-- create table 

CREATE TABLE retail_sales(
         transactions_id INT PRIMARY KEY,	
		 sale_date DATE	,
		 sale_time	TIME,
		 customer_id INT,
		 gender VARCHAR(50),
		 age INT,
		 category VARCHAR(50),
		 quantiy INT,
		 price_per_unit	FLOAT,
		 cogs	FLOAT,
		 total_sale FLOAT
);

SELECT *FROM retail_sales
LIMIT 10;

SELECT COUNT(*) FROM retail_sales;

-- Data Cleaning

SELECT COUNT(*) FROM retail_sales
WHERE transactionS_id IS NULL;

SELECT*FROM retail_sales
WHERE sale_date IS NULL;

SELECT*FROM retail_sales
WHERE sale_time IS NULL;

SELECT * FROM retail_sales
WHERE customer_id IS NULL;

SELECT * FROM retail_sales
WHERE gender IS NULL;

SELECT * FROM retail_sales
WHERE age IS NULL;

SELECT * FROM retail_sales
WHERE  transactionS_id IS NULL
        OR
        sale_date IS NULL
		OR
        sale_time IS NULL
		OR
        customer_id IS NULL
		OR
        gender IS NULL
		OR
        age IS NULL
		OR
        category IS NULL
		OR
        quantiy IS NULL
		OR
        price_per_unit IS NULL
		OR
		cogs IS NULL
		OR
		total_sale IS NULL ;

DELETE FROM retail_sales
WHERE  transactionS_id IS NULL
        OR
        sale_date IS NULL
		OR
        sale_time IS NULL
		OR
        customer_id IS NULL
		OR
        gender IS NULL
		OR
        age IS NULL
		OR
        category IS NULL
		OR
        quantiy IS NULL
		OR
        price_per_unit IS NULL
		OR
		cogs IS NULL
		OR
		total_sale IS NULL ;
		
--- Data Exploration

-- How many sales we have?
SELECT COUNT(*) AS total_sale FROM retail_sales;

-- how many unique customer we have?
SELECT COUNT( DISTINCT customer_id)  FROM retail_sales;

-- how many unique category we have?
SELECT COUNT( DISTINCT category) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

-- data analysis & business key problems ans answers
-- My analysis ans findings

-- Q.01.write a sql query to retrive all columns for sale made on '2022-11-05'
SELECT * FROM retail_sales
WHERE sale_date='2022-11-05';

--Q.02. write a sql query to retrive all transaction where the category is 'clothing' and the quantity sold is more than 10 in the month of nov-2022

SELECT * FROM retail_sales
WHERE category='Clothing' AND TO_CHAR(sale_date,'YYYY-MM')='2022-11'
AND quantiy >=4;

-- Q.03.write a sql query to calculate the total sale for each category
SELECT category, SUM(total_sale) AS net_sale,
       COUNT(*) AS total_orders
FROM retail_sales
GROUP BY 1; 

-- Q.04.write a sql query to find the average age of cutomer who purchesed item from the beauty category
SELECT  ROUND(AVG(age),2) AS avg_age 
FROM retail_sales
WHERE category='Beauty';

-- Q.05.write a sql query to find all transaction where the total_sale is greater than 1000.
SELECT * FROM retail_sales
WHERE total_sale >=1000;

--Q.06. write a sql query to find the total number of transaction (transaction_id )made by each gender in each category
SELECT category , gender , 
      COUNT(*) AS total_no_of_transaction 
FROM retail_sales
GROUP BY category , gender 
ORDER BY 1;

--Q.07.write a sql query to calculate the average sale for each month. find out best selling month in each year.
SELECT 
      year, month,avg_sale
FROM(
   SELECT EXTRACT (YEAR  FROM sale_date)AS year,
          EXTRACT (MONTH  FROM sale_date)AS month,
          AVG(total_sale)AS avg_sale,
         RANK()OVER(PARTITION BY  EXTRACT (YEAR  FROM sale_date)ORDER BY AVG(total_sale) DESC)
   FROM retail_sales
  GROUP BY 1,2
  ORDER BY 1,3 DESC
  ) AS t1
WHERE RANK=1;





--Q.08.write a sql query th find the top 5 customers based on the highest total sale
SELECT 
       customer_id,
       SUM(total_sale) AS high_total_sale 
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

--Q.09. write a sql query to find the no. of unique customer who purchesed item from each category
SELECT
	CATEGORY,
	COUNT(DISTINCT CUSTOMER_ID) AS UNIQUE_CUS
FROM RETAIL_SALES
GROUP BY CATEGORY;

-- Q.10. write sql query to create each shift and no. of orders(example morning<=12,afternoon between 12&17, evining>17)
WITH HOURLY_SALE AS (
		SELECT *,
			CASE WHEN EXTRACT(HOUR FROM SALE_TIME) < 12 THEN 'morning'
				 WHEN EXTRACT(HOUR FROM SALE_TIME) BETWEEN 12 AND 17  THEN 'afternoon'
				ELSE 'evening'
			END AS SHIFT
		FROM
			RETAIL_SALES
	              )
SELECT
	SHIFT,
	COUNT(*) AS TOTAL_ORDERS
FROM HOURLY_SALE
GROUP BY SHIFT;




