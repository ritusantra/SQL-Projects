-- Bonus Question

WITH region_sales AS (SELECT region,
week_date, week_number, SUM(sales) AS total_sales
FROM clean_weekly_sales
WHERE week_number BETWEEN 12 AND 36
AND calendar_year = 2020
GROUP BY region, week_date, week_number),
before_post_sustainable_packaging_sales_regions AS
(SELECT region,
SUM(CASE WHEN week_number BETWEEN 12 AND 23 THEN total_sales END) AS pre_sustainable_packaging_sales,
SUM(CASE WHEN week_number BETWEEN 24 AND 36 THEN total_sales END) AS post_sustainable_packaging_sales
FROM region_sales group by region
),
platform_sales AS (SELECT platform,
week_date, week_number, SUM(sales) AS total_sales
FROM clean_weekly_sales
WHERE week_number BETWEEN 12 AND 36
AND calendar_year = 2020
GROUP BY platform, week_date, week_number),
before_post_sustainable_packaging_sales_platform AS
(SELECT platform,
SUM(CASE WHEN week_number BETWEEN 12 AND 23 THEN total_sales END) AS pre_sustainable_packaging_sales,
SUM(CASE WHEN week_number BETWEEN 24 AND 36 THEN total_sales END) AS post_sustainable_packaging_sales
FROM platform_sales group by platform
),
age_sales AS (SELECT age_band,
week_date, week_number, SUM(sales) AS total_sales
FROM clean_weekly_sales
WHERE week_number BETWEEN 12 AND 36
AND calendar_year = 2020
GROUP BY age_band, week_date, week_number),
before_post_sustainable_packaging_sales_age AS
(SELECT age_band,
SUM(CASE WHEN week_number BETWEEN 12 AND 23 THEN total_sales END) AS pre_sustainable_packaging_sales,
SUM(CASE WHEN week_number BETWEEN 24 AND 36 THEN total_sales END) AS post_sustainable_packaging_sales
FROM age_sales group by age_band
),
demographic_sales AS (SELECT demographic,
week_date, week_number, SUM(sales) AS total_sales
FROM clean_weekly_sales
WHERE week_number BETWEEN 12 AND 36
AND calendar_year = 2020
GROUP BY demographic, week_date, week_number),
before_post_sustainable_packaging_sales_demographic AS
(SELECT demographic,
SUM(CASE WHEN week_number BETWEEN 12 AND 23 THEN total_sales END) AS pre_sustainable_packaging_sales,
SUM(CASE WHEN week_number BETWEEN 24 AND 36 THEN total_sales END) AS post_sustainable_packaging_sales
FROM demographic_sales group by demographic
),
customer_sales AS (SELECT customer_type,
week_date, week_number, SUM(sales) AS total_sales
FROM clean_weekly_sales
WHERE week_number BETWEEN 12 AND 36
AND calendar_year = 2020
GROUP BY customer_type, week_date, week_number),
before_post_sustainable_packaging_sales_customer AS
(SELECT customer_type,
SUM(CASE WHEN week_number BETWEEN 12 AND 23 THEN total_sales END) AS pre_sustainable_packaging_sales,
SUM(CASE WHEN week_number BETWEEN 24 AND 36 THEN total_sales END) AS post_sustainable_packaging_sales
FROM customer_sales group by customer_type
)
SELECT 'Region' AS business_area, region AS value,
pre_sustainable_packaging_sales, post_sustainable_packaging_sales, 
post_sustainable_packaging_sales - pre_sustainable_packaging_sales AS sales_variation_actual_value,
ROUND(100*(post_sustainable_packaging_sales - pre_sustainable_packaging_sales)/pre_sustainable_packaging_sales,2) AS sales_variation_rate
FROM before_post_sustainable_packaging_sales_regions
UNION 
SELECT 'Platform' AS business_area, platform,
pre_sustainable_packaging_sales, post_sustainable_packaging_sales, 
post_sustainable_packaging_sales - pre_sustainable_packaging_sales AS sales_variation_actual_value,
ROUND(100*(post_sustainable_packaging_sales - pre_sustainable_packaging_sales)
/pre_sustainable_packaging_sales,2) AS sales_variation_rate
FROM before_post_sustainable_packaging_sales_platform
UNION
SELECT 'Age Band' AS business_area, age_band,
pre_sustainable_packaging_sales, post_sustainable_packaging_sales, post_sustainable_packaging_sales - pre_sustainable_packaging_sales AS sales_variation_actual_value,
ROUND(100*(post_sustainable_packaging_sales - pre_sustainable_packaging_sales)/pre_sustainable_packaging_sales,2) AS sales_variation_rate
FROM before_post_sustainable_packaging_sales_age
UNION
SELECT 'Demographic' AS business_area, demographic,
pre_sustainable_packaging_sales, post_sustainable_packaging_sales, post_sustainable_packaging_sales - pre_sustainable_packaging_sales AS sales_variation_actual_value,
ROUND(100*(post_sustainable_packaging_sales - pre_sustainable_packaging_sales)/pre_sustainable_packaging_sales,2) AS sales_variation_rate
FROM before_post_sustainable_packaging_sales_demographic
UNION
SELECT 'Customer Type' AS business_area, customer_type,
pre_sustainable_packaging_sales, post_sustainable_packaging_sales, post_sustainable_packaging_sales - pre_sustainable_packaging_sales AS sales_variation_actual_value,
ROUND(100*(post_sustainable_packaging_sales - pre_sustainable_packaging_sales)/pre_sustainable_packaging_sales,2) AS sales_variation_rate
FROM before_post_sustainable_packaging_sales_customer
ORDER BY 6;

