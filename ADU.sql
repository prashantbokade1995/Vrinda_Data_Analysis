CREATE DATABASE IF NOT EXISTS mydatabase;
DROP DATABASE IF EXISTS mydatabase;
USE mydatabase;

CREATE TABLE IF NOT EXISTS employees (
    id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT
);

SELECT * FROM mydatabase.employees;

INSERT INTO employees (id, first_name, last_name, age)
VALUES
		(1, 'John', 'Doe', 30),
       (2, 'Jane', 'Smith', 28),
    (3, 'Michael', 'Johnson', 35),
    (4, 'Emily', 'Williams', 27),
    (5, 'David', 'Brown', 42),
    (6, 'Sarah', 'Miller', 31),
    (7, 'James', 'Taylor', 29),
    (8, 'Jessica', 'Anderson', 24),
    (9, 'Robert', 'Thomas', 38),
    (10, 'Linda', 'Martinez', 45),
    (11, 'William', 'Hernandez', 33),
    (12, 'Karen', 'Jones', 26),
    (13, 'Richard', 'Garcia', 39),
    (14, 'Alex', 'Rodriguez', 28),
    (15, 'Mary', 'Lopez', 36),
    (16, 'Joseph', 'Perez', 30),
    (17, 'Patricia', 'Williams', 29),
    (18, 'Charles', 'Jackson', 42),
    (19, 'Jennifer', 'Brown', 31),
    (20, 'Daniel', 'Davis', 34),
    (21, 'Nancy', 'Smith', 28),
    (22, 'Thomas', 'Miller', 37);

SELECT * FROM employees;

SELECT * FROM employees
WHERE age > 25
ORDER BY last_name;

ALTER TABLE employees
ADD email VARCHAR(100);

UPDATE employees
SET email = 'pra@gmial.com'
WHERE "David";


UPDATE employees
SET age = 29
WHERE first_name = 'Emily';
-- Delete up to 100 rows with last_name = 'Michael'
DELETE FROM employees WHERE last_name = 'Michael' LIMIT 100;

UPDATE employees
SET age = 30
WHERE first_name = 'Michael';

DELETE FROM employees
WHERE last_name = 'Michael';

DELETE FROM employees WHERE id = 3;

CREATE INDEX idx_last_name ON employees (last_name);

SELECT * FROM employees;
GRANT SELECT, INSERT ON mydatabase.* TO 'username'@'localhost';
REVOKE INSERT ON mydatabase.* FROM 'username'@'localhost';



SELECT * FROM employees;