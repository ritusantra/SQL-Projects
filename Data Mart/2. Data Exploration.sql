-- Data Exploration

-- 1. What day of the week is used for each week_date value?
SELECT DISTINCT dayname(week_date) AS day_name
FROM clean_weekly_sales;

-- 2. What range of week numbers are missing from the dataset?
SELECT MIN(week_number) AS week_range_in_data
FROM clean_weekly_sales
UNION
SELECT MAX(week_number) AS week_range
FROM clean_weekly_sales;

-- 3. How many total transactions were there for each year in the dataset?
SELECT calendar_year, SUM(transactions) AS total_transactions
FROM clean_weekly_sales
GROUP BY calendar_year
ORDER BY 2 DESC;

-- 4. What is the total sales for each region for each month?
SELECT region, month_number, SUM(sales) AS total_sales
FROM clean_weekly_sales
GROUP BY region, month_number
ORDER BY 1,2;

-- 5. What is the total count of transactions for each platform
SELECT platform, SUM(transactions) AS total_transactions
FROM clean_weekly_sales
GROUP BY platform;

-- 6. What is the percentage of sales for Retail vs Shopify for each month?
SELECT calendar_year, month_number,
ROUND(100*SUM(CASE WHEN platform = 'Retail' THEN sales END)/SUM(sales),2) AS retail_sales,
ROUND(100*SUM(CASE WHEN platform = 'Shopify' THEN sales END)/SUM(sales),2) AS shopify_sales
FROM clean_weekly_sales
GROUP BY calendar_year, month_number
ORDER by calendar_year, month_number;

-- 7. What is the percentage of sales by demographic for each year in the dataset?
SELECT calendar_year,
ROUND(100*SUM(CASE WHEN demographic = 'Couples' THEN sales ELSE NULL END)/SUM(sales),2) AS percentage_of_sales_couples,
ROUND(100*SUM(CASE WHEN demographic = 'Families' THEN sales ELSE NULL END)/SUM(sales),2)  AS percentage_of_sales_families,
ROUND(100*SUM(CASE WHEN demographic = 'unknown' THEN sales ELSE NULL END)/SUM(sales),2) AS percentage_of_sales_unknown
FROM clean_weekly_sales
GROUP BY calendar_year
ORDER BY calendar_year;

-- 8. Which age_band and demographic values contribute the most to Retail sales?
SELECT age_band, demographic, SUM(sales) AS total_sales,
ROUND(100*SUM(sales)/(SELECT SUM(sales) from clean_weekly_sales),2) AS percentage_of_sales
FROM clean_weekly_sales
WHERE platform = 'Retail'
GROUP BY age_band, demographic
ORDER BY SUM(sales) DESC;


-- 9. Can we use the avg_transaction column to find the average transaction size for each year for Retail vs Shopify? If not - how would you calculate it instead?
SELECT calendar_year, platform,
ROUND(AVG(avg_transaction),2) AS average_of_avg_transaction,
ROUND(SUM(sales)/SUM(transactions),2) AS average_transaction_size
FROM clean_weekly_sales
GROUP BY calendar_year, platform;
