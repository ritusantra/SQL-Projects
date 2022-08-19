/*1. Select customer name together with each order the customer made*/

SELECT cust.ContactName, odr.OrderID 
FROM customers cust
INNER JOIN orders odr
ON cust.CustomerID = odr.CustomerID;

/*2. Select order id together with name of employee who handled the order*/

SELECT odr.OrderID, emp.FirstName, emp.LastName
FROM orders odr
LEFT JOIN employees emp
ON odr.EmployeeID = emp.EmployeeID;

/*3. Select customers who did not placed any order yet*/

SELECT cust.ContactName FROM customers cust
LEFT JOIN orders odr
ON cust.CustomerID = odr.CustomerID
WHERE odr.OrderID IS NULL;

/*4. Select order id together with the name of products*/

SELECT od.OrderID, pro.ProductID, pro.ProductName 
FROM order_details od
LEFT JOIN products pro
ON pro.ProductID = od.ProductID;

/*5. Select products that no one bought*/

SELECT pro.ProductName FROM order_details od
LEFT JOIN products pro
ON pro.ProductID = od.ProductID
WHERE od.OrderID IS NULL;


/*6. Select customer together with the products that he bought*/

SELECT cust.CustomerName, pro.ProductName
FROM customers cust
INNER JOIN orders odr
ON cust.CustomerID = odr.CustomerID
INNER JOIN order_details od
ON od.OrderID = odr.OrderID
INNER JOIN products pro
ON pro.ProductID = od.ProductID;

/*7. Select product names together with the name of corresponding category*/

SELECT pro.ProductName, cat.CategoryName 
FROM products pro
LEFT JOIN categories cat
ON pro.CategoryID = cat.CategoryID;

/*8. Select orders together with the name of the shipping company*/

SELECT odr.OrderID, ship.ShipperName
FROM shippers ship
LEFT JOIN orders odr
ON ship.ShipperID = odr.ShipperID;


/*9. Select customers with id greater than 50 together with each order they made*/

SELECT cust.CustomerID, cust.CustomerName, odr.OrderID
FROM customers cust
INNER JOIN orders odr
ON cust.CustomerID = odr.CustomerID
WHERE cust.CustomerID > 50;

/*10. Select employees together with orders with order id greater than 10400*/

SELECT emp.FirstName, emp.LastName, odr.OrderID
FROM employees emp
INNER JOIN orders odr
ON emp.EmployeeID = odr.EmployeeID
WHERE odr.OrderID > 10400;



/*11. Select the most expensive product*/

WITH cte_rnk AS
(SELECT ProductID, ProductName, Price,
RANK() OVER(ORDER BY Price DESC) AS rnk
FROM products)
SELECT * FROM cte_rnk
WHERE rnk = 1;

/*12. Select the second most expensive product*/

SELECT ProductID, ProductName as '2nd_Most_Expensive_Product', Price
FROM products
ORDER BY Price DESC;

-- using rank
WITH cte_rnk AS
(SELECT ProductID, ProductName, Price, 
RANK() OVER(ORDER BY Price DESC) AS rnk FROM products)
SELECT * FROM cte_rnk WHERE rnk = 2;


/*13. Select name and price of each product, sort the result by price in decreasing order*/

SELECT ProductName, Price
FROM products
ORDER BY Price DESC;

/*14. Select 5 most expensive products*/

SELECT ProductName, Price
FROM products
ORDER BY Price DESC
LIMIT 5;

/*15. Select 5 most expensive products without the most expensive (in final 4 products)*/

SELECT ProductName, Price
FROM products
ORDER BY Price DESC
LIMIT 4
OFFSET 1; -- Offset is used to specify from which row we want the data to retrieve.


/*16. Select name of the cheapest product (only name) without using LIMIT and OFFSET*/

WITH cte_rnk AS
(SELECT ProductName, Price,
RANK() OVER(ORDER BY Price ASC) AS rnk FROM products)
SELECT * FROM cte_rnk WHERE rnk = 1;

/*17. Select name of the cheapest product (only name) using subquery*/

SELECT ProductName FROM products
WHERE Price = (SELECT MIN(Price) FROM products);

/*18. Select number of employees with LastName that starts with 'D'*/

SELECT COUNT(*) AS '#_of_Employees'
FROM employees
WHERE LastName LIKE 'D%';

/* BONUS : same question for Customer this time */

WITH count_cust AS (SELECT CustomerName, SUBSTRING_INDEX(CustomerName," ",1) AS FirstName,
SUBSTRING_INDEX(CustomerName," ",-1) AS LastName
FROM customers
WHERE SUBSTRING_INDEX(CustomerName," ",-1) LIKE 'D%')
select COUNT(CustomerName) AS '#_of_Customers'from count_cust;

/*19. Select customer name together with the number of orders made by the corresponding customer 
sort the result by number of orders in decreasing order*/

SELECT cust.CustomerID, cust.ContactName, COUNT(odr.OrderID) AS 'Total_Orders'
FROM customers cust
INNER JOIN orders odr
ON cust.CustomerID = odr.CustomerID
GROUP BY cust.ContactName
ORDER BY 3 DESC;

/*20. Add up the price of all products*/

SELECT SUM(Price) FROM products;

/*21. Select orderID together with the total price of  that Order, 
order the result by total price of order in increasing order*/

SELECT od.OrderID, SUM(od.Quantity * pro.Price) AS 'Total_Price'
FROM order_details od
LEFT JOIN products pro
ON od.ProductID = pro.ProductID
GROUP BY od.OrderID
ORDER BY 2 DESC;

/*22. Select customer who spend the most money*/

SELECT cust.CustomerID, cust.CustomerName, SUM(od.Quantity * pro.Price) AS 'Total_Spend'
FROM customers cust
INNER JOIN orders odr
ON cust.CustomerID = odr.CustomerID
INNER JOIN order_details od
ON od.OrderID = odr.OrderID
INNER JOIN products pro
ON pro.ProductID = od.ProductID
GROUP BY cust.CustomerID
ORDER BY 3 DESC
LIMIT 1;

/*23. Select customer who spend the most money and lives in Canada*/

SELECT cust.CustomerID, cust.CustomerName, SUM(od.Quantity * pro.Price) AS 'Total_Spend', cust.Country 
FROM customers cust
INNER JOIN orders odr
ON cust.CustomerID = odr.CustomerID
INNER JOIN order_details od
ON od.OrderID = odr.OrderID
INNER JOIN products pro
ON pro.ProductID = od.ProductID
GROUP BY cust.CustomerID
HAVING cust.Country = 'Canada'
ORDER BY 3 DESC
LIMIT 1;

/*24. Select customer who spend the second most money*/

WITH cte_rnk AS (SELECT cust.CustomerID, cust.CustomerName, SUM(od.Quantity * pro.Price) AS 'Total_Spend',
RANK() OVER(ORDER BY SUM(od.Quantity * pro.Price) DESC) as 'Rnk'
FROM customers cust
INNER JOIN orders odr
ON cust.CustomerID = odr.CustomerID
INNER JOIN order_details od
ON od.OrderID = odr.OrderID
INNER JOIN products pro
ON pro.ProductID = od.ProductID
GROUP BY cust.CustomerID)
SELECT * FROM cte_rnk WHERE Rnk = 2;

SELECT cust.CustomerID, cust.CustomerName, SUM(od.Quantity * pro.Price) AS 'Total_Spend',
RANK() OVER(ORDER BY SUM(od.Quantity * pro.Price) DESC) as 'Rnk'
FROM customers cust
INNER JOIN orders odr
ON cust.CustomerID = odr.CustomerID
INNER JOIN order_details od
ON od.OrderID = odr.OrderID
INNER JOIN products pro
ON pro.ProductID = od.ProductID
GROUP BY cust.CustomerID
ORDER BY 3 DESC 
LIMIT 1
OFFSET 1;


/*25. Select shipper together with the total price of proceed orders*/

SELECT ship.ShipperID, ship.ShipperName, SUM(od.Quantity * pro.Price) as 'Total_Amount'
FROM shippers ship
LEFT JOIN orders odr
ON ship.ShipperID = odr.ShipperID
LEFT JOIN order_details od
ON od.OrderID = odr.OrderID
LEFT JOIN products pro
ON pro.ProductID = od.ProductID
GROUP BY ship.ShipperID
ORDER BY 3 DESC;
