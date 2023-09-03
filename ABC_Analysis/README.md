# ABC Analysis of Inventory

## Table of Content
*[Introduction](#introduction)
*[Tools](#tools)
*[Approach](#approach)
*[Entity Relationship Diagram]()
*[Step by Step ABC Analysis]()


## Introduction
ABC analysis is is a popular inventory management technique that categorizes inventory into three segments based on the value or importance of each stock-keeping unit (SKU). It is done to understand which segment of the inventory is most valuable or critical to the business. Through this analysis, organizations can rank their inventory and manage them efficiently.<br>
The value of each of the units or Stock keeping units (SKU) is analyzed and segmented into 3 buckets or segments — ``A``, ``B`` and ``C``.

* **A**: High-value items which represents a smaller portion of the entire inventory. This items being most valued and critical to the business, are closely tracked and managed.

* **B**: Medium-value items are not as critical as segment A items. But these are also tracked and manage.

* **C**: Low-value items which represents a large portion of the entire inventory. This items are not so closely tracked and are managed loosely.

## Tools 
* MySQL
* Microsoft Excel

## Approach
* Calculate the **revenue** of each product and sort it in the descending order.
* Calculate the **cummulative revenue**, **percentage of cummulative revenue** and **percentage of inventory** of each product.
* Based on the **percentage of cummulative revenue**, each product is given a segment - A,B,C.
* Calculate the **total inventory**, **percentage of inventory**, **total revenue**, and **percentage of revenue** of each of the segment.
* For graphical representation, plot **percentage of inventory** in **x-axis** and **percentage of cummulative revenue** in **y-axis**. 

## Entity Relationship Diagram
Two data tables are used:
```products``` and  ```order_details```

![image](https://github.com/ritusantra/SQL-Projects/assets/75059347/7835b3cd-1739-4ff1-accf-0eb1d8f5d225)


## Step by Step ABC Analysis
[Step by Step ABC Analysis](https://medium.com/@ritusantra/abc-analysis-using-excel-sql-da3d158b0c18)

## SQL Query & Microsoft Excel Workbook
* [SQL Query](https://github.com/ritusantra/SQL-Projects/blob/main/ABC_Analysis/ABC_2.sql)
* [Microsoft Excel Workbook](https://github.com/ritusantra/SQL-Projects/blob/main/ABC_Analysis/ABC%20Analysis%20Final.xlsx)

## Results
* ABC Analysis using SQL
  
  ![image](https://github.com/ritusantra/SQL-Projects/assets/75059347/eafb543b-92ee-4c88-b25d-6db0a8d990ce)

* ABC Analysis using Microsoft Excel
  
  ![image](https://github.com/ritusantra/SQL-Projects/assets/75059347/c1fa3f9d-06dd-4169-8cee-15e87212c9d3)
