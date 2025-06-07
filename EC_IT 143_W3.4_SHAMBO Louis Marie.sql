/*****************************************************************************************************************
NAME:    SHAMBO Louis Marie
PURPOSE: Assignment 3.4

MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     06/07/2025   SHAMBO Louis Marie       1. Built this script for EC IT143


RUNTIME: 
4.8hours

NOTES: Those are questions and their respective answers about AdventureWorks Database.
 
******************************************************************************************************************/

--Q1. What is the name of the employee with the highest vacation hours? Objective: Identify the employee who has accumulated the most vacation hours.
--ANSWER:

SELECT TOP 1 p.FirstName, p.LastName, e.VacationHours
FROM HumanResources.Employee e
JOIN Person.Person p ON e.BusinessEntityID = p.BusinessEntityID
ORDER BY e.VacationHours DESC;

--Q2. How many products are currently marked as finished goods? Objective: Count the number of products designated as finished goods.
--Answer:
SELECT COUNT(*) AS FinishedGoodsCount
FROM Production.Product
WHERE FinishedGoodsFlag = 1;

--Q3. What are the names and email addresses of customers who placed online orders in 2022? Objective: Retrieve customer names and emails for online orders made in 2022.
--Answer:
SELECT DISTINCT p.FirstName, p.LastName, ea.EmailAddress
FROM Sales.SalesOrderHeader soh
JOIN Sales.Customer c ON soh.CustomerID = c.CustomerID
JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
JOIN Person.EmailAddress ea ON p.BusinessEntityID = ea.BusinessEntityID
WHERE soh.OnlineOrderFlag = 1
  AND YEAR(soh.OrderDate) = 2022;

--Q4. Which products were sold in red color, and how many units were ordered for each? Objective: Identify red-colored products and the total units sold for each.
SELECT p.Name AS ProductName, SUM(sod.OrderQty) AS TotalUnitsSold
FROM Production.Product p
JOIN Sales.SalesOrderDetail sod ON p.ProductID = sod.ProductID
WHERE p.Color = 'Red'
GROUP BY p.Name;

--Q5. As a sales manager reviewing regional performance, I need to know the top five salespeople by total sales revenue in 2022. Include their names, territories, and revenue generated.
--Objective: Determine the top 5 salespeople based on revenue in 2022, along with their territories.
--Answer:
SELECT TOP 5 p.FirstName, p.LastName, st.Name AS Territory, SUM(soh.TotalDue) AS TotalRevenue
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesPerson sp ON soh.SalesPersonID = sp.BusinessEntityID
JOIN Sales.SalesTerritory st ON sp.TerritoryID = st.TerritoryID
JOIN Person.Person p ON sp.BusinessEntityID = p.BusinessEntityID
WHERE YEAR(soh.OrderDate) = 2022
GROUP BY p.FirstName, p.LastName, st.Name
ORDER BY TotalRevenue DESC;

--Q6. The marketing team is launching a loyalty program. Identify customers who have placed more than 10 orders and spent over $10,000 total since 2021. Provide their names and contact details.
--Objective: Find customers with significant purchase history since 2021.
SELECT p.FirstName, p.LastName, ea.EmailAddress, COUNT(soh.SalesOrderID) AS OrderCount, SUM(soh.TotalDue) AS TotalSpent
FROM Sales.SalesOrderHeader soh
JOIN Sales.Customer c ON soh.CustomerID = c.CustomerID
JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
JOIN Person.EmailAddress ea ON p.BusinessEntityID = ea.BusinessEntityID
WHERE soh.OrderDate >= '2021-01-01'
GROUP BY p.FirstName, p.LastName, ea.EmailAddress
HAVING COUNT(soh.SalesOrderID) > 10 AND SUM(soh.TotalDue) > 10000;

--What are the names and data types of all columns in the SalesOrderHeader table? Objective: Retrieve column names and data types for the SalesOrderHeader table.
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'SalesOrderHeader';

--Q8. Which tables contain a column named ‘ModifiedDate’? Objective: Identify all tables that have a ModifiedDate column.
SELECT TABLE_SCHEMA, TABLE_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'ModifiedDate';


--Thank you!

