
DROP DATABASE IF EXISTS student_db;

CREATE DATABASE student_db;
USE student_db;

-- Create database if not exists
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'student_db')
BEGIN
    CREATE DATABASE student_db;
END;

USE student_db;

-- Create Student table
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Student')
BEGIN
    CREATE TABLE Student (
        student_id INT PRIMARY KEY,
        first_name VARCHAR(50),
        last_name VARCHAR(50),
        date_of_birth DATE,
        email VARCHAR(100),
        major VARCHAR(50),
        graduation_year INT
    );
END;

-- Create Course table
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Course')
BEGIN
    CREATE TABLE Course (
        course_id INT PRIMARY KEY,
        course_name VARCHAR(100),
        instructor VARCHAR(100),
        credits INT
    );
END;

-- Create Enrollment table
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Enrollment')
BEGIN
    CREATE TABLE Enrollment (
        enrollment_id INT PRIMARY KEY,
        student_id INT,
        course_id INT,
        enrollment_date DATE,
        FOREIGN KEY (student_id) REFERENCES Student(student_id),
        FOREIGN KEY (course_id) REFERENCES Course(course_id)
    );
END;

-- Insert students
INSERT INTO Student (student_id, first_name, last_name, date_of_birth, email, major, graduation_year)
VALUES
    (1, 'John', 'Doe', '1998-05-15', 'john.doe@example.com', 'Computer Science', 2023),
    (2, 'Jane', 'Smith', '1999-02-20', 'jane.smith@example.com', 'Engineering', 2024),
    (3, 'Alice', 'Johnson', '2000-09-10', 'alice.johnson@example.com', 'Biology', 2023),
	(4, 'Michael', 'Williams', '2001-07-03', 'michael.williams@example.com', 'Psychology', 2022),
    (5, 'Emily', 'Brown', '2000-11-25', 'emily.brown@example.com', 'Art History', 2024);

-- Insert courses
INSERT INTO Course (course_id, course_name, instructor, credits)
VALUES
    (101, 'Introduction to Programming', 'Dr. Smith', 3),
    (102, 'Database Management', 'Prof. Johnson', 4),
    (103, 'Data Structures', 'Dr. Williams', 3),
	(104, 'Linear Algebra', 'Prof. Adams', 3),
    (105, 'Web Development', 'Dr. Martinez', 4),
    (106, 'Chemistry 101', 'Prof. Wilson', 3),
	(107, 'Art Appreciation', 'Prof. Davis', 2),
    (108, 'Statistics', 'Dr. Wilson', 3);	

-- Enroll students in courses
INSERT INTO Enrollment (enrollment_id, student_id, course_id, enrollment_date)
VALUES
    (1, 1, 101, '2023-01-15'),
    (2, 1, 102, '2023-02-10'),
    (3, 2, 101, '2023-01-15'),
    (4, 3, 103, '2023-03-05'),
	(5, 3, 105, '2023-04-20'),
    (6, 4, 106, '2023-02-28'),
    (7, 5, 104, '2023-03-15');
	

-- check null value
SELECT *
FROM Student
WHERE email IS NULL;

-- Fill Null Values:
UPDATE Student
SET email = 'N/A'
WHERE email IS NULL;


-- Data Cleaning Remove Duplicate Rows:
WITH DuplicateCTE AS (
    SELECT
        student_id,
        first_name,
        last_name,
        ROW_NUMBER() OVER (PARTITION BY first_name, last_name ORDER BY student_id) AS RowNum
    FROM Student
)
DELETE FROM DuplicateCTE WHERE RowNum > 1;

--Data Preprocessing Data Transformation
UPDATE Student
SET graduation_year = YEAR(GETDATE())
WHERE graduation_year > YEAR(GETDATE());

-- Data Aggregation
SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    SUM(c.credits) AS total_credits
FROM
    Student s
JOIN
    Enrollment e ON s.student_id = e.student_id
JOIN
    Course c ON e.course_id = c.course_id
GROUP BY
    s.student_id, s.first_name, s.last_name;

-- Clean up staging tables (if applicable)
TRUNCATE TABLE StagingTable1;
TRUNCATE TABLE StagingTable2;

-- Recreate the foreign key constraints
ALTER TABLE Enrollment
ADD CONSTRAINT FK_Student_Enrollment FOREIGN KEY (student_id) REFERENCES Student(student_id);
ALTER TABLE Enrollment
ADD CONSTRAINT FK_Course_Enrollment FOREIGN KEY (course_id) REFERENCES Course(course_id);

-- Drop foreign key constraints
ALTER TABLE Enrollment DROP CONSTRAINT FK_Student_Enrollment;
ALTER TABLE Enrollment DROP CONSTRAINT FK_Course_Enrollment;

-- Ensure that the following 'student_id' values (1, 2, 3, 4, 5, 6, 7) correspond to valid students
INSERT INTO Enrollment (enrollment_id, student_id, course_id, enrollment_date)
VALUES
    (8, 6, 101, '2023-01-22'),
    (9, 7, 102, '2023-02-18');

INSERT INTO Course (course_id, course_name, instructor, credits)
VALUES
    (109, 'Advanced Programming', 'Prof. Rodriguez', 4),
    (110, 'Differential Equations', 'Dr. Brown', 3);
-- Insert more courses as needed

INSERT INTO Student (student_id, first_name, last_name, date_of_birth, email, major, graduation_year)
VALUES
    (6, 'David', 'Johnson', '2002-08-12', 'david.johnson@example.com', 'Physics', 2024),
    (7, 'Linda', 'Wilson', '2003-03-25', 'linda.wilson@example.com', 'Chemistry', 2023);
-- Insert more students as needed


select * from Student;
select * from  Course;
select * from  Enrollment;

-- Find courses with more than 3 credits
SELECT course_name, credits
FROM Course
WHERE credits > 3;


-- Retrieve student information and courses they are enrolled in
SELECT
    s.first_name,
    s.last_name,
    c.course_name
FROM
    Student s
JOIN
    Enrollment e ON s.student_id = e.student_id
JOIN
    Course c ON e.course_id = c.course_id;

-- Calculate the average credits of courses
SELECT AVG(credits) AS avg_credits FROM Course;

-- Calculate the average graduation year of students
SELECT AVG(graduation_year) AS avg_graduation_year
FROM Student;

-- Concatenate first and last names of students
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM Student;

-- Classify students by their graduation year
SELECT
    first_name,
    last_name,
    CASE
        WHEN graduation_year > 2023 THEN 'Future Graduate'
        WHEN graduation_year = 2023 THEN 'Current Graduate'
        ELSE 'Previous Graduate'
    END AS graduation_status
FROM Student;

--Date Function
-- Calculate the age of students
SELECT
    first_name,
    last_name,
    CASE
        -- For SQL Server
        WHEN DATEDIFF(YEAR, date_of_birth, GETDATE()) < 0 THEN 0
        ELSE DATEDIFF(YEAR, date_of_birth, GETDATE())
    END AS age
FROM Student;



-- left join
-- Count the number of students in each major
SELECT
    s.first_name,
    s.last_name
FROM
    Student s
LEFT JOIN
    Enrollment e ON s.student_id = e.student_id
WHERE
    e.student_id IS NULL;

-- left join
SELECT
    c.course_name
FROM
    Course c
LEFT JOIN
    Enrollment e ON c.course_id = e.course_id
WHERE
    e.course_id IS NULL;

-- having clause
SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    COUNT(e.course_id) AS num_courses_enrolled
FROM
    Student s
JOIN
    Enrollment e ON s.student_id = e.student_id
GROUP BY
    s.student_id, s.first_name, s.last_name
HAVING  
    COUNT(e.course_id) > 1;


SELECT
    c.course_name,
    COUNT(s.student_id) AS num_students
FROM
    Course c
JOIN
    Enrollment e ON c.course_id = e.course_id
JOIN
    Student s ON e.student_id = s.student_id
GROUP BY
    c.course_id, c.course_name
HAVING
    COUNT(s.student_id) > 2;


SELECT
    s.first_name,
    s.last_name,
    subquery.num_courses_enrolled
FROM
    Student s
JOIN
    (
        SELECT
            student_id,
            COUNT(course_id) AS num_courses_enrolled
        FROM
            Enrollment
        GROUP BY
            student_id
        HAVING
            COUNT(course_id) > 1
    ) subquery
ON
    s.student_id = subquery.student_id;


SELECT
    s1.first_name AS student1_first,
    s1.last_name AS student1_last,
    s2.first_name AS student2_first,
    s2.last_name AS student2_last,
    c.course_name
FROM
    Student s1
JOIN
    Enrollment e1 ON s1.student_id = e1.student_id
JOIN
    Course c ON e1.course_id = c.course_id
JOIN
    Enrollment e2 ON e1.course_id = e2.course_id AND e1.student_id < e2.student_id
JOIN
    Student s2 ON e2.student_id = s2.student_id;

-- Retrieve students enrolled in the "Web Development" course
SELECT
    s.first_name,
    s.last_name
FROM
    Student s
JOIN
    Enrollment e ON s.student_id = e.student_id
JOIN
    Course c ON e.course_id = c.course_id
WHERE
    c.course_name = 'Web Development';

-- Retrieve courses and their enrolled students using RIGHT JOIN
SELECT
    c.course_name,
    s.first_name,
    s.last_name
FROM
    Course c
RIGHT JOIN
    Enrollment e ON c.course_id = e.course_id
RIGHT JOIN
    Student s ON e.student_id = s.student_id;

-- Find students who are enrolled in both 'Database Management' and 'Web Development' courses
SELECT s.first_name, s.last_name
FROM Student s
JOIN Enrollment e ON s.student_id = e.student_id
JOIN Course c ON e.course_id = c.course_id
WHERE c.course_name = 'Database Management'
  AND EXISTS (
      SELECT 1
      FROM Enrollment e2
      JOIN Course c2 ON e2.course_id = c2.course_id
      WHERE c2.course_name = 'Web Development'
        AND e2.student_id = s.student_id
  );



-- Create a new table
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    hire_date DATE
);

-- Add a new column to an existing table
ALTER TABLE Employees
ADD department VARCHAR(50);

-- Rename a table
EXEC sp_rename 'Employees', 'Staff';

-- Delete a table
-- DROP TABLE Staff;

-- Insert new records
INSERT INTO Employees (employee_id, first_name, last_name, hire_date)
VALUES
    (1, 'John', 'Doe', '2022-01-15'),
    (2, 'Jane', 'Smith', '2021-03-10');

-- Update records
UPDATE Employees
SET first_name = 'john'
WHERE employee_id = 1;

-- Delete records
DELETE FROM Employees
WHERE employee_id = 2;

-- Retrieve all employee names
SELECT first_name, last_name
FROM Employees;

-- Retrieve employees hired after a specific date
SELECT first_name, last_name
FROM Employees
WHERE hire_date > '2022-01-01';

-- Calculate average hire year
SELECT AVG(YEAR(hire_date)) AS avg_hire_year
FROM Employees;


-- Grant privileges to a user
GRANT SELECT, INSERT ON Employees TO 'user1'@'localhost';

-- Revoke privileges from a user
REVOKE INSERT ON Employees FROM 'user1'@'localhost';

-- Start a transaction
START TRANSACTION;

-- Commit the transaction
COMMIT;

-- Rollback the transaction
ROLLBACK;

-- Start a transaction
BEGIN TRANSACTION;

-- Execute some SQL statements
INSERT INTO MyTable (column1, column2) VALUES ('A', 1);

-- Create a savepoint by saving the transaction name
SAVE TRANSACTION my_savepoint;

-- Execute more SQL statements
INSERT INTO MyTable (column1, column2) VALUES ('B', 2);

-- Roll back to the savepoint, undoing the changes made after the savepoint
ROLLBACK TRANSACTION my_savepoint;

-- Execute additional SQL statements
INSERT INTO MyTable (column1, column2) VALUES ('C', 3);

-- Commit the transaction
COMMIT;

--Window Functions:

--ROW_NUMBER():
SELECT student_id, first_name, last_name, ROW_NUMBER() OVER (ORDER BY graduation_year) AS row_num
FROM Student;

--RANK(): Assigns a unique rank to each row in the result set, with the same rank for tied rows.
SELECT student_id, first_name, last_name, RANK() OVER (ORDER BY graduation_year) AS rank
FROM Student;


--DENSE_RANK(): Assigns a unique dense rank to each row, similar to RANK(), but without gaps between rank values for tied rows.

SELECT student_id, first_name, last_name, DENSE_RANK() OVER (ORDER BY graduation_year) AS dense_rank
FROM Student;

--NTILE(n): Divides the result set into "n" roughly equal parts and assigns a bucket number to each row.
SELECT student_id, first_name, last_name, NTILE(4) OVER (ORDER BY graduation_year) AS quartile
FROM Student;


--LEAD() and LAG(): Access data from subsequent or preceding rows within the result set.
SELECT student_id, first_name, last_name, graduation_year,
    LAG(graduation_year) OVER (ORDER BY graduation_year) AS prev_year,
    LEAD(graduation_year) OVER (ORDER BY graduation_year) AS next_year
FROM Student;

SELECT student_id, first_name, last_name, graduation_year,
    LAG(graduation_year) OVER (ORDER BY graduation_year) AS prev_year
	FROM Student;

SELECT student_id, first_name, last_name, graduation_year,
    LEAD(graduation_year) OVER (ORDER BY graduation_year) AS next_year
FROM Student;




--Simple CASE Expression: Case Expression for Graduation Status:
SELECT
    student_id,
    first_name,
    last_name,
    graduation_year,
    CASE
        WHEN graduation_year > YEAR(GETDATE()) THEN 'Future Graduate'
        WHEN graduation_year = YEAR(GETDATE()) THEN 'Current Graduate'
        ELSE 'Previous Graduate'
    END AS graduation_status
FROM
    Student;


-- Case Expression for Credit Classification:
SELECT
    course_id,
    course_name,
    credits,
    CASE
        WHEN credits >= 4 THEN 'High Credit'
        WHEN credits = 3 THEN 'Medium Credit'
        ELSE 'Low Credit'
    END AS credit_classification
FROM
    Course;

-- Case Expression for Enrollment Dates:
SELECT
    enrollment_id,
    enrollment_date,
    CASE
        WHEN MONTH(enrollment_date) = 1 THEN 'January'
        WHEN MONTH(enrollment_date) = 2 THEN 'February'
        WHEN MONTH(enrollment_date) = 3 THEN 'March'
        -- Add more months as needed
        ELSE 'Other'
    END AS enrollment_month
FROM
    Enrollment;


--Case Expression for Email Domain:
SELECT
    student_id,
    first_name,
    last_name,
    email,
    CASE
        WHEN CHARINDEX('@', email) > 0 THEN RIGHT(email, LEN(email) - CHARINDEX('@', email))
        ELSE 'No Domain'
    END AS email_domain
FROM
    Student;


--Case Expression for Credit Weight:
SELECT
    course_id,
    course_name,
    credits,
    CASE
        WHEN credits = 4 THEN credits * 1.2
        WHEN credits = 3 THEN credits * 1.1
        ELSE credits
    END AS weighted_credits
FROM
    Course;








