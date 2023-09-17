CREATE DATABASE student_db;
-- Create database if not exists 
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'student_db')
    CREATE DATABASE student_db;

USE master; -- Switch to the master database context
GO

DROP DATABASE student_db;

USE student_db;

CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    email VARCHAR(100),
    major VARCHAR(50),
    graduation_year INT
);

CREATE TABLE Course (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    instructor VARCHAR(100),
    credits INT
);

CREATE TABLE Enrollment (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (course_id) REFERENCES Course(course_id)
);

-- Delete a database named "student_db"
DROP DATABASE student_db; 

-- Delete a database if it exists
DROP DATABASE IF EXISTS student_db;

USE student_db;

-- Create Student table
IF OBJECT_ID('Student', 'U') IS NULL
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
IF OBJECT_ID('Course', 'U') IS NULL
BEGIN
    CREATE TABLE Course (
        course_id INT PRIMARY KEY,
        course_name VARCHAR(100),
        instructor VARCHAR(100),
        credits INT
    );
END;

SELECT * FROM Course;

-- Create Enrollment table
IF OBJECT_ID('Enrollment', 'U') IS NULL
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

SELECT * FROM Enrollment;

SELECT * FROM student;

-- Insert students
INSERT INTO Student (student_id, first_name, last_name, date_of_birth, email, major, graduation_year)
VALUES
    (1, 'John', 'Doe', '1998-05-15', 'john.doe@example.com', 'Computer Science', 2023),
    (2, 'Jane', 'Smith', '1999-02-20', 'jane.smith@example.com', 'Engineering', 2024),
    (3, 'Alice', 'Johnson', '2000-09-10', 'alice.johnson@example.com', 'Biology', 2023),
	(4, 'Michael', 'Williams', '2001-07-03', 'michael.williams@example.com', 'Psychology', 2022),
    (5, 'Emily', 'Brown', '2000-11-25', 'emily.brown@example.com', 'Art History', 2024),
    (6, 'Daniel', 'Johnson', '2000-09-18', 'daniel.johnson@example.com', 'Physics', 2022),
    (7, 'Olivia', 'Miller', '2001-03-09', 'olivia.miller@example.com', 'Mathematics', 2023);

SELECT * FROM enrollment;

-- Enroll students in enrollment
INSERT INTO Enrollment (enrollment_id, student_id, course_id, enrollment_date)
VALUES
    (1, 1, 101, '2023-01-15'),
    (2, 1, 102, '2023-02-10'),
    (3, 2, 101, '2023-01-15'),
    (4, 3, 103, '2023-03-05'),
	(5, 3, 105, '2023-04-20'),
    (6, 4, 106, '2023-02-28'),
    (7, 5, 104, '2023-03-15'),
    (8, 1, 105, '2023-05-10'),
    (9, 2, 104, '2023-06-12'),
    (10, 3, 106, '2023-05-01'),
    (11, 2, 101, '2023-01-20'),
    (12, 3, 102, '2023-03-05'),
    (13, 4, 103, '2023-02-15'),
    (14, 5, 101, '2023-01-25'),
    (15, 2, 103, '2023-02-28'),
    (16, 1, 103, '2023-03-10'),
    (17, 4, 101, '2023-03-20'),
    (18, 3, 105, '2023-04-02'),
    (19, 5, 102, '2023-03-15'),
    (20, 6, 104, '2023-04-05');

SELECT * FROM course;

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


-- Retrieve students and their enrolled courses using LEFT JOIN
SELECT
    s.first_name,
    s.last_name,
    c.course_name
FROM
    Student s
LEFT JOIN
    Enrollment e ON s.student_id = e.student_id
LEFT JOIN
    Course c ON e.course_id = c.course_id;

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

-- Count the number of students in each major
SELECT major, COUNT(*) AS num_students FROM Student GROUP BY major;


SELECT
    s.first_name,
    s.last_name,
    c.course_name
FROM
    Student s
LEFT JOIN
    Enrollment e ON s.student_id = e.student_id
LEFT JOIN
    Course c ON e.course_id = c.course_id;
    
    
-- left join Find Students Not Enrolled in Any Courses using RIGHT JOIN:
SELECT
    s.first_name,
    s.last_name
FROM
    Student s
LEFT JOIN
    Enrollment e ON s.student_id = e.student_id
WHERE
    e.student_id IS NULL;

-- Get Courses with No Enrollments:
SELECT
    c.course_name
FROM
    Course c
LEFT JOIN
    Enrollment e ON c.course_id = e.course_id
WHERE
    e.course_id IS NULL;



-- List Students Enrolled in Multiple Courses using GROUP BY and HAVING:
SELECT
    s.first_name,
    s.last_name,
    COUNT(e.course_id) AS num_courses_enrolled
FROM
    Student s
JOIN
    Enrollment e ON s.student_id = e.student_id
GROUP BY
    s.student_id
HAVING
    COUNT(e.course_id) > 1;


-- Retrieve Students Enrolled in the Same Course:
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

-- Retrieve courses with more than two students enrolled
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
    c.course_id
HAVING
    COUNT(s.student_id) > 2;


-- Retrieve students and their enrolled courses using LEFT JOIN
SELECT
    s.first_name,
    s.last_name,
    c.course_name
FROM
    Student s
LEFT JOIN
    Enrollment e ON s.student_id = e.student_id
LEFT JOIN
    Course c ON e.course_id = c.course_id;

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

-- Arithmetic Operators:
-- You can use arithmetic operators to perform calculations in SQL queries.
-- Calculate the total credits of enrolled courses for each student

SELECT
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
    s.student_id;
    
-- Comparison Operators:
-- Comparison operators are used to compare values in SQL.
-- Find courses with more than 3 credits

SELECT course_name, credits
FROM Course
WHERE credits > 3;

 
-- Logical Operators:
-- Logical operators are used to combine multiple conditions in SQL queries.
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

-- Aggregate Functions:
-- Aggregate functions perform calculations on a set of values and return a single value.
-- Calculate the average graduation year of students
SELECT AVG(graduation_year) AS avg_graduation_year
FROM Student;

-- String Functions:
-- String functions manipulate and analyze strings.

-- Concatenate first and last names of students
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM Student;

-- Date Functions:
-- Date functions manipulate and analyze date values.

-- Calculate the age of students

SELECT
    first_name,
    last_name,
    DATEDIFF(YEAR, date_of_birth, GETDATE()) AS age
FROM Student;



-- The CASE statement allows you to perform conditional logic in your queries.
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
