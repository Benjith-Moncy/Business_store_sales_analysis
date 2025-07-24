CREATE TABLE business_store (
    row_id INT,
    order_id VARCHAR(20),
    order_date DATE,
    customer_id VARCHAR(20),
    customer_name VARCHAR(20),
    product_id VARCHAR(50),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    country VARCHAR(50),
    city VARCHAR(50),
    postal_code VARCHAR(20),
    region VARCHAR(50),
    sales DECIMAL(10, 2),
    quantity INT,
    discount DECIMAL(5, 2),
    profit DECIMAL(10, 2)
);

SELECT *
FROM business_store;

-- Number of rows
SELECT COUNT(*)
FROM business_store;

-- Check date range
SELECT MIN(order_date), MAX(order_date)
FROM business_store;

-- See distinct values
SELECT DISTINCT city, region
FROM business_store;

-- Check for NULL values
SELECT *
FROM business_store
WHERE sales IS NULL or profit IS NULL;

-- Check for duplicates
SELECT order_id, COUNT(*)
FROM business_store
GROUP BY order_id
HAVING COUNT(*) >1;

-- year, month profit sum
SELECT 
 YEAR(order_date) AS year,
 MONTH(order_date) AS month,
    ROUND(SUM(sales), 2) AS Total_sales,
    ROUND(SUM(profit), 2) AS Total_profit
FROM business_store
 GROUP BY year, month;

-- profit sum by region, city
SELECT region, city, 
	ROUND(SUM(sales), 2) AS Total_sales, 
	ROUND(SUM(profit), 2) AS Total_profit
FROM business_store
   GROUP BY region, city
   ORDER BY total_profit DESC
   LIMIT 10;

-- profit sum by category, sub_category
SELECT category, sub_category,
	ROUND(SUM(sales), 2) AS Total_sales,
	ROUND(SUM(profit), 2) AS Total_profit
FROM business_store
GROUP BY category, sub_category 
ORDER BY Total_profit DESC;

-- Impact of Discounts on profit
SELECT discount,
	ROUND(AVG(profit), 2) AS Total_average,
    COUNT(*) AS Num_order
FROM business_store
	GROUP BY discount
    ORDER BY discount;
    
-- Top customer by sales, profit
SELECT customer_name,
	ROUND(SUM(sales), 2) AS Total_sales,
    ROUND(SUM(profit), 2) AS Total_profit
FROM business_store
	GROUP BY customer_name
    ORDER BY Total_sales DESC
    LIMIT 10;
    
-- Average order value
SELECT AVG(order_value) AS Avg_order_value
FROM(
	SELECT order_id,
    ROUND(SUM(sales), 2) AS order_value
	FROM business_store
    GROUP BY order_id) AS order_totals;
 
-- Loss making products
SELECT sub_category,
	ROUND(SUM(profit), 2) AS Total_profit
FROM business_store
	GROUP BY sub_category
    HAVING Total_profit <0
    ORDER BY Total_profit;
    

