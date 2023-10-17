-- Sales Analysis

-- 1. What was the total quantity sold for all products?
SELECT p.product_id, p.product_name, SUM(s.qty) AS total_quantity_sold
FROM sales s
INNER JOIN product_details p
ON s.prod_id = p.product_id
GROUP BY p.product_id;

-- 2. What is the total generated revenue for all products before discounts?
SELECT p.product_id, p.product_name, SUM(s.qty*s.price) AS total_revenue
FROM sales s
INNER JOIN product_details p
ON s.prod_id = p.product_id
GROUP BY p.product_id;

-- 3. What was the total discount amount for all products?
SELECT p.product_id, p.product_name, SUM(s.price*s.qty*s.discount) AS total_discount_amount
FROM sales s
INNER JOIN product_details p
ON s.prod_id = p.product_id
GROUP BY p.product_id;