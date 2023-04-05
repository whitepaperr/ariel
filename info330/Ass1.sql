-- Write the SQL query to determine which customers are located in 'Germany'.
SELECT *
FROM Customers
WHERE Country = 'Germany';

-- Write the SQL query to determine which Employees are 'Sales Representative'(s).
SELECT *
FROM Employees
WHERE Title = 'Sales Representative';

-- Write the SQL query to determine how many products have been discontinued.
SELECT COUNT(*) AS NumOfDiscontinued
FROM Products
WHERE Discontinued = '1';

-- Write the code to return the 10 most recently shipped orders with freight costs less than 50. (Remember to filter out null ShippedDates)
SELECT TOP 10 *
FROM Orders
WHERE Freight < 50 AND ShippedDate IS NOT NULL
ORDER BY ShippedDate ASC;

-- Write the code that shows the total number of orders for each customer in descending order.
SELECT CustomerID, Count(CustomerID) AS TotalNumber
FROM Orders
GROUP BY CustomerID
ORDER BY COUNT(CustomerID) DESC;

-- Write the code to determine the top 5 customers with the most orders after the year 1996.
SELECT TOP 5 CustomerID, Count(CustomerID) AS TotalNumber
FROM Orders
WHERE OrderDate >= '1996-01-01'
GROUP BY CustomerID
ORDER BY COUNT(CustomerID) DESC;

-- Write the SQL query to list the top 3 Employees that have the most total freight costs from all of the orders they worked on between Jan 31, 1996 and April 1, 1998.
SELECT TOP 3 e.EmployeeID, e.LastName, e.FirstName, o.Freight
FROM Employees e
JOIN Orders o
ON e.EmployeeID = o.EmployeeID
WHERE o.OrderDate BETWEEN '1996-01-31' AND '1998-04-01'
ORDER BY o.Freight DESC;

-- Write the SQL query to determine which product has the largest number of days between it's first and most recent order.
SELECT TOP 1 d.ProductName, DATEDIFF(day, MIN(o.OrderDate), MAX(o.OrderDate) ) AS days_diff
FROM [Order Details Extended] d
JOIN Orders o
ON d.OrderID = o.OrderID
GROUP BY d.ProductName
ORDER BY days_diff DESC;

-- Write the SQL query to determine which Category of Products had the most orders and the highest total freight cost in the year 1998.
SELECT TOP 1 c.CategoryName, COUNT(c.CategoryName) AS NumOfOrders, SUM(o.Freight) AS SumFreight
FROM Categories c
JOIN Products p
ON c.CategoryID = p.CategoryID
JOIN [Order Details Extended] d
ON p.ProductID = d.ProductID
JOIN Orders o
ON d.OrderID = o.OrderID
WHERE o.OrderDate BETWEEN '1998-01-01' AND '1998-12-31'
GROUP BY c.CategoryName
ORDER BY COUNT(c.CategoryName) DESC, SUM(o.Freight) DESC;

-- Write the SQL query to determine which DISTINCT Beverages were ordered in the year 1996 from suppliers based in the USA and UK.
SELECT p.ProductName
FROM Products p
JOIN Suppliers s
ON p.SupplierID = s.SupplierID
JOIN [Order Details Extended] d
ON p.ProductID = d.ProductID
JOIN Orders o
ON d.OrderID = o.OrderID
WHERE (s.Country = 'USA' OR s.Country = 'UK')
AND (o.OrderDate BETWEEN '1996-01-01' AND '1996-12-31')
AND (p.CategoryID = '1')
GROUP BY p.ProductName;
