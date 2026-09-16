CREATE DATABASE scaler;

USE scaler;

CREATE TABLE batches(
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50)
);

INSERT INTO batches(name) VALUES
("LLD"),
("SQL"),
("HLD");

CREATE TABLE students(
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    psp INT DEFAULT 80,
    batch_id INT
);

INSERT INTO students(name, psp, batch_id) VALUES
("Goku", 87, 1),
("Gohan", 90, 1),
("Vegeta", 91, 2),
("Levi", 87, 1),
("Eren", 87, 3);


SELECT * FROM batches;
SELECT * FROM students;


-- **** Cross JOIN
-- This below is an example of Cross JOIN
-- But this below is wrong way of getting which student is in which batch as we will get cross product of 3*5=15 records we only want student whose batch_id
-- and id match with one another
-- Time Complexity for JOIN is 0(N*M) where N is no of rows in batches and M is no of rows in students

SELECT * FROM students
JOIN batches; -- we get output 15 rows 


-- **** Inner JOIN
-- An Inner Join returns only the rows where the join condition is met -- i.e., rows that have matching values in both tables.
-- Correct way of approaching this with condition ie: ON students.batch_id = batches.id;
-- By default, JOIN in MySQL is an Inner Join. You can optionally write INNER JOIN for clarity

SELECT * FROM students
JOIN batches
ON students.batch_id = batches.id;


-- ****

USE sakila;

-- Lets say for every film we want to print its name and the language

SELECT * FROM film;
SELECT * FROM language;

SELECT 
	film.title AS 'Name',
    language.name AS 'Language' 
FROM film
JOIN language
ON film.language_id = language.language_id;


-- ****
-- Outer JOIN
-- Outer Joins return all rows from one (or both) tables, even if there is no match in the other table. Unmatched columns are filled with NULL .

-- Left JOIN

USE scaler;

INSERT INTO students(name, psp, batch_id) VALUES
("Gogeta", 88, 8);

-- Give me names of all the students that are a part of batch or not

SELECT * FROM students
LEFT JOIN batches
ON students.batch_id = batches.id;


-- Right JOIN

INSERT INTO batches(name) VALUES
('DSA'),
('AI ML');

SELECT * FROM students
RIGHT JOIN batches
ON students.batch_id = batches.id;


-- Assignment: Gve me list of students who are not assigned to any batch
SELECT * FROM students
LEFT JOIN batches
ON students.batch_id = batches.id
WHERE batches.id IS NULL;

-- Similarly give students whose batches are assigned
SELECT * FROM students
LEFT JOIN batches
ON students.batch_id = batches.id
WHERE batches.id IS NOT NULL;


-- ****
-- SELF JOIN
-- A Self Join is when a table is joined with itself. This is useful when rows in a table have relationships with other rows in the same table.
-- NOTE: We cannot do SELF JOIN without as alias as we will be using the same table for both so the selection will be ambigious 
-- This is the error we will get: Error Code: 1066. Not unique table/alias: 'employees'


CREATE TABLE employees(
	id INT PRIMARY KEY AUTO_INCREMENT,
	name varchar(50),
    manager_id INT
);

INSERT INTO employees(name, manager_id) VALUES
("Tony", NULL),
("Steve", 1),
("Natasha", 1),
("Peter", 2),
("Thanos", 2);

SELECT * FROM employees;

-- Assignment: give the employee names along with their manager names
SELECT e1.name AS 'Employee Name', e2.name AS 'Manager Name' FROM employees e1
JOIN employees e2
ON e1.manager_id = e2.id;


-- Give names of the employees and their managers, Also list who dont have managers
SELECT e1.name as 'Employee', e2.name as 'Manager' FROM employees e1
LEFT JOIN employees e2
ON e1.manager_id = e2.id;