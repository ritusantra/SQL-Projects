-- Product Analysis

-- 1.What are the top 3 products by total revenue before discount?
WITH top_3_products AS (SELECT DENSE_RANK() OVER(ORDER BY qty*price DESC) AS product_rank,
prod_id, SUM(qty*price) AS revenue
FROM sales
GROUP BY prod_id)
SELECT p.product_name
FROM top_3_products tp
INNER JOIN product_details p 
ON tp.prod_id = p.product_id
WHERE tp.product_rank <= 3;

-- 2.What is the total quantity, revenue and discount for each segment?
SELECT p.segment_name, SUM(s.qty) as quantity,
SUM(s.qty*s.price) AS revenue, SUM(s.qty*s.price*s.discount) as discount
FROM sales s
INNER JOIN
product_details p
ON s.prod_id = p.product_id
GROUP BY p.segment_name;

-- 3.What is the top selling product for each segment?
WITH top_products_by_segment AS
(
SELECT p.segment_name, p.product_name, SUM(s.qty) as quantity,
DENSE_RANK() OVER(PARTITION BY p.segment_name ORDER BY SUM(s.qty) DESC) product_rank
FROM sales s
INNER JOIN
product_details p
ON s.prod_id = p.product_id
GROUP BY p.segment_name, p.product_name
) SELECT segment_name, product_name, quantity
 FROM top_products_by_segment WHERE product_rank = 1;

-- 4.What is the total quantity, revenue and discount for each category?
SELECT p.category_name, SUM(s.qty) as quantity,
SUM(s.qty*s.price) AS revenue, SUM(s.qty*s.price*s.discount) as discount
FROM sales s
INNER JOIN
product_details p
ON s.prod_id = p.product_id
GROUP BY p.category_name;

-- 5.What is the top selling product for each category?
WITH top_products_by_category AS
(
SELECT p.category_name, p.product_name, SUM(s.qty) as quantity,
DENSE_RANK() OVER(PARTITION BY p.category_name ORDER BY SUM(s.qty) DESC) product_rank
FROM sales s
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
FROM sales s
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
FROM sales s
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
ROUND(100*SUM(s.qty*s.price)/(SELECT SUM(qty*price) FROM sales),1) AS revenue
FROM sales s
INNER JOIN
product_details p
ON s.prod_id = p.product_id
GROUP BY p.category_name;

-- 9.What is the total transaction “penetration” for each product? (hint: penetration = number of transactions where at least 1 quantity of a product was purchased divided by total number of transactions)
SELECT 
s.prod_id, p.product_name,
ROUND(100*COUNT(DISTINCT txn_id)/(select count(DISTINCT txn_id) from sales),2) AS product_penetration
FROM sales s
INNER JOIN
product_details p
ON s.prod_id = p.product_id 
GROUP BY s.prod_id;

-- 10.What is the most common combination of at least 1 quantity of any 3 products in a 1 single transaction?
SELECT p1.product_name,
p2.product_name,
p3.product_name, count(*) AS combination
FROM sales a
INNER JOIN sales b
ON a.txn_id = B.txn_id
AND a.prod_id < B.prod_id
INNER JOIN sales c
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