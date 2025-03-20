
select * from orders1;
select * from customers1;
select * from products1;
select * from order_details;

-- Basic SQL Questions
-- 1.Retrieve all records from the Customers table.
SELECT * FROM Customers1;

-- 2.Retrieve all products under the "Electronics" category.
SELECT * FROM Products1
WHERE Category = "Electronics";


-- 3.Find all orders placed by a specific customer (e.g., CustomerID = 5).
SELECT * FROM Orders1
WHERE CustomerID = 5;

-- 4.Find the total number of orders placed.
SELECT COUNT(*) FROM Orders1;


-- 5.Retrieve all orders sorted by the latest first.
SELECT * FROM Orders1
ORDER BY OrderDate DESC;

-- Intermediate SQL Questions
-- 6.Calculate the total revenue from all orders.
SELECT SUM(TotalAmount)AS TotalRevenue FROM Orders1;


-- 7.Find the most popular product (highest quantity sold).
SELECT ProductID, SUM(Quantity) AS TotalSold 
FROM Order_Details 
GROUP BY ProductID 
ORDER BY TotalSold DESC 
LIMIT 1;
-- 8.Find customers who have placed more than 5 orders.
SELECT CustomerID, COUNT(OrderID) AS TotalOrders 
FROM Orders1 
GROUP BY CustomerID 
HAVING TotalOrders > 5;


-- 9.Find the number of products in each category.
SELECT Category, COUNT(*) AS TotalProducts 
FROM Products1 
GROUP BY Category;

-- 10.Find the highest and lowest price of products in each category.
SELECT Category, MAX(Price) AS MaxPrice, MIN(Price) AS MinPrice 
FROM Products1 
GROUP BY Category;


-- Advanced SQL Questions
-- 11.Find the top 5 customers who spent the most money.
SELECT CustomerID, SUM(TotalAmount) AS TotalSpent 
FROM Orders1 
GROUP BY CustomerID 
ORDER BY TotalSpent DESC 
LIMIT 5;


-- 12.Calculate the monthly revenue for the last 6 months.
SELECT DATE_FORMAT(OrderDate, '%Y-%m') AS Month, SUM(TotalAmount) AS MonthlyRevenue 
FROM Orders1 
WHERE OrderDate >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH) 
GROUP BY Month 
ORDER BY Month DESC;


-- 13.Find out-of-stock products.
SELECT * FROM Products1 
WHERE StockQuantity = 0;


-- 14.Find the total quantity of each product sold.
SELECT OrderID, COUNT(ProductID) AS ProductCount 
FROM Order_Details 
GROUP BY OrderID 
HAVING ProductCount > 3;


-- 15.Identify orders that contain more than 3 products.
SELECT OrderID, COUNT(ProductID) AS ProductCount 
FROM Order_Details 
GROUP BY OrderID 
HAVING ProductCount > 3;


