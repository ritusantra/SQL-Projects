-- 1. Get the first_visit_month of the Customer
select distinct Customer_ID,
datepart(month,min(Order_Date)) as first_order_month
from amazon_orders_old
where datepart(year,Order_Date) = '2021'
group by Customer_ID;

-- 2. Get the visit_month of the Customer
select distinct Customer_ID,
datepart(month,Order_Date) as order_month
from amazon_orders_old
where datepart(year,Order_Date) = '2021';

-- 3.  Join the two tables and use CASE WHEN to calculate the count of customers for each month_diff and first_month
with first_month as 
(select distinct Customer_ID,
datepart(month,min(Order_Date)) as first_order_month
from amazon_orders_old
where datepart(year,Order_Date) = '2021'
group by Customer_ID),
every_month as (select distinct Customer_ID,
datepart(month,Order_Date) as order_month
from amazon_orders_old
where datepart(year,Order_Date) = '2021'),
join_table as
(select f.Customer_ID, f.first_order_month, e.order_month,
e.order_month - f.first_order_month as month_diff
 from first_month f
inner join every_month e
on f.customer_id = e.customer_id)
select 
first_order_month,
	   SUM(CASE WHEN month_diff = 0 THEN 1 ELSE 0 END) AS m0,
       SUM(CASE WHEN month_diff = 1 THEN 1 ELSE 0 END) AS m1,
       SUM(CASE WHEN month_diff = 2 THEN 1 ELSE 0 END) AS m2,
       SUM(CASE WHEN month_diff = 3 THEN 1 ELSE 0 END) AS m3,
       SUM(CASE WHEN month_diff = 4 THEN 1 ELSE 0 END) AS m4,
       SUM(CASE WHEN month_diff = 5 THEN 1 ELSE 0 END) AS m5,
       SUM(CASE WHEN month_diff = 6 THEN 1 ELSE 0 END) AS m6,
       SUM(CASE WHEN month_diff = 7 THEN 1 ELSE 0 END) AS m7,
       SUM(CASE WHEN month_diff = 8 THEN 1 ELSE 0 END) AS m8,
       SUM(CASE WHEN month_diff = 9 THEN 1 ELSE 0 END) AS m9,
       SUM(CASE WHEN month_diff = 10 THEN 1 ELSE 0 END) AS m10,
       SUM(CASE WHEN month_diff = 11 THEN 1 ELSE 0 END) AS m11
FROM join_table
group by first_order_month
order by 1
;

-- 4. Retention rate

with first_month as 
	(select distinct Customer_ID,
	datepart(month,min(Order_Date)) as first_order_month
	from amazon_orders_old
	where datepart(year,Order_Date) = '2021'
	group by Customer_ID),
every_month as
	(select distinct Customer_ID,
	datepart(month,Order_Date) as order_month
	from amazon_orders_old
	where datepart(year,Order_Date) = '2021'),
join_table as
	(select f.Customer_ID, f.first_order_month, e.order_month,
	e.order_month - f.first_order_month as month_diff
	 from first_month f
	inner join every_month e
	on f.customer_id = e.customer_id),
retention_cohort as 
	(select 
	first_order_month,
		   SUM(CASE WHEN month_diff = 0 THEN 1 ELSE 0 END) AS month_0,
		   SUM(CASE WHEN month_diff = 1 THEN 1 ELSE 0 END) AS month_1,
		   SUM(CASE WHEN month_diff = 2 THEN 1 ELSE 0 END) AS month_2,
		   SUM(CASE WHEN month_diff = 3 THEN 1 ELSE 0 END) AS month_3,
		   SUM(CASE WHEN month_diff = 4 THEN 1 ELSE 0 END) AS month_4,
		   SUM(CASE WHEN month_diff = 5 THEN 1 ELSE 0 END) AS month_5,
		   SUM(CASE WHEN month_diff = 6 THEN 1 ELSE 0 END) AS month_6,
		   SUM(CASE WHEN month_diff = 7 THEN 1 ELSE 0 END) AS month_7,
		   SUM(CASE WHEN month_diff = 8 THEN 1 ELSE 0 END) AS month_8,
		   SUM(CASE WHEN month_diff = 9 THEN 1 ELSE 0 END) AS month_9,
		   SUM(CASE WHEN month_diff = 10 THEN 1 ELSE 0 END) AS month_10,
		   SUM(CASE WHEN month_diff = 11 THEN 1 ELSE 0 END) AS month_11
	FROM join_table
	group by first_order_month),
rentention_rate_cohort as 
	(select
	first_order_month,
	100*month_0/month_0 as month_0,
	100*month_1/month_0 as month_1,
	100*month_2/month_0 as month_2,
	100*month_3/month_0 as month_3,
	100*month_4/month_0 as month_4,
	100*month_5/month_0 as month_5,
	100*month_6/month_0 as month_6,
	100*month_7/month_0 as month_7,
	100*month_8/month_0 as month_8,
	100*month_9/month_0 as month_9,
	100*month_10/month_0 as month_10,
	100*month_11/month_0 as month_11
	from retention_cohort)
select * from rentention_rate_cohort
order by first_order_month;

-- 5. Churn rate

with first_month as 
	(select distinct Customer_ID,
	datepart(month,min(Order_Date)) as first_order_month
	from amazon_orders_old
	where datepart(year,Order_Date) = '2021'
	group by Customer_ID),
every_month as
	(select distinct Customer_ID,
	datepart(month,Order_Date) as order_month
	from amazon_orders_old
	where datepart(year,Order_Date) = '2021'),
join_table as
	(select f.Customer_ID, f.first_order_month, e.order_month,
	e.order_month - f.first_order_month as month_diff
	 from first_month f
	inner join every_month e
	on f.customer_id = e.customer_id),
churn_cohort as 
	(select 
	first_order_month,
		   SUM(CASE WHEN month_diff = 0 THEN 1 ELSE 0 END) AS month_0,
		   SUM(CASE WHEN month_diff = 1 THEN 1 ELSE 0 END) AS month_1,
		   SUM(CASE WHEN month_diff = 2 THEN 1 ELSE 0 END) AS month_2,
		   SUM(CASE WHEN month_diff = 3 THEN 1 ELSE 0 END) AS month_3,
		   SUM(CASE WHEN month_diff = 4 THEN 1 ELSE 0 END) AS month_4,
		   SUM(CASE WHEN month_diff = 5 THEN 1 ELSE 0 END) AS month_5,
		   SUM(CASE WHEN month_diff = 6 THEN 1 ELSE 0 END) AS month_6,
		   SUM(CASE WHEN month_diff = 7 THEN 1 ELSE 0 END) AS month_7,
		   SUM(CASE WHEN month_diff = 8 THEN 1 ELSE 0 END) AS month_8,
		   SUM(CASE WHEN month_diff = 9 THEN 1 ELSE 0 END) AS month_9,
		   SUM(CASE WHEN month_diff = 10 THEN 1 ELSE 0 END) AS month_10,
		   SUM(CASE WHEN month_diff = 11 THEN 1 ELSE 0 END) AS month_11
	FROM join_table
	group by first_order_month),
churn_rate_cohort as 
	(select
			first_order_month,
			100 - (100*month_0/month_0) as month_0,
			100 - (100*month_1/month_0) as month_1,
			100 - (100*month_2/month_0) as month_2,
			100 - (100*month_3/month_0) as month_3,
			100 - (100*month_4/month_0) as month_4,
			100 - (100*month_5/month_0) as month_5,
			100 - (100*month_6/month_0) as month_6,
			100 - (100*month_7/month_0) as month_7,
			100 - (100*month_8/month_0) as month_8,
			100 - (100*month_9/month_0) as month_9,
			100 - (100*month_10/month_0) as month_10,
			100 - (100*month_11/month_0) as month_11	
	from churn_cohort)
select * from churn_rate_cohort
order by first_order_month;

