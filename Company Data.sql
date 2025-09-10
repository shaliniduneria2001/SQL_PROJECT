-- Step 1: Create Database
CREATE DATABASE CompanyDB;

-- Step 2: Use Database
USE CompanyDB;

-- Step 3: Create Employees Table
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary INT,
    JoinDate DATE,
    City VARCHAR(50)
);

-- Step 4: Insert Data into Employees
INSERT INTO Employees (EmpID, Name, Department, Salary, JoinDate, City) VALUES
(101, 'Raj Kumar', 'Sales', 50000, '2019-01-15', 'Delhi'),
(102, 'Anita Singh', 'HR', 60000, '2020-03-20', 'Mumbai'),
(103, 'Arjun Mehta', 'IT', 75000, '2021-07-12', 'Bangalore'),
(104, 'Priya Verma', 'Sales', 55000, '2020-11-05', 'Delhi'),
(105, 'Manoj Yadav', 'Finance', 80000, '2018-08-30', 'Kolkata'),
(106, 'Neha Gupta', 'IT', 72000, '2022-04-18', 'Chennai'),
(107, 'Rohit Sharma', 'HR', 58000, '2021-06-25', 'Delhi'),
(108, 'Kavita Jain', 'Sales', 53000, '2019-12-10', 'Mumbai'),
(109, 'Sameer Khan', 'Finance', 90000, '2020-09-15', 'Bangalore'),
(110, 'Alok Pandey', 'IT', 67000, '2019-05-22', 'Delhi');

-- Step 5: Create Departments Table
CREATE TABLE Departments (
    DeptID INT PRIMARY KEY,
    Department VARCHAR(50),
    Manager VARCHAR(50)
);

-- Step 6: Insert Data into Departments
INSERT INTO Departments (DeptID, Department, Manager) VALUES
(1, 'Sales', 'Rakesh Saini'),
(2, 'HR', 'Meena Joshi'),
(3, 'IT', 'Sunil Sharma'),
(4, 'Finance', 'Deepak Rao');




SELECT * FROM Departments,employees;

SELECT * FROM Departments;


-- 1.Display all employees.
SELECT * FROM Employees;
-- 2.Show employees who work in Sales department.
SELECT * FROM Employees
WHERE Department = "Sales";
-- 3.Find employees whose salary is more than 60,000.
SELECT * FROM Employees
WHERE Salary > 60000;
-- 4.List employees who joined after 2020-01-01.
SELECT * FROM Employees
WHERE JoinDate > "2020-01-01";
-- 5.Show employees from Delhi or Mumbai.
SELECT * FROM Employees
WHERE City  IN ("Delhi", "Mumbai");
-- 6.Find employees whose name starts with ‘A’.
SELECT * FROM Employees
WHERE Name Like 'S%';
-- 7.Show employees whose salary is between 55,000 and 80,000.
SELECT * FROM Employees
WHERE Salary BETWEEN 55000 and 80000;
-- 8.Find employees who don’t belong to IT department.
SELECT * FROM Employees
WHERE Department <>("IT");

-- 9.Show all unique departments in the company.
SELECT DISTINCT Department FROM Employees;
-- 10.List all employees ordered by Salary (descending).
SELECT * FROM Employees
ORDER BY Salary Desc;
-- 11.Show top 3 highest paid employees.
SELECT * FROM Employees
ORDER BY Salary Desc
LIMIT 3;

-- 12.Find total number of employees.
SELECT COUNT(EmpId) FROM Employees;
-- 13.Find maximum, minimum, and average salary.
SELECT 
max(salary) AS Maximum_Salary,
min(salary) AS Minimum_Salary,
AVG(salary) AS Average_Salary
FROM Employees;

-- 14.Count how many employees work in each department.
SELECT Department,COUNT(*) FROM Employees
GROUP BY Department;

-- 15.Find total salary expense for IT department.
SELECT SUM(Salary) AS Total_Salary_Expense FROM Employees
WHERE Department = "IT";


-- 16.Show department-wise average salary.
SELECT Department,AVG(Salary) FROM Employees
GROUP BY Department;
-- 17.Find departments having more than 2 employees.
SELECT Department, COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY Department
HAVING COUNT(*) > 2;

-- 18.Join Employees and Departments to display employee name with their manager.
SELECT * FROM Employees AS e
JOIN
Departments AS d
ON e.Department = d.Department;
-- 19.Show all employees and their department manager (even if some employees are not assigned a manager → LEFT JOIN).
SELECT 
    e.EmpID,
    e.Name AS EmployeeName,
    e.Department,
    d.Manager
FROM Employees e
LEFT JOIN Departments d
    ON e.Department = d.Department;
-- 20.Show departments that have no employees (use RIGHT JOIN or FULL JOIN).
SELECT 
    d.DeptID,
    d.Department,
    d.Manager
FROM Employees e
RIGHT JOIN Departments d
    ON e.Department = d.Department
WHERE e.EmpID IS NULL;


-- 21.Find the second highest salary
SELECT max(Salary) AS Second_highest_salary 
FROM Employees
WHERE Salary < (SELECT max(Salary) FROM Employees);

-- 22.Find the third highest salary
SELECT Salary AS Third_highest_salary 
FROM Employees
order by salary desc
limit 1 offset 2;

-- 23.Show employees earning more than average salary
SELECT * FROM Employees
WHERE Salary > (SELECT AVG(Salary) FROM Employees);


-- 24.Show employees whose salary is more than "Raj Kumar"
SELECT * FROM Employees
WHERE Salary > (SELECT Salary FROM EMployees
WHERE Name = "Raj Kumar");


-- 25.Employees who joined in 2020
SELECT * FROM Employees
WHERE Year(JoinDAte) = '2020';


-- 26.Employees without any department
SELECT * FROM Employees
WHERE Department IS NULL;



SELECT 
    Name, Department, Salary,
    RANK() OVER (ORDER BY Salary DESC) AS SalaryRank,
    DENSE_RANK() OVER (ORDER BY Salary DESC) AS DenseSalaryRank,
    ROW_NUMBER() OVER (ORDER BY Salary DESC) AS RowNum
FROM Employees;


-- 27.Show department-wise highest salary
SELECT Department, max(Salary) AS Highest_salary
FROM Employees
GROUP BY Department;

-- 28. Show employee name, department and manager
SELECT e.Name, e.Department, d.Manager 
FROM Employees AS e
JOIN Departments AS d
ON e.Department = d.Department;

-- 29.Departments having at least 3 employees
SELECT Department, COUNT(*) AS Employee_count
FROM Employees
GROUP BY Department
HAVING COUNT(*) >= 3;


-- 30. Show employees with salary category (High/Low)
SELECT Name,Salary,
CASE 
 WHEN Salary >= 70000 THEN 'High'
           ELSE 'Low'
       END AS SalaryCategory
FROM Employees;

-- 31.Show employees whose name contains "an"
SELECT * FROM Employees
WHERE Name Like '%an%';

-- 32.Employees from Delhi or Mumbai using UNION  
SELECT Name,City FROM Employees
WHERE City = "Delhi"
UNION
SELECT Name,City FROM Employees
WHERE City = "Mumbai";


-- 33.Show employees with duplicate salaries
SELECT Salary, COUNT(*) FROM Employees
GROUP BY Salary
HAVING COUNT(*) > 1;

-- 34. Count employees joined each year
SELECT YEAR(JoinDate) AS JoinYear, COUNT(*) AS TotalEmployees
FROM Employees
GROUP BY YEAR(JoinDate);

-- 35.. Departments that have no employees
SELECT Department
FROM Departments
WHERE Department NOT IN (SELECT DISTINCT Department FROM Employees);



SELECT 
    Name, Department, Salary,
    RANK() OVER (ORDER BY Salary DESC) AS SalaryRank,
    DENSE_RANK() OVER (ORDER BY Salary DESC) AS DenseSalaryRank,
    ROW_NUMBER() OVER (ORDER BY Salary DESC) AS RowNum
FROM Employees;


