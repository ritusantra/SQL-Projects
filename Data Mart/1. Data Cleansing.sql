-- Data Cleansing

CREATE TABLE clean_weekly_sales AS
WITH sales_data AS (SELECT str_to_date(week_date,'%d/%m/%y') AS week_date,
region, platform, segment, customer_type, transactions, sales 
FROM weekly_sales)
SELECT week_date, 
WEEK(week_date) AS week_number, MONTH(week_date) AS month_number,
YEAR(week_date) AS calendar_year,
region, platform, 
CASE WHEN 
segment = 'null' THEN 'unknown' ELSE segment END AS segment, 
CASE WHEN segment = 'null' THEN 'unknown'
WHEN segment LIKE '%1%' THEN 'Young Adults'
WHEN segment LIKE '%2%' THEN 'Middle Aged'
WHEN segment LIKE '%3%' OR segment LIKE '%4%' THEN 'Retirees'
END
AS age_band,
CASE WHEN segment = 'null' THEN 'unknown'
WHEN segment LIKE '%C%' THEN 'Couples'
WHEN segment LIKE '%F%' THEN 'Families' END AS demographic,
customer_type, transactions, sales,
ROUND(sales/transactions,2) AS avg_transaction
FROM sales_data
ORDER BY 1 DESC;