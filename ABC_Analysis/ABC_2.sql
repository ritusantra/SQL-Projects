-- Product and Orders 
SELECT * FROM products;
SELECT * FROM order_details;

-- Calculate the revenue of each product and rank the products in descending order of revenue
SELECT 
DENSE_RANK() OVER(ORDER BY ROUND(SUM(od.Quantity*p.Price),2) DESC) AS Product_Rank_by_Revenue,
p.ProductID, p.ProductName, 
ROUND(SUM(od.Quantity*p.Price),2) AS 'Revenue'
FROM order_details od
LEFT JOIN products p
ON od.ProductID = p.ProductID
GROUP BY p.ProductID, p.ProductName;

-- Calculate Cumulative Revenue, Total Revenue, Cumulative Percentage of Revenue for each product
WITH Cumulative AS
(SELECT 
DENSE_RANK() OVER(ORDER BY ROUND(SUM(od.Quantity*p.Price),2) desc) AS Product_Rank_by_Revenue,
p.ProductID, p.ProductName, 
ROUND(SUM(od.Quantity*p.Price),2) AS 'Revenue'
FROM order_details od
LEFT JOIN products p
ON od.ProductID = p.ProductID
GROUP BY p.ProductID, p.ProductName)
SELECT Product_Rank_by_Revenue, ProductID, ProductName, Revenue,
SUM(Revenue) OVER(ORDER BY Revenue DESC) AS Cumulative_Revenue,
SUM(Revenue) OVER() AS Total_Revenue,
ROUND(100*SUM(Revenue) OVER(ORDER BY Revenue DESC)/SUM(Revenue) OVER(),2) AS Cumulative_Percentage_of_Revenue,
ROUND(100*Product_Rank_by_Revenue/(SELECT COUNT(*) FROM products),2) AS Cumulative_Percentage_of_Inventory
FROM Cumulative;

-- Calculate the segment A,B,C based on the Cumulative Revenue
WITH ABC_Analysis AS
(WITH Cumulative AS
(SELECT 
DENSE_RANK() OVER(ORDER BY ROUND(SUM(od.Quantity*p.Price),2) desc) AS Product_Rank_By_Revenue,
p.ProductID, p.ProductName, 
ROUND(SUM(od.Quantity*p.Price),2) AS 'Revenue'
FROM order_details od
LEFT JOIN products p
ON od.ProductID = p.ProductID
GROUP BY p.ProductID, p.ProductName)
SELECT Product_Rank_By_Revenue, ProductID, ProductName, Revenue,
SUM(Revenue) OVER(ORDER BY Revenue DESC) AS Cumulative_Revenue,
SUM(Revenue) OVER() AS Total_Revenue,
ROUND(100*SUM(Revenue) OVER(ORDER BY Revenue DESC)/SUM(Revenue) OVER(),2) AS Cumulative_Percentage_of_Revenue,
ROUND(100*Product_Rank_By_Revenue/(SELECT COUNT(*) FROM products),2) AS Cumulative_Percentage_of_Inventory
FROM Cumulative)
SELECT 
Product_Rank_By_Revenue, ProductID, ProductName, Revenue, 
Cumulative_Revenue, Total_Revenue, Cumulative_Percentage_of_Revenue, Cumulative_Percentage_of_Inventory,
IF(Cumulative_Percentage_of_Revenue<40,'A',IF(Cumulative_Percentage_of_Revenue<70,'B','C')) AS ABC
FROM ABC_Analysis;

-- Calculate the Percentage of Revenue and Percentage of Inventory
WITH Count_of_Inventory AS (WITH ABC_Analysis AS
(WITH Cumulative AS
(SELECT 
DENSE_RANK() OVER(ORDER BY ROUND(SUM(od.Quantity*p.Price),2) desc) AS Product_Rank_By_Revenue,
p.ProductID, p.ProductName, 
ROUND(SUM(od.Quantity*p.Price),2) AS 'Revenue'
FROM order_details od
LEFT JOIN products p
ON od.ProductID = p.ProductID
GROUP BY p.ProductID, p.ProductName)
SELECT Product_Rank_By_Revenue, ProductID, ProductName, Revenue,
SUM(Revenue) OVER(ORDER BY Revenue DESC) AS Cumulative_Revenue,
SUM(Revenue) OVER() AS Total_Revenue,
ROUND(100*SUM(Revenue) OVER(ORDER BY Revenue DESC)/SUM(Revenue) OVER(),2) AS Cumulative_Percentage_of_Revenue,
ROUND(100*Product_Rank_By_Revenue/(SELECT COUNT(*) FROM products),2) AS Cumulative_Percentage_of_Inventory
FROM Cumulative)
SELECT 
Product_Rank_By_Revenue, ProductID, ProductName, Revenue, 
Cumulative_Revenue, Total_Revenue, Cumulative_Percentage_of_Revenue, Cumulative_Percentage_of_Inventory,
IF(Cumulative_Percentage_of_Revenue<40,'A',IF(Cumulative_Percentage_of_Revenue<70,'B','C')) AS ABC_Segment
FROM ABC_Analysis)
SELECT 
ABC_Segment, COUNT(ProductID) AS Total_Inventory,
ROUND(SUM(Revenue),2) AS Total_Revenue,
ROUND(100*COUNT(ProductID)/(SELECT COUNT(*) FROM products),0) AS Percentage_of_Inventory,
ROUND(100*SUM(Revenue)/(SELECT ROUND(SUM(od.Quantity*p.Price),2) FROM order_details od
LEFT JOIN products p
ON od.ProductID = p.ProductID),2) AS Percentage_of_Revenue
FROM Count_of_Inventory
GROUP BY ABC_Segment;
