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

## Tools
* Microsoft SQL Server
* Microsoft Power BI
  
## Cohort Analysis 
* [SQL Query](https://github.com/ritusantra/SQL-Projects/blob/main/Customer%20Retention%20%26%20Cohort%20Analysis/Customer%20Retention%20%26%20Cohort%20Analysis.sql)
* [Power BI dashboard](https://app.powerbi.com/view?r=eyJrIjoiMDk5NTg3NzQtZDk3NS00ZjA5LTllNTEtM2NiNDUxZTYxYTU2IiwidCI6ImRmODY3OWNkLWE4MGUtNDVkOC05OWFjLWM4M2VkN2ZmOTVhMCJ9)

## Methodology
* Developed a SQL query to calculate retention and churn rates from the orders transaction data.
* Constructed a view based on the SQL query for streamlined access and analysis.
* Formulated an additional SQL query to evaluate new vs repeat customer retention and spending patterns.
* Integrated with Power BI, importing data from SQL Server using Import connectivity mode.
* Published the finalized report to the Power BI service.

## Calculation Method
* **Retrieve the First Visit Month for Each Customer**: Determine the initial month when each customer first visited by examining the earliest visit date recorded for each customer.
* **Retrieve the Visit Month for Each Customer**: Obtain the month of every visit for each customer from the records.
* **Join the Two Sets of Data**: Combine the data from the first visit month with the visit months for each customer. Use a `CASE WHEN` statement to calculate the number of customers for each difference in months (`month_diff`) and the first visit month (`first_month`).
* **Calculate the Retention Rate**: Determine the retention rate by analyzing how many customers return in subsequent months compared to the total number of customers who first visited in each month.
* **Calculate the Churn Rate**: Compute the churn rate as the complement of the retention rate, which is `100% - retention rate`.

## Insights
* 

