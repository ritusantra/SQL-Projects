-- Before & After Analysis

-- 1. What is the total sales for the 4 weeks before and after 2020-06-15? What is the growth or reduction rate in actual values and percentage of sales?

-- Below query gives the week number of the date '2020-06-15'
SELECT DISTINCT week_number FROM clean_weekly_sales
WHERE week_date = '2020-06-15' and calendar_year = '2020';

WITH 8_weeks_sales AS (SELECT 
week_date, week_number, SUM(sales) AS total_sales
FROM clean_weekly_sales
WHERE week_number BETWEEN 20
 AND 27
AND calendar_year = 2020
GROUP BY week_date, week_number),
before_post_sustainable_packaging_sales AS
(SELECT 
SUM(CASE WHEN week_number BETWEEN 20 AND 23 THEN total_sales END) AS pre_sustainable_packaging_sales,
SUM(CASE WHEN week_number BETWEEN 24 AND 27 THEN total_sales END) AS post_sustainable_packaging_sales
FROM 8_weeks_sales
)
SELECT 
pre_sustainable_packaging_sales, post_sustainable_packaging_sales, post_sustainable_packaging_sales - pre_sustainable_packaging_sales AS sales_variation_actual_value,
ROUND(100*(post_sustainable_packaging_sales - pre_sustainable_packaging_sales)/pre_sustainable_packaging_sales,2) AS sales_variation_rate
FROM before_post_sustainable_packaging_sales;

-- 2. What about the entire 12 weeks before and after?
WITH 24_weeks_sales AS (SELECT 
week_date, week_number, SUM(sales) AS total_sales
FROM clean_weekly_sales
WHERE week_number BETWEEN 12 AND 36
AND calendar_year = 2020
GROUP BY week_date, week_number),
before_post_sustainable_packaging_sales AS
(SELECT 
SUM(CASE WHEN week_number BETWEEN 12 AND 23 THEN total_sales END) AS pre_sustainable_packaging_sales,
SUM(CASE WHEN week_number BETWEEN 24 AND 36 THEN total_sales END) AS post_sustainable_packaging_sales
FROM 24_weeks_sales
)
SELECT 
pre_sustainable_packaging_sales, post_sustainable_packaging_sales, post_sustainable_packaging_sales - pre_sustainable_packaging_sales AS sales_variation_actual_value,
ROUND(100*(post_sustainable_packaging_sales - pre_sustainable_packaging_sales)/pre_sustainable_packaging_sales,2) AS sales_variation_rate
FROM before_post_sustainable_packaging_sales;

-- 3. How do the sale metrics for these 2 periods before and after compare with the previous years in 2018 and 2019?

-- (i)
WITH 8_weeks_sales AS (SELECT calendar_year,
week_number, SUM(sales) AS total_sales
FROM clean_weekly_sales
WHERE week_number BETWEEN 20
 AND 27
GROUP BY calendar_year, week_number),
before_post_sustainable_packaging_sales AS
(SELECT calendar_year,
SUM(CASE WHEN week_number BETWEEN 20 AND 23 THEN total_sales END) AS pre_sustainable_packaging_sales,
SUM(CASE WHEN week_number BETWEEN 24 AND 27 THEN total_sales END) AS post_sustainable_packaging_sales
FROM 8_weeks_sales
GROUP BY calendar_year
)
SELECT calendar_year,
pre_sustainable_packaging_sales, post_sustainable_packaging_sales, post_sustainable_packaging_sales - pre_sustainable_packaging_sales AS sales_variation_actual_value,
ROUND(100*(post_sustainable_packaging_sales - pre_sustainable_packaging_sales)/pre_sustainable_packaging_sales,2) AS sales_variation_rate
FROM before_post_sustainable_packaging_sales;

-- (ii)
WITH 24_weeks_sales AS (SELECT 
calendar_year, week_number, SUM(sales) AS total_sales
FROM clean_weekly_sales
WHERE week_number BETWEEN 12 AND 36
GROUP BY calendar_year, week_number),
before_post_sustainable_packaging_sales AS
(SELECT calendar_year,
SUM(CASE WHEN week_number BETWEEN 12 AND 23 THEN total_sales END) AS pre_sustainable_packaging_sales,
SUM(CASE WHEN week_number BETWEEN 24 AND 36 THEN total_sales END) AS post_sustainable_packaging_sales
FROM 24_weeks_sales
GROUP BY calendar_year
)
SELECT calendar_year,
pre_sustainable_packaging_sales, post_sustainable_packaging_sales, post_sustainable_packaging_sales - pre_sustainable_packaging_sales AS sales_variation_actual_value,
ROUND(100*(post_sustainable_packaging_sales - pre_sustainable_packaging_sales)/pre_sustainable_packaging_sales,2) AS sales_variation_rate
FROM before_post_sustainable_packaging_sales;
