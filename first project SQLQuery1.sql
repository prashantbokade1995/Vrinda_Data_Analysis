-- SELECT
SELECT * FROM Company.Employee;
SELECT * FROM Company.Salary;

-- remove constraint-- Drop the foreign key constraint
ALTER TABLE Company.Salary
DROP CONSTRAINT FK_Salary_Employee;

-- Drop the Salary table
DROP TABLE Company.Salary;
DROP TABLE Company.Employee;
-- Truncate the Employee table
TRUNCATE TABLE Company.Employee;

DROP DATABASE Company_data;

create database Company_data;

use Company_data;

-- Create the schema
CREATE SCHEMA Company;

-- Create the Employee table
CREATE TABLE Company.Employee (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10, 2),
    HireDate DATE
);

-- Create the Salary table
CREATE TABLE Company.Salary (
    SalaryID INT PRIMARY KEY,
    EmployeeID INT,
    Amount DECIMAL(10, 2),
    CONSTRAINT FK_Salary_Employee FOREIGN KEY (EmployeeID) REFERENCES Company.Employee(EmployeeID)
);

-- SELECT
SELECT * FROM Company.Employee;
SELECT * FROM Company.Salary;


-- Insert data into Employee table
INSERT INTO Company.Employee (EmployeeID, FirstName, LastName, Department, Salary, HireDate)
VALUES
    (1, 'John', 'Doe', 'IT', 60000.00, '2023-01-15'),
    (2, 'Alice', 'Johnson', 'Marketing', 55000.00, '2023-02-10'),
    (3, 'Michael', 'Williams', 'IT', 62000.00, '2022-11-20'),
    (4, 'Emily', 'Brown', 'HR', 50000.00, '2023-03-01'),
    (5, 'William', 'Smith', 'IT', 58000.00, '2022-09-15'),
    (6, 'Olivia', 'Miller', 'Marketing', 53000.00, '2023-04-05'),
    (7, 'James', 'Wilson', 'IT', 65000.00, '2022-07-10'),
    (8, 'Sophia', 'Taylor', 'HR', 52000.00, '2022-12-15'),
    (9, 'Alexander', 'Anderson', 'Finance', 70000.00, '2023-01-20'),
    (10, 'Isabella', 'Thomas', 'Marketing', 58000.00, '2022-08-10'),
    (11, 'Liam', 'Jones', 'Finance', 75000.00, '2023-02-28');

-- Insert data into Salary table
INSERT INTO Company.Salary (SalaryID, EmployeeID, Amount)
VALUES
    (1, 1, 60000.00),
    (2, 2, 55000.00),
    (3, 3, 62000.00),
    (4, 4, 50000.00),
    (5, 5, 58000.00),
    (6, 6, 53000.00),
    (7, 7, 65000.00),
    (8, 8, 52000.00),
    (9, 9, 70000.00),
    (10, 10, 58000.00),
    (11, 11, 75000.00);


-- SELECT
SELECT * FROM Company.Employee;
SELECT * FROM Company.Salary;


-- UPDATE
UPDATE Company.Employee
SET Salary = Salary * 1.1
WHERE Department = 'IT';

-- remove constraint-- Drop the foreign key constraint
ALTER TABLE Company.Salary
DROP CONSTRAINT FK_Salary_Employee;

-- DELETE
DELETE FROM Company.Employee
WHERE HireDate < '2023-01-01';


-- INNER JOIN
SELECT e.FirstName, e.LastName, s.Amount
FROM Company.Employee e
INNER JOIN Company.Salary s ON e.EmployeeID = s.EmployeeID;

-- LEFT OUTER JOIN
SELECT e.FirstName, e.LastName, s.Amount
FROM Company.Employee e
LEFT JOIN Company.Salary s ON e.EmployeeID = s.EmployeeID;



-- Comparison Operators
SELECT * FROM Company.Employee 
WHERE Salary > 50000;

-- Logical Operators
SELECT * FROM Company.Employee
WHERE Department = 'IT' AND Salary > 50000;

-- IN Operator
SELECT * FROM Company.Employee
WHERE Department IN ('IT', 'HR');

-- BETWEEN Operator
SELECT * FROM Company.Employee
WHERE HireDate BETWEEN '2022-01-01' AND '2023-01-01';

-- IS NULL Operator
SELECT * FROM Company.Employee
WHERE Salary IS NULL;


-- Combining Operators
SELECT * FROM Company.Employee
WHERE Department = 'IT'
AND (Salary > 60000 OR HireDate < '2022-01-01');


-- Subquery
SELECT FirstName, LastName
FROM Company.Employee
WHERE Salary > (SELECT AVG(Amount) FROM Company.Salary);


-- Select employees with salary greater than 60000 or in the HR department
SELECT * FROM Company.Employee
WHERE Salary > 60000 OR Department = 'HR';

-- Select employees with salary between 50000 and 60000
SELECT * FROM Company.Employee
WHERE Salary BETWEEN 50000 AND 60000;

-- Select employees in IT or Marketing departments
SELECT * FROM Company.Employee
WHERE Department IN ('IT', 'Marketing');


-- Select employees with no assigned salary
SELECT * FROM Company.Employee
WHERE EmployeeID NOT IN (SELECT EmployeeID FROM Company.Salary);

-- Select employees in IT department with either no salary or salary above 60000
SELECT * FROM Company.Employee
WHERE Department = 'IT'
AND (Salary IS NULL OR Salary > 60000);

-- Select employees and their average salary for each department
SELECT Department, AVG(Salary) AS AvgSalary
FROM Company.Employee
GROUP BY Department
HAVING AVG(Salary) > 55000
ORDER BY AvgSalary DESC;

-- Select the top 5 highest-paid employees
SELECT TOP 5 FirstName, LastName, Salary
FROM Company.Employee
ORDER BY Salary DESC;


-- Select employees and their average salary for each department
SELECT Department, AVG(Salary) AS AvgSalary
FROM Company.Employee
GROUP BY Department
HAVING AVG(Salary) > 55000
ORDER BY AvgSalary DESC;

 -- Select the top 5 highest-paid employees
SELECT TOP 5 FirstName, LastName, Salary
FROM Company.Employee
ORDER BY Salary DESC;


-- Select employees with salaries higher than the average salary
SELECT FirstName, LastName
FROM Company.Employee
WHERE Salary > (SELECT AVG(Salary) FROM Company.Employee);

-- Select employees who are not in the Salary table
SELECT FirstName, LastName
FROM Company.Employee
WHERE EmployeeID NOT IN (SELECT EmployeeID FROM Company.Salary);


SELECT Department, AVG(Salary) AS AvgSalary
FROM Company.Employee
WHERE Department IN ('IT', 'HR', 'Marketing')
GROUP BY Department;

SELECT Department, COUNT(*) AS EmployeeCount
FROM Company.Employee
GROUP BY Department;

SELECT Department, SUM(Salary) AS TotalSalary
FROM Company.Employee
GROUP BY Department;

SELECT Department, MAX(Salary) AS MaxSalary
FROM Company.Employee
GROUP BY Department;

SELECT YEAR(HireDate) AS HireYear, AVG(Salary) AS AvgSalary
FROM Company.Employee
GROUP BY YEAR(HireDate)
ORDER BY HireYear;

SELECT *
FROM Company.Employee
WHERE Department = 'HR';

-- Delete related salary records
DELETE FROM Company.Salary
WHERE EmployeeID IN (SELECT EmployeeID FROM Company.Employee WHERE HireDate < '2023-01-01');

-- Now you can delete the employee records
DELETE FROM Company.Employee
WHERE HireDate < '2023-01-01';

-- Update related salary records
UPDATE Company.Salary
SET EmployeeID = NULL
WHERE EmployeeID IN (SELECT EmployeeID FROM Company.Employee WHERE HireDate < '2023-01-01');




-- Add the 'Email' column to Employee table
ALTER TABLE Company.Employee
ADD Email VARCHAR(100);

-- Add UNIQUE constraint to Email column
ALTER TABLE Company.Employee
ADD CONSTRAINT UK_Employee_Email UNIQUE (Email);


-- Adding NOT NULL constraint
ALTER TABLE Company.Employee
ALTER COLUMN Department VARCHAR(50) NOT NULL;

-- Adding CHECK constraint
ALTER TABLE Company.Salary
ADD CONSTRAINT CHK_Salary_Amount CHECK (Amount > 0);

-- Add the 'Email' column to Employee table
ALTER TABLE Company.Employee
ADD Email VARCHAR(100);

-- Insert data into Employee table
-- Insert data into Employee table with unique EmployeeID values
INSERT INTO Company.Employee (EmployeeID, FirstName, LastName, Department, Salary, HireDate)
VALUES
    (12, 'New', 'Employee', 'IT', 65000.00, '2023-04-01'),
    (13, 'Another', 'Employee', 'HR', 52000.00, '2023-04-02');

