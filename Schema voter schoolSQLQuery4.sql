

Create database elections;

Use elections;

-- Create a schema named "election"
CREATE SCHEMA election;

-- Create the Citizen table in the "election" schema
CREATE TABLE election.citizen (
    citizen_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    adhar_card_number VARCHAR(12) NOT NULL UNIQUE,
    mobile_number VARCHAR(10) NOT NULL
);

-- Create the Voters table in the "election" schema with foreign key constraint and unique constraint
CREATE TABLE election.voters (
    voter_id INT IDENTITY(1,1) PRIMARY KEY,
    citizen_id INT NOT NULL,
    voter_id_card VARCHAR(10) UNIQUE,
    FOREIGN KEY (citizen_id) REFERENCES election.citizen(citizen_id)
);

-- Insert data into the Citizen table
INSERT INTO election.citizen (first_name, last_name, date_of_birth, adhar_card_number, mobile_number)
VALUES
    ('John', 'Doe', '1985-05-15', '123456789012', '9876543210'),
    ('Jane', 'Smith', '1990-12-10', '987654321012', '8765432109'),
    ('Michael', 'Johnson', '1978-08-25', '789012345678', '7654321098'),
    ('Sarah', 'Williams', '2002-03-28', '456789012345', '6543210987');

-- Insert data into the Voters table
INSERT INTO election.voters (citizen_id, voter_id_card)
VALUES
    (1, 'V123'),
    (2, 'V456'),
    (3, 'V789'),
	(4, 'V589');


SELECT * FROM election.citizen;
SELECT * FROM election.voters;
SELECT TOP(2)* FROM election.voters;
-- UNQUIE VALUE FORM COLOUMN
SELECT DISTINCT first_name FROM election.citizen

ALTER TABLE election.citizen ADD age decimal(2,2)
ALTER TABLE election.citizen DROP COLUMN age;



SELECT c.first_name, c.last_name, v.voter_id_card
FROM election.citizen AS c
INNER JOIN election.voters AS v ON c.citizen_id = v.citizen_id;


SELECT c.first_name, c.last_name, v.voter_id_card
FROM election.citizen AS c
LEFT JOIN election.voters AS v ON c.citizen_id = v.citizen_id;

SELECT c.first_name, c.last_name, v.voter_id_card
FROM election.citizen AS c
RIGHT JOIN election.voters AS v ON c.citizen_id = v.citizen_id;

SELECT c.first_name, c.last_name, v.voter_id_card
FROM election.citizen AS c
FULL OUTER JOIN election.voters AS v ON c.citizen_id = v.citizen_id;

INSERT INTO election.citizen (first_name, last_name, date_of_birth, adhar_card_number, mobile_number)
VALUES ('Alex', 'Brown', '1999-07-12', '987654321023', '5432109876');

SELECT * FROM election.citizen;
SELECT * FROM election.voters;

UPDATE election.citizen
SET last_name = 'Smith'
WHERE first_name = 'John';

DELETE FROM election.voters
WHERE voter_id_card = 'V456';





-- Create a schema named "school"
CREATE SCHEMA school;


-- Create the Students table in the "school" schema
CREATE TABLE school.students (
    student_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);

-- Create the Marks table in the "school" schema with foreign key constraint
CREATE TABLE school.marks (
    marks_id INT IDENTITY(1,1) PRIMARY KEY,
    student_id INT NOT NULL,
    subject VARCHAR(50) NOT NULL,
    marks_obtained INT NOT NULL,
    FOREIGN KEY (student_id) REFERENCES school.students(student_id)
);


-- Insert data into the Students table
INSERT INTO school.students (first_name, last_name, date_of_birth, email)
VALUES
    ('John', 'Doe', '2002-05-15', 'john.doe@example.com'),
    ('Jane', 'Smith', '2003-12-10', 'jane.smith@example.com'),
    ('Michael', 'Johnson', '2001-08-25', 'michael.johnson@example.com'),
    ('Sarah', 'Williams', '2004-03-28', 'sarah.williams@example.com');

-- Insert data into the Marks table
INSERT INTO school.marks (student_id, subject, marks_obtained)
VALUES
    (1, 'Math', 90),
    (2, 'Math', 85),
    (3, 'Math', 78);

SELECT s.first_name, s.last_name, m.subject, m.marks_obtained
FROM school.students AS s
INNER JOIN school.marks AS m ON s.student_id = m.student_id;

SELECT s.first_name, s.last_name, m.subject, m.marks_obtained
FROM school.students AS s
LEFT JOIN school.marks AS m ON s.student_id = m.student_id;


SELECT s.first_name, s.last_name, m.subject, m.marks_obtained
FROM school.students AS s
RIGHT JOIN school.marks AS m ON s.student_id = m.student_id;


SELECT s.first_name, s.last_name, m.subject, m.marks_obtained
FROM school.students AS s
FULL OUTER JOIN school.marks AS m ON s.student_id = m.student_id;


INSERT INTO school.students (first_name, last_name, date_of_birth, email)
VALUES ('Alex', 'Brown', '2003-07-12', 'alex.brown@example.com');

SELECT * FROM school.students;
SELECT * FROM school.marks;



UPDATE school.students
SET last_name = 'Smith'
WHERE first_name = 'John';

DELETE FROM school.marks
WHERE subject = 'Math';


ALTER TABLE table_name ADD column_name datatype;

ALTER TABLE table_name ALTER COLUMN column_name TYPE new_datatype;


ALTER TABLE table_name RENAME COLUMN old_column_name TO new_column_name;


ALTER TABLE table_name DROP COLUMN column_name;


ALTER TABLE table_name ADD PRIMARY KEY (column_name);

ALTER TABLE table_name DROP CONSTRAINT constraint_name;


ALTER TABLE table_name ADD CONSTRAINT fk_name FOREIGN KEY (column_name) REFERENCES ref_table(ref_column);


ALTER TABLE table_name DROP CONSTRAINT fk_name;


ALTER TABLE table_name ADD INDEX index_name (column_name);

ALTER TABLE table_name DROP INDEX index_name;

ALTER TABLE table_name DROP INDEX index_name;

ALTER TABLE table_name ALTER COLUMN column_name DROP NOT NULL;

ALTER TABLE old_table_name RENAME TO new_table_name;

ALTER TABLE table_name ALTER COLUMN column_name SET DEFAULT default_value;

ALTER TABLE table_name ALTER COLUMN column_name DROP DEFAULT;

ALTER TABLE table_name ALTER COLUMN column_name SET POSITION new_position;

select * from table_name where column_name in ("", "")