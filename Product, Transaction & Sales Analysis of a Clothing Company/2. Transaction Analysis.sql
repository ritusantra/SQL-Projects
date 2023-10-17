-- Transaction Analysis

-- 1. How many unique transactions were there?
SELECT COUNT(DISTINCT(txn_id)) AS unique_transactions FROM sales;

-- 2. What is the average unique products purchased in each transaction?
SELECT ROUND(AVG(product_count),0) AS average_unique_products
FROM (SELECT txn_id, COUNT(DISTINCT prod_id) AS product_count
FROM sales
GROUP BY txn_id) t;

-- 3. What are the 25th, 50th and 75th percentile values for the revenue per transaction?
WITH percentile_rank AS 
(SELECT txn_id, SUM(qty*price) AS revenue,
100*ROUND(PERCENT_RANK() OVER(ORDER BY SUM(qty*price)),2) AS percentile
 FROM sales 
GROUP BY txn_id)
SELECT percentile, ROUND(AVG(revenue),1) AS percentile_values
FROM percentile_rank WHERE percentile in (25,50,75)
GROUP BY percentile;

-- 4. What is the average discount value per transaction? ***
WITH average_discount AS 
(SELECT txn_id, SUM(discount) AS discount_value
FROM sales
GROUP BY txn_id)
SELECT ROUND(AVG(discount_value),1) AS average_discount_value
FROM average_discount;

-- 5. What is the percentage split of all transactions for members vs non-members?
SELECT 
CASE WHEN member = 't' THEN 'Members' else 'Non-Members' END AS member, 
ROUND(100* COUNT(DISTINCT txn_id)/(SELECT COUNT(DISTINCT txn_id) FROM sales),1) 
AS percentage_transactions
FROM sales
GROUP BY member;

-- 6. What is the average revenue for member transactions and non-member transactions?
SELECT member, ROUND(AVG(revenue),1) AS average_revenue FROM 
(SELECT 
CASE WHEN member = 't' THEN 'Member' else 'Non-Member' END AS member, txn_id,
SUM(qty*price)
AS revenue
FROM sales
GROUP BY member, txn_id) t 
GROUP BY member;

