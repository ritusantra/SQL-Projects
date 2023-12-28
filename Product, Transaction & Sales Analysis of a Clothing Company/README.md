# Product, Transaction & Sales Analysis of a Clothing Company

## Table of Content
* [Introduction](#introduction)
* [Entity Relationship Diagram](#entity-relationship-diagram)
* [Tools](#tools)
* [Methodology](#methodology)
* [SQL Queries](#sql-queries)
* [Insights](#insights)
* [Note](#note)

## Introduction
The project aims to assist the merchandising team in analyzing their sales performance and generate a basic financial report to share with the wider business. The analysis is performed at the product, sales, and transactions level and a reporting solution has been developed to automate the end entire analysis and reporting process.

## Entity Relationship Diagram
``product_details`` table includes all information about the entire range of products.

``Sales`` table contains product-level information for all the transactions made for Balanced Tree including quantity, price, percentage discount, member status, a transaction ID, and also the transaction timestamp.


![image](https://github.com/ritusantra/SQL-Projects/assets/75059347/b469cad7-9f65-4202-8efc-7caac805e347)


## Tools
MySQL

## Methodology
### Analysis
* Performed analysis at product, transaction, and sales levels by developing SQL queries.
* For this data from ``sales`` table and ``product_details`` table were used.

### Reporting
* Created a new table ``sales_m`` to store the required monthly sales data. This has the same structure as the ``sales`` table.
* Created two procedures and combined them into one procedure to automate the entire reporting process for the required month and year.
* Created 1st procedure ``monthly_sales_4 `` with input parameters - month and year. The purpose of the procedure is to get the sales data from the ``sales`` table based on the month and year and insert it into the new table ``sales_m``. Every time this procedure is executed, the older records of the year and month are removed and new records are inserted.
* Created 2nd procedure ``auto_select`` without any input parameter. The purpose of this procedure is to run all the select queries for  product, transaction, and sales analysis on the sales data in the new table ``sales_m``.
* Created 3rd procedure ``report`` with input parameters - month and year. The purpose of the procedure is to combine the 1st and 2nd procedures. It will first
extract the data from the ``sales`` table for the required year and month and insert it into the ``sales_m`` table. And then run all the queries for reporting.


## SQL Queries
1. [Product Analysis](https://github.com/ritusantra/SQL-Projects/blob/main/Product%2C%20Transaction%20%26%20Sales%20Analysis%20of%20a%20Clothing%20Company/1.%20Product%20Analysis.sql)
2. [Transaction Analysis](https://github.com/ritusantra/SQL-Projects/blob/main/Product%2C%20Transaction%20%26%20Sales%20Analysis%20of%20a%20Clothing%20Company/2.%20Transaction%20Analysis.sql)
3. [Sales Analysis](https://github.com/ritusantra/SQL-Projects/blob/main/Product%2C%20Transaction%20%26%20Sales%20Analysis%20of%20a%20Clothing%20Company/3.%20Sales%20Analysis.sql)
4. [Reporting](https://github.com/ritusantra/SQL-Projects/blob/main/Product%2C%20Transaction%20%26%20Sales%20Analysis%20of%20a%20Clothing%20Company/4.%20Reporting.sql)

## Insights
### Product Analysis
1. What are the top 3 products by total revenue before discount? <br> ![image](https://github.com/ritusantra/SQL-Projects/assets/75059347/e40d4448-c6b8-4228-ba6a-e1ad20d2fce8)

2. What is the total quantity, revenue, and discount for each segment? <br> ![image](https://github.com/ritusantra/SQL-Projects/assets/75059347/2e4a8eea-488f-464c-841f-047ded0a2ea6)

3. What is the top-selling product for each segment?<br> ![image](https://github.com/ritusantra/SQL-Projects/assets/75059347/777c536d-df03-489e-a3b0-c98449952983)

4. What is the total quantity, revenue, and discount for each category?<br> ![image](https://github.com/ritusantra/SQL-Projects/assets/75059347/b0e9960f-8792-417e-bdae-c50997d6396e)

5. What is the top-selling product for each category?<br> ![image](https://github.com/ritusantra/SQL-Projects/assets/75059347/1b1e1d6d-25d0-4b6a-ae79-cf9684d49ea6)

6. What is the percentage split of revenue by product for each segment?<br> ![image](https://github.com/ritusantra/SQL-Projects/assets/75059347/29827c81-0226-48ac-b333-d91d08f8f88e)

7. What is the percentage split of revenue by segment for each category?<br> ![image](https://github.com/ritusantra/SQL-Projects/assets/75059347/9872346e-8e56-4804-b1ad-9a09851d37f3)

8. What is the percentage split of total revenue by category?<br> ![image](https://github.com/ritusantra/SQL-Projects/assets/75059347/5e120d21-9493-4bdd-bc2d-1845664336da)

9. What is the total transaction “penetration” for each product? (hint: penetration = number of transactions where at least 1 quantity of a product was purchased divided by the total number of transactions)<br> ![image](https://github.com/ritusantra/SQL-Projects/assets/75059347/1a1d5c65-44e9-4eb7-8fb5-e61b2a3ef1d7)

10. What is the most common combination of at least 1 quantity of any 3 products in a 1 single transaction?<br> ![image](https://github.com/ritusantra/SQL-Projects/assets/75059347/1d61fa06-dad7-48d3-b320-bb23015de25d)


### Transaction Analysis
1. 2500 unique transactions were there.
2. 6 average unique products were purchased in each transaction.
3. The 25th, 50th, and 75th percentile values for the revenue per transaction are 376.6,
509.8, and 647.1 respectively.
4. 73.1 is the average discount value per transaction.
5. The percentage split of all transactions for members vs non-members is 39.8 and 60.2.
6. The average revenue for member transactions is 516.3 and for non-member transactions is 515.0.
   
### Sales Analysis
1. The total quantity sold is 45216.
2. The total generated revenue for all products before discounts is 1289453.
3. The total discount amount for all products is 15622914.

## Note
This project is one of the [SQL challenges](https://8weeksqlchallenge.com/case-study-7/) by [Danny Ma](https://www.linkedin.com/in/datawithdanny/).
