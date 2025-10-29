-- Task 3: Using Clauses, Operators and Functions in Queries

-- Employee Table
CREATE TABLE Employee (
  EmpID INT PRIMARY KEY,
  EmpName VARCHAR(50),
  Dept VARCHAR(30),
  Salary DECIMAL(10,2),
  JoiningDate DATE,
  City VARCHAR(30)
);

-- 3.1 DML Operations

-- 1. Insert new employee
INSERT INTO Employee (EmpID, EmpName, Dept, Salary, JoiningDate, City)
VALUES (111, 'Liam Parker', 'Finance', 76000.00, '2024-03-20', 'Dallas');

-- 2. Update salary of employees in IT department by 10%
UPDATE Employee
SET Salary = Salary * 1.10
WHERE Dept = 'IT';

-- 3. Delete employees who joined before 2015
DELETE FROM Employee
WHERE YEAR(JoiningDate) < 2015;


-- 3.2 DRL Queries Using Clauses, Operators and Functions

-- a. Retrieve employees with salary above average salary
SELECT EmpName, Salary
FROM Employee
WHERE Salary > (SELECT AVG(Salary) FROM Employee);

-- b. Display employees with their years of service
SELECT EmpName, 
       TIMESTAMPDIFF(YEAR, JoiningDate, CURDATE()) AS YearsOfService
FROM Employee;

-- c. Retrieve employees whose name starts with 'A'
SELECT *
FROM Employee
WHERE EmpName LIKE 'A%';

-- d. Retrieve total salary per department
SELECT Dept, SUM(Salary) AS TotalSalary
FROM Employee
GROUP BY Dept;

-- e. Retrieve employees joined in the last 2 years
SELECT *
FROM Employee
WHERE JoiningDate >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR);

-- f. Use CASE operator to classify employees by salary
SELECT EmpName, Salary,
       CASE
         WHEN Salary >= 80000 THEN 'High'
         WHEN Salary BETWEEN 60000 AND 79999 THEN 'Medium'
         ELSE 'Low'
       END AS SalaryCategory
FROM Employee;


-- 3.3 Set Operators Examples (Using two similar tables)

-- Create new table
CREATE TABLE NewEmployee AS
SELECT * FROM Employee
WHERE EmpID IN (105, 108, 111);

-- a. Combine employees from both tables without duplicates
SELECT EmpID, EmpName, Dept FROM Employee
UNION
SELECT EmpID, EmpName, Dept FROM NewEmployee;

-- b. Find employees common in both tables
SELECT e.EmpID, e.EmpName, e.Dept
FROM Employee e
INNER JOIN NewEmployee n ON e.EmpID = n.EmpID;

-- c. Find employees in Employee but not in NewEmployee
SELECT e.EmpID, e.EmpName, e.Dept
FROM Employee e
LEFT JOIN NewEmployee n ON e.EmpID = n.EmpID
WHERE n.EmpID IS NULL;


-- 3.4 Using String Functions

-- a. Concatenate employee name and city
SELECT CONCAT(EmpName, ' - ', City) AS EmployeeLocation
FROM Employee;

-- b. Find employees with name length greater than 6
SELECT EmpName, LENGTH(EmpName) AS NameLength
FROM Employee
WHERE LENGTH(EmpName) > 6;
