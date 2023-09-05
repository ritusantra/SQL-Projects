# Data Mart - Sales Performance of An Online Supermarket

## Table of Content
* [Introduction](#introduction)
* [Entity Relationship Diagram](#entity-relationship-diagram)
* [Tools](#tools)
* [Data Cleansing](#data-cleansing)
* [Data Exploration](#data-exploration)
* [Before & After Analysis](#before--after-analysis)
* [SQL Queries](#sql-queries)
* [Note](#note)

## Introduction
Data Mart is Danny’s latest venture and after running international operations for his online supermarket that specialises in fresh produce - Danny is asking for your support to analyse his sales performance.

In June 2020 - large scale supply changes were made at Data Mart. All Data Mart products now use sustainable packaging methods in every single step from the farm all the way to the customer.

Danny needs help to quantify the impact of this change on the sales performance for Data Mart and it’s separate business areas.

## Entity Relationship Diagram
For this case study there is only a single table: `data_mart.weekly_sales`<br>
The Entity Relationship Diagram is shown below with the data types.

![image](https://github.com/ritusantra/SQL-Projects/assets/75059347/073f7717-2486-40ab-b9fe-9c6bcf024ab3)

## Tools
* MySQL

## Data Cleansing
* The format of the **week_date** column was in ```VARCHAR(7)``` during table creation. Using ```STR_TO_DATE``` funtion in the ```SELECT``` statement it was converted into ```DATE``` format.
* The data type was converted in the ```SELECT``` statement and hence ```CTE``` was created as **sales_data** to reuse the ```SELECT``` statement for further data manipulations.
* Functions like ```WEEK()```, ```MONTH()``` and ```YEAR()``` were used to find the **week_number** **month_number** and **calendar_year** respectively.
* New columns **age_band** and **demographic** were added using ```CASE``` statement to classify customers based on **segment**
* Replaced all the ```NULL``` string values with an **unknown** string value in the original segment column as well as the new **age_band** and **demographic** columns.
* Generated a new **avg_transaction** column as the sales value divided by transactions rounded to 2 decimal places for each record.
* Created new table **clean_weekly_sales** with the above modifications. This **clean_weekly_sales** table is further used for the **Data Exploration** and **Before & After Analysis**.

The new table **clean_weekly_sales** with clean data is shown below with the data types.

![image](https://github.com/ritusantra/SQL-Projects/assets/75059347/bb9476f6-2bc1-4103-848f-8ec5ba2932ff)


## Data Exploration
* **Monday** is the day of the week used for each week date value in the data.
* Range of weeks which are missing are: **1 to 11** and **36 to 53**.
* **2020** has the highest number of total transactions.
* **Europe** has the highest total sales in the month of September compared to all other regions for each month.
* **Retail** platform has the highest total count of transactions. About 99% of the transactions are from **Retail**.
* In the year 2020, the sales from Retail platform has reduced and sales from Shopify 
platform has increased. Until 2020, the highest sales was generated from Retail platform.
* The percentage of sales from the Couples and Families demographic has increased over time. However, the percentage of sales for the Unknown demographic has decreased.
* The age band and demographic that contribute the most to retail sales is currently **Unknown**. However, **Retiree Families** and **Retiree Couples** follow in contribution.
* The highest average transaction size is from **Shopify** platform.
  
## Before & After Analysis
* The variance in the total sales for the 4 weeks before and after ```2020-06-15``` is -26884188. That means there has been **26884188** reduction in sales after the introduction of sustainable packaging methods. This results in **1.15%** reduction rate.

* The variance in total sales for the 12 weeks before and after ```2020-06-15``` is -152325394. This means there has been a reduction of **152325394** in sales since the introduction of sustainable packaging methods. This significant reduction in sales results in a reduction rate of **2.14%**.

## SQL Queries
* [Data Cleansing](https://github.com/ritusantra/SQL-Projects/blob/main/Data%20Mart/1.%20Data%20Cleansing.sql)
* [Data Exploration](https://github.com/ritusantra/SQL-Projects/blob/main/Data%20Mart/2.%20Data%20Exploration.sql)
* [Before & After Analysis](https://github.com/ritusantra/SQL-Projects/blob/main/Data%20Mart/3.%20Before%20%26%20After%20Analysis.sql)
  
## Note
This project is one of the [SQL challenges](https://8weeksqlchallenge.com/case-study-5/) by [Danny Ma](https://www.linkedin.com/in/datawithdanny/).
