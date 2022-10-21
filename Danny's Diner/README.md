# Danny's Diner

## Table of Content
* [SQL Challenge Link & Dataset](#sql-challenge-link--dataset)
* [Introduction](#introduction)
* [Problem Statement](#problem-statement)
* [Entity Relationship Diagram](#entity-relationship-diagram)
* [Case Study Questions](#case-study-questions)
* [Key insights from the analysis](#key-insights-from-the-analysis)
* [SQL Solution](https://github.com/ritusantra/SQL-Projects/blob/main/Danny's%20Diner/Danny's%20Diner.sql)

<img src="https://user-images.githubusercontent.com/75059347/197112175-a2ce06ff-03bf-4bfc-84b4-f431fdba8328.png" width="350" height="400">

## SQL Challenge Link & Dataset
https://8weeksqlchallenge.com/case-study-1/

## Introduction
Danny seriously loves Japanese food so in the beginning of 2021, he decides to embark upon a risky venture and opens up a cute little restaurant that sells his 3 favourite foods: sushi, curry and ramen.

Danny’s Diner is in need of your assistance to help the restaurant stay afloat — the restaurant has captured some very basic data from their few months of operation but have no idea how to use their data to help them run the business.

## Problem Statement
Danny wants to use the data to answer a few simple questions about his customers, especially about their visiting patterns, how much money they’ve spent and also which menu items are their favourite. Having this deeper connection with his customers will help him deliver a better and more personalised experience for his loyal customers.

He plans on using these insights to help him decide whether he should expand the existing customer loyalty program — additionally he needs help to generate some basic datasets so his team can easily inspect the data without needing to use SQL.

Danny has shared 3 key datasets for this case study:

* sales
* menu
* members

## Entity Relationship Diagram

<img src="https://user-images.githubusercontent.com/75059347/197111645-65f281cb-3f80-43d8-bb7b-975fa0e50971.png" width="800" height="500">

## Case Study Questions

Each of the following case study questions can be answered using a single SQL statement:

1. What is the total amount each customer spent at the restaurant?
2. How many days has each customer visited the restaurant?
3. What was the first item from the menu purchased by each customer?
4. What is the most purchased item on the menu and how many times was it purchased by all customers?
5. Which item was the most popular for each customer?
6. Which item was purchased first by the customer after they became a member?
7. Which item was purchased just before the customer became a member?
8. What is the total items and amount spent for each member before they became a member?
9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?

## Key insights from the analysis
* A has spend the most amount in the restaurant.
* B is the most frequent visitor in the restaurant.
* Ramen is the most purchased item on the menu.
* The first purchased item by A is sushi, for B it is curry and for C it is ramen.
* Ramen is the most popular dish for A and C. For B it is curry and sushi.
* After A became a member, the first item they purchased is curry and B purchased sushi.
* Before A become a member, they has spend $25 and B has spend $40.
