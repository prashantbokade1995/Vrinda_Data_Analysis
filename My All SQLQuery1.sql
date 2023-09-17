
-- Create a new database
CREATE DATABASE Newdatabase;

-- Connect to the new database
-- \c mydatabase;

-- Use the new database
USE mydatabase;

-- Create the employees table
CREATE TABLE employees (
    employee_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    job_title VARCHAR(100),
    salary DECIMAL(10, 2)
);

select * from employees
-- Retrieve all employees
SELECT * FROM employees;

-- Insert sample data into the employees table
INSERT INTO employees (first_name, last_name, job_title, salary)
VALUES
	('Alice', 'Johnson', 'Accountant', 55000.00),
    ('John', 'Doe', 'Software Engineer', 75000.00),
    ('Jane', 'Smith', 'Product Manager', 90000.00),
    ('Michael', 'Johnson', 'Data Analyst', 60000.00),
    ('Emily', 'Williams', 'Designer', 65000.00);



-- Retrieve all employees
SELECT * FROM employees;

	-- case insesetive
select First_name, last_name from employees

-- Retrieve a specific employee by ID
SELECT * FROM employees WHERE employee_id = 1;

-- Update an employee's job title
UPDATE employees
SET job_title = 'Senior Accountant'
WHERE employee_id = 1;

-- Delete an employee by ID
DELETE FROM employees
WHERE employee_id = 5;


-- delete data from employees
delete from employees

-- delete entire table 
drop table employees


----------------------------------------------------------------------------------------------

-- All data types use in this table

-- Create the data_types_demo table
CREATE TABLE data_types_demo (
    id INT IDENTITY(1,1) PRIMARY KEY,
    text_column TEXT,
    varchar_column VARCHAR(50),
    int_column INT,
    bigint_column BIGINT,
    numeric_column NUMERIC(10, 2),
    boolean_column BIT,
    date_column DATE,
    timestamp_column DATETIME,
    json_column NVARCHAR(MAX),
    jsonb_column NVARCHAR(MAX)
);


-- Insert data into the data_types_demo table
-- Insert more data into the data_types_demo table 1 for TRUE and 0 for FALSE.
INSERT INTO data_types_demo (
text_column, 
varchar_column, 
int_column, 
bigint_column, 
numeric_column, 
boolean_column, 
date_column, 
timestamp_column, 
json_column, 
jsonb_column)
VALUES 
    ('Sample text', 
	'Sample varchar', 
	123, 
	987654321012, 
	45.67, 
	1, 
	'2023-08-24', 
	'2023-08-24 12:30:00', 
	'{"key": "sample_value"}', 
	'{"key": "sample_value"}'),

    ('Data entry', 'Entry value', 567, 123456789012, 78.90, 0, '2023-08-25', '2023-08-25 18:00:00', '{"key": "entry_data"}', '{"key": "entry_data"}'),
    ('Testing', 'Tested value', 789, 456789012345, 34.56, 1, '2023-08-26', '2023-08-26 09:15:00', '{"key": "test_data"}', '{"key": "test_data"}'),
    ('Another text', 'Another varchar', 99, 98765432101234, 987.65, 0, '2023-08-22', '2023-08-22 10:45:00', '{"key": "another_value"}', '{"key": "another_value"}'),
    ('Text value', 'Value', 123, 987654321012, 12.34, 1, '2023-08-23', '2023-08-23 20:15:00', '{"key": "data"}', '{"key": "data"}'),
    ('Some text', 'Varchar value', 42, 12345678901234, 123.45, 1, '2023-08-21', '2023-08-21 15:30:00', '{"key": "value"}', '{"key": "value"}');


	select * from data_types_demo

-- Update data in the data_types_demo table
UPDATE data_types_demo
SET numeric_column = 99.99
WHERE id = 1;

-- Read data from the data_types_demo table
SELECT * FROM data_types_demo;

-- Delete data from the data_types_demo table
DELETE FROM data_types_demo
WHERE id = 1;




-- Create a table with DECIMAL data type
CREATE TABLE decimal_example (
    id INT PRIMARY KEY,
    price DECIMAL(10, 2) -- Precision: 10, Scale: 2
);

-- Insert data with DECIMAL values
INSERT INTO decimal_example (id, price)
VALUES
    (5, 2434),
    (4, 1343.5),
	(1, 24.99),
    (2, 135.50),
    (3, 8.75);

select * from decimal_example

drop table decimal_example 


-- Create a table with NUMERIC data type
CREATE TABLE numeric_example (
    id INT PRIMARY KEY,
    quantity NUMERIC(5, 3) -- Precision: 5, Scale: 3
);

-- Insert data with NUMERIC values
INSERT INTO numeric_example (id, quantity)
VALUES
    (1, 0.3),
    (2, 1.0),
    (3, 23.9);

select * from numeric_example

drop table numeric_example 



-- Create a table with MONEY data type
CREATE TABLE money_example (
    id INT PRIMARY KEY,
    total_amount MONEY
);

-- Insert data with MONEY values
INSERT INTO money_example (id, total_amount)
VALUES
    (1, 123.45),
    (2, 9876.54),
    (3, 65.78);

select * from money_example

-- Create a table with SMALLMONEY data type
CREATE TABLE smallmoney_example (
    id INT PRIMARY KEY,
    small_amount SMALLMONEY
);

-- Insert data with SMALLMONEY values
INSERT INTO smallmoney_example (id, small_amount)
VALUES
    (1, 12.34),
    (2, 567.89),
    (3, 0.55);

select * from smallmoney_example




-- Create a table with REAL data type
CREATE TABLE real_example (
    id INT PRIMARY KEY,
    temperature REAL
);

-- Insert data with REAL values
INSERT INTO real_example (id, temperature)
VALUES
    (1, 23.45),
    (2, 12.67),
    (3, 18.90);

select * from real_example

-- Create a table with FLOAT data type
CREATE TABLE float_example (
    id INT PRIMARY KEY,
    measurement FLOAT
);

-- Insert data with FLOAT values
INSERT INTO float_example (id, measurement)
VALUES
    (1, 123.456789),
    (2, 98765.4321),
    (3, 0.123456789);

select * from float_example


-- Create a table with CHAR data type
CREATE TABLE char_example (
    id INT PRIMARY KEY,
    code CHAR(5)
);

-- Insert data with CHAR values
INSERT INTO char_example (id, code)
VALUES
    (1, 'ABC'),
    (2, '123'),
    (3, 'XYZ');

select * from char_example

-- Create a table with VARCHAR data type
CREATE TABLE varchar_example (
    id INT PRIMARY KEY,
    name VARCHAR(50)
);

-- Insert data with VARCHAR values
INSERT INTO varchar_example (id, name)
VALUES
    (1, 'John Doe'),
    (2, 'Jane Smith'),
    (3, 'Michael Johnson');

select * from varchar_example

-- Create a table with NCHAR data type
CREATE TABLE nchar_example (
    id INT PRIMARY KEY,
    code NCHAR(5)
);

-- Insert data with NCHAR values
INSERT INTO nchar_example (id, code)
VALUES
    (1, N'ABC'),
    (2, N'123'),
    (3, N'XYZ');

select * from nchar_example

-- Create a table with NVARCHAR data type
CREATE TABLE nvarchar_example (
    id INT PRIMARY KEY,
    name NVARCHAR(50)
);

-- Insert data with NVARCHAR values
INSERT INTO nvarchar_example (id, name)
VALUES
    (1, N'John Doe'),
    (2, N'Jane Smith'),
    (3, N'Иван Петров'); -- Unicode characters

select * from nvarchar_example


-- Create the Books table with an identity column
CREATE TABLE Books (
    book_id INT PRIMARY KEY IDENTITY,
    title VARCHAR(100) NOT NULL,
    author VARCHAR(50) NOT NULL
);

-- Create the Users table with an identity column
CREATE TABLE Users (
    user_id INT PRIMARY KEY IDENTITY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

-- Create the BorrowedBooks table with foreign keys
CREATE TABLE BorrowedBooks (
    borrow_id INT PRIMARY KEY IDENTITY,
    book_id INT,
    user_id INT,
    borrow_date DATE NOT NULL,
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Insert data into the Books table
INSERT INTO Books (title, author)
VALUES
    ('Database Management', 'Emily Brown'),
    ('Programming Basics', 'Michael Johnson'),
    ('Data Structures', 'Jessica Smith');


-- Insert data into the Users table
INSERT INTO Users (name, email)
VALUES
    ('Chris Evans', 'chris@example.com'),
    ('Linda Clark', 'linda@example.com'),
    ('Alex Turner', 'alex@example.com');

-- Insert data into the BorrowedBooks table
INSERT INTO BorrowedBooks (book_id, user_id, borrow_date)
VALUES
    (1, 2, '2023-08-20'),
    (2, 1, '2023-08-21'),
    (3, 3, '2023-08-22');


-- Insert a new book
INSERT INTO Books (title, author)
VALUES ('Advanced SQL', 'David Miller');

-- Insert a new user
INSERT INTO Users (name, email)
VALUES ('Sarah Johnson', 'sarah@example.com');

-- Borrow a book
INSERT INTO BorrowedBooks (book_id, user_id, borrow_date)
VALUES (4, 3, '2023-08-25');

-- Update a book's title
UPDATE Books
SET title = 'Advanced SQL Techniques'
WHERE book_id = 4;

-- Update a user's email
UPDATE Users
SET email = 'sarah.j@example.com'
WHERE user_id = 3;

-- Update the borrow date of a book
UPDATE BorrowedBooks
SET borrow_date = '2023-08-26'
WHERE borrow_id = 4;


-- Get all books
SELECT * FROM Books;

-- Get all users
SELECT * FROM Users;

-- Get all BorrowedBooks
SELECT * FROM BorrowedBooks;

-- Get borrowed books and their borrowers' names
SELECT B.title, U.name, BB.borrow_date
FROM BorrowedBooks BB
JOIN Books B ON BB.book_id = B.book_id
JOIN Users U ON BB.user_id = U.user_id;

-- Delete a book
DELETE FROM Books
WHERE book_id = 4;

-- Delete a user
DELETE FROM Users
WHERE user_id = 3;

-- Return a borrowed book (Delete from BorrowedBooks)
DELETE FROM BorrowedBooks
WHERE borrow_id = 4;

-- left join
SELECT Books.title, Users.name
FROM Books
LEFT JOIN BorrowedBooks ON Books.book_id = BorrowedBooks.book_id
LEFT JOIN Users ON BorrowedBooks.user_id = Users.user_id;

-- right join
SELECT Users.name, Books.title
FROM Users
RIGHT JOIN BorrowedBooks ON Users.user_id = BorrowedBooks.user_id
LEFT JOIN Books ON BorrowedBooks.book_id = Books.book_id;

-- outer join
SELECT Books.title, Users.name
FROM Books
FULL OUTER JOIN BorrowedBooks ON Books.book_id = BorrowedBooks.book_id
FULL OUTER JOIN Users ON Users.user_id = BorrowedBooks.user_id;

-- inner join
SELECT Books.title, Users.name
FROM Books
INNER JOIN BorrowedBooks ON Books.book_id = BorrowedBooks.book_id
INNER JOIN Users ON Users.user_id = BorrowedBooks.user_id;

-- union join
SELECT title FROM Books
UNION
SELECT name FROM Users;




-- Corrected foreign key constraint with double quotes

-- Adding a CHECK constraint to enforce a condition
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    age INT,
    grade CHAR(1) CHECK (grade IN ('A', 'B', 'C', 'D', 'F'))
);
