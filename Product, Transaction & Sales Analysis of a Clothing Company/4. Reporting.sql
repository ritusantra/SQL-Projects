-- Reporting Challenge

-- Creating a table to store the monthly sales
CREATE TABLE balanced_tree.sales_m (
  prod_id VARCHAR(6),
  qty INTEGER,
  price INTEGER,
  discount INTEGER,
  member VARCHAR(5),
  txn_id VARCHAR(6),
  start_txn_time TIMESTAMP
);

-- Insert the monthly report into the new table using procedure
DELIMITER $$
CREATE PROCEDURE monthly_sales_4 (m int, y int)
BEGIN
TRUNCATE sales_m;
INSERT INTO sales_m
SELECT * FROM sales
WHERE EXTRACT(MONTH FROM start_txn_time) = m
AND EXTRACT(YEAR FROM start_txn_time) = y;
END$$
DELIMITER ;

CALL monthly_sales_4(3,2021);

SELECT * FROM sales_m;

-- Procedure to execute all the SELECT statements together
DELIMITER $$
CREATE PROCEDURE auto_select ()
BEGIN
-- Product Analysis
-- 1.What are the top 3 products by total revenue before discount?
WITH top_3_products AS (SELECT DENSE_RANK() OVER(ORDER BY qty*price DESC) AS product_rank,
prod_id, SUM(qty*price) AS revenue
FROM sales_m
GROUP BY prod_id)
SELECT p.product_name
FROM top_3_products tp
INNER JOIN product_details p 
ON tp.prod_id = p.product_id
WHERE tp.product_rank <= 3;

-- 2.What is the total quantity, revenue and discount for each segment?
SELECT p.segment_name, SUM(s.qty) as quantity,
SUM(s.qty*s.price) AS revenue, SUM(s.qty*s.price*s.discount) as discount
FROM sales_m s
INNER JOIN
product_details p
ON s.prod_id = p.product_id
GROUP BY p.segment_name;

-- 3.What is the top selling product for each segment?
WITH top_products_by_segment AS
(
SELECT p.segment_name, p.product_name, SUM(s.qty) as quantity,
DENSE_RANK() OVER(PARTITION BY p.segment_name ORDER BY SUM(s.qty) DESC) product_rank
FROM sales_m s
INNER JOIN
product_details p
ON s.prod_id = p.product_id
GROUP BY p.segment_name, p.product_name
) SELECT segment_name, product_name, quantity
 FROM top_products_by_segment WHERE product_rank = 1;

-- 4.What is the total quantity, revenue and discount for each category?
SELECT p.category_name, SUM(s.qty) as quantity,
SUM(s.qty*s.price) AS revenue, SUM(s.qty*s.price*s.discount) as discount
FROM sales_m s
INNER JOIN
product_details p
ON s.prod_id = p.product_id
GROUP BY p.category_name;

-- 5.What is the top selling product for each category?
WITH top_products_by_category AS
(
SELECT p.category_name, p.product_name, SUM(s.qty) as quantity,
DENSE_RANK() OVER(PARTITION BY p.category_name ORDER BY SUM(s.qty) DESC) product_rank
FROM sales_m s
INNER JOIN
product_details p
ON s.prod_id = p.product_id
GROUP BY p.category_name, p.product_name
) SELECT category_name,
product_name,
quantity FROM top_products_by_category WHERE product_rank = 1;

-- 6.What is the percentage split of revenue by product for each segment?
WITH revenue_by_product_segment AS(
SELECT p.segment_name, p.product_name, 
SUM(s.qty*s.price) AS revenue
FROM sales_m s
INNER JOIN
product_details p
ON s.prod_id = p.product_id
GROUP BY p.segment_name, p.product_name
)
SELECT
segment_name, product_name, revenue, 
ROUND(100*revenue/SUM(revenue) OVER(PARTITION BY segment_name),2) as split_revenue_by_product_segment
FROM revenue_by_product_segment
ORDER BY segment_name, split_revenue_by_product_segment DESC;

-- 7.What is the percentage split of revenue by segment for each category?
WITH revenue_by_product_category AS(
SELECT p.category_name, p.product_name, 
SUM(s.qty*s.price) AS revenue
FROM sales_m s
INNER JOIN
product_details p
ON s.prod_id = p.product_id
GROUP BY p.category_name, p.product_name
)
SELECT
category_name, product_name, revenue, 
ROUND(100*revenue/SUM(revenue) OVER(PARTITION BY category_name),2) as split_revenue_by_product_category
FROM revenue_by_product_category
ORDER BY category_name, split_revenue_by_product_category DESC;

-- 8.What is the percentage split of total revenue by category?
SELECT p.category_name, SUM(s.qty*s.price) AS revenue,
ROUND(100*SUM(s.qty*s.price)/(SELECT SUM(qty*price) FROM sales_m),1) AS revenue
FROM sales_m s
INNER JOIN
product_details p
ON s.prod_id = p.product_id
GROUP BY p.category_name;

-- 9.What is the total transaction “penetration” for each product? (hint: penetration = number of transactions where at least 1 quantity of a product was purchased divided by total number of transactions)
SELECT 
s.prod_id, p.product_name,
ROUND(100*COUNT(DISTINCT txn_id)/(select count(DISTINCT txn_id) from sales_m),2) AS product_penetration
FROM sales_m s
INNER JOIN
product_details p
ON s.prod_id = p.product_id 
GROUP BY s.prod_id;

-- 10.What is the most common combination of at least 1 quantity of any 3 products in a 1 single transaction?
SELECT p1.product_name,
p2.product_name,
p3.product_name, count(*) AS combination
FROM sales_m a
INNER JOIN sales_m b
ON a.txn_id = B.txn_id
AND a.prod_id < B.prod_id
INNER JOIN sales_m c
ON c.txn_id = B.txn_id AND c.txn_id = a.txn_id
AND c.prod_id < B.prod_id AND c.prod_id < a.prod_id 
INNER JOIN product_details p1
ON p1.product_id = a.prod_id
INNER JOIN product_details p2
ON p2.product_id = b.prod_id
INNER JOIN product_details p3
ON p3.product_id = c.prod_id
GROUP BY p1.product_name,
p2.product_name,
p3.product_name
ORDER BY combination DESC;

-- Transaction Analysis

-- 1. How many unique transactions were there?
SELECT COUNT(DISTINCT(txn_id)) AS unique_transactions FROM sales_m;

-- 2. What is the average unique products purchased in each transaction?
SELECT ROUND(AVG(product_count),0) AS average_unique_products
FROM (SELECT txn_id, COUNT(DISTINCT prod_id) AS product_count
FROM sales_m
GROUP BY txn_id) t;

-- 3. What are the 25th, 50th and 75th percentile values for the revenue per transaction?
WITH percentile_rank AS 
(SELECT txn_id, SUM(qty*price) AS revenue,
100*ROUND(PERCENT_RANK() OVER(ORDER BY SUM(qty*price)),2) AS percentile
 FROM sales_m 
GROUP BY txn_id)
SELECT percentile, ROUND(AVG(revenue),1) AS percentile_values
FROM percentile_rank WHERE percentile in (25,50,75)
GROUP BY percentile;

-- 4. What is the average discount value per transaction? ***
WITH average_discount AS 
(SELECT txn_id, SUM(discount) AS discount_value
FROM sales_m
GROUP BY txn_id)
SELECT ROUND(AVG(discount_value),1) AS average_discount_value
FROM average_discount;

-- 5. What is the percentage split of all transactions for members vs non-members?
SELECT 
CASE WHEN member = 't' THEN 'Members' else 'Non-Members' END AS member, 
ROUND(100* COUNT(DISTINCT txn_id)/(SELECT COUNT(DISTINCT txn_id) FROM sales_m),1) 
AS percentage_transactions
FROM sales_m
GROUP BY member;

-- 6. What is the average revenue for member transactions and non-member transactions?
SELECT member, ROUND(AVG(revenue),1) AS average_revenue FROM 
(SELECT 
CASE WHEN member = 't' THEN 'Member' else 'Non-Member' END AS member, txn_id,
SUM(qty*price)
AS revenue
FROM sales_m
GROUP BY member, txn_id) t 
GROUP BY member;

-- sales_m Analysis

-- 1. What was the total quantity sold for all products?
SELECT p.product_id, p.product_name, SUM(s.qty) AS total_quantity_sold
FROM sales_m s
INNER JOIN product_details p
ON s.prod_id = p.product_id
GROUP BY p.product_id;

-- 2. What is the total generated revenue for all products before discounts?
SELECT p.product_id, p.product_name, SUM(s.qty*s.price) AS total_revenue
FROM sales_m s
INNER JOIN product_details p
ON s.prod_id = p.product_id
GROUP BY p.product_id;

-- 3. What was the total discount amount for all products?
SELECT p.product_id, p.product_name, SUM(s.price*s.qty*s.discount) AS total_discount_amount
FROM sales_m s
INNER JOIN product_details p
ON s.prod_id = p.product_id
GROUP BY p.product_id;
end$$
DELIMITER ;

CALL monthly_sales_4(3,2021);
SELECT * FROM sales_m;
CALL auto_select();

-- Procedure to combine this two procedure and get the monthly report
DELIMITER $$
CREATE PROCEDURE report(m int, y int)
BEGIN
	CALL monthly_sales_4(m,y);
	CALL auto_select();
END$$
DELIMITER ;

-- Execute the procedure with year and month for generating the report
CALL report(3,2021);


