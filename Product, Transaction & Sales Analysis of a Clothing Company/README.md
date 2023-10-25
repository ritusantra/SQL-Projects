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

## Entity Relationship Diagram

## Tools
MySQL

## Methodology

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
