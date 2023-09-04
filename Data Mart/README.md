# Data Mart - Sales Performance of An Online Supermarket

## Table of Content
* [Introduction](#introduction)
* [Entity Relationship Diagram](#entity-relationship-diagram)
* [Data Cleansing Steps](#data-cleansing-steps)
* [Data Exploration](#data-exploration)
* [Before & After Analysis](#before--after-analysis)
* [Note](#note)

## Introduction
Data Mart is Danny’s latest venture and after running international operations for his online supermarket that specialises in fresh produce - Danny is asking for your support to analyse his sales performance.

In June 2020 - large scale supply changes were made at Data Mart. All Data Mart products now use sustainable packaging methods in every single step from the farm all the way to the customer.

Danny needs your help to quantify the impact of this change on the sales performance for Data Mart and it’s separate business areas.

## Entity Relationship Diagram
For this case study there is only a single table: `data_mart.weekly_sales`<br>
The Entity Relationship Diagram is shown below with the data types.

![image](https://github.com/ritusantra/SQL-Projects/assets/75059347/4433c1bc-ca79-4c88-a9de-e8da4b3f5ddf)

## Data Cleansing Steps
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
  
## Note

