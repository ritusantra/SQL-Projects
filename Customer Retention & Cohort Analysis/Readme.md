# Customer Retention & Cohort Analysis 🛒👧👦📊

Cohort analysis is a powerful analytical technique used to understand how specific groups of users behave over time. A "cohort" refers to a group of individuals who share a common characteristic or experience within a defined period. This technique is widely used to understand customer's behaviour.

Here’s a basic breakdown:
* **Defining Cohorts**: Determine the characteristic or event that groups individuals together. For example, we might define cohorts based on the month they signed up for a service, their first purchase, or their registration date.
* **Tracking Behavior Over Time**: Analyze how these cohorts perform over time. For example, we might track metrics like retention rates, purchase frequency, or user engagement.
* **Comparative Analysis**: Compare different cohorts to see how their behavior differs. This can reveal patterns or trends that are not obvious from aggregate data alone.
* **Applying Insights**: Use the insights from cohort analysis to make informed decisions, improve strategies, and tailor marketing efforts. For instance, if a particular cohort shows higher retention rates, we might analyze what strategies worked for them and apply those learnings to other cohorts.

Applications:
* **Customer Retention**: Businesses use cohort analysis to track how long customers continue using a product or service after their initial interaction.
* **Marketing Effectiveness**: It helps in evaluating the performance of marketing campaigns by comparing how different cohorts respond to various strategies.
* **Product Development**: By understanding which features or changes resonate with different cohorts, companies can refine their product offerings.
* **User Experience**: It can identify how different groups of users interact with a platform or service, leading to better user experience design.

## Objective
The goal of this project is to gain insights into customer behavior by analyzing their initial purchase patterns. Retention and churn analysis has been conducted by organizing and examining data according to the month of the first purchase and tracking subsequent purchase activity over time.


## Cohort Analysis Dashboard
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

