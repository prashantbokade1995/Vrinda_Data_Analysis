create database newdb;
use newdb;

CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL
);
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id),
    CHECK (employee_id > 0)
);

-- Inserting data into Departments table
INSERT INTO Departments (department_id, department_name)
VALUES (1, 'HR'), (2, 'Engineering');

-- Inserting data into Employees table
INSERT INTO Employees (employee_id, first_name, last_name, department_id)
VALUES (101, 'John', 'Doe', 1),
       (102, 'Jane', 'Smith', 2);
       
-- Trying to insert a duplicate primary key value
INSERT INTO Employees (employee_id, first_name, last_name, department_id)
VALUES (104, 'Alice', 'Johnson', 4); -- This will fail due to the primary key constraint

-- Updating an employee's department
UPDATE Employees
SET department_id = 2
WHERE employee_id = 101;

select * from Employees;

-- Trying to update department_id to a value that doesn't exist in Departments
UPDATE Employees
SET department_id = 3
WHERE employee_id = 101; -- This will fail due to the foreign key constraint

-- Deleting an employee
DELETE FROM Employees
WHERE employee_id = 101;

-- Trying to delete a department that has associated employees
DELETE FROM Departments
WHERE department_id = 3;


-- Inserting a new department
INSERT INTO Departments (department_id, department_name)
VALUES (3, 'Sales');

-- Trying to insert a new employee with a non-existent department_id
INSERT INTO Employees (employee_id, first_name, last_name, department_id)
VALUES (103, 'Michael', 'Brown', 4); -- This will fail due to the foreign key constraint

-- Updating an employee's last name
UPDATE Employees
SET last_name = 'Johnson'
WHERE employee_id = 101;

-- Deleting an employee
DELETE FROM Employees
WHERE employee_id = 101;

-- Deleting a department along with its employees using CASCADE
DELETE FROM Departments
WHERE department_id = 1; -- This will delete associated employees due to CASCADE

-- Adding a check constraint to prevent negative employee_id values
ALTER TABLE Employees
ADD CHECK (employee_id > 0);

-- Trying to insert an employee with a negative employee_id
INSERT INTO Employees (employee_id, first_name, last_name, department_id)
VALUES (-1, 'Invalid', 'Employee', 3); -- This will fail due to the check constraint

