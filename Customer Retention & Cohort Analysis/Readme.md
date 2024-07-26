# Customer Retention & Cohort Analysis

[Power BI dashboard](https://app.powerbi.com/view?r=eyJrIjoiMDk5NTg3NzQtZDk3NS00ZjA5LTllNTEtM2NiNDUxZTYxYTU2IiwidCI6ImRmODY3OWNkLWE4MGUtNDVkOC05OWFjLWM4M2VkN2ZmOTVhMCJ9)

## Methodology
1. Created SQL query to calculate the rate of rentention and churn from the orders transaction table
2. Created a view on top of the SQL query
3. Connected to Power BI and imported the data from the database view using Import connectivity mode
4. Published the report to Power BI service

## Calculation Method
1. Get the first_visit_month of the Customer
2. Get the visit_month of the Customer
3. Join the two tables and use case when to calculate the count of customers for each month_diff and first_month
4. Retention rate 
5. Churn rate is (100 - rentention rate)

## SQL Query Result
### Retention Analysis
![image](https://github.com/user-attachments/assets/d026576d-254e-407c-9979-c1f670367863)

### Churn Analysis
![image](https://github.com/user-attachments/assets/cf4c1125-f6c2-4771-85bf-f7e7044158e4)

## Power BI Dashboard
### Retention Analysis
![image](https://github.com/user-attachments/assets/07b4f456-3edd-40b5-90b9-418dea65f425)

### Churn Analysis
![image](https://github.com/user-attachments/assets/6da9712f-d60f-4701-b1ca-7576c8c70239)

