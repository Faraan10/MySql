-- Aggregate Queries
-- SUM, COUNT, MAX, MIN, AVG

USE scaler;

SELECT * FROM students;

-- Getting sum of PSP

SELECT SUM(psp) FROM students;

-- Fint the number of students in table

SELECT COUNT(*) FROM students;

SELECT MAX(psp) FROM students;

SELECT MIN(psp) FROM students;

SELECT AVG(psp) FROM students;

-- What would be the output for this

SELECT COUNT(name) FROM students; -- but suppose in one column the name is null then the aggregate function will discard that column and give output 1 less
-- so if there are 10 records and 1 column does not have name then COUNT(name) will return 9

SELECT COUNT('MANGO') FROM students; -- returns number of rows count as anything after SELECT is printing output so prints no of rows count

SELECT 10 FROM students; -- prints 10 6 times as there are 6 rows in total students table

SELECT name, SUM(psp) FROM students; -- this will give an error as we will have row mismatch as all names we are asking and SUM(psp) will only 
-- give 1 single output so there will be no relation here 6 names against 1 row of sum

SELECT AVG(id), SUM(psp) FROM students;


-- ** Find the count of DISTINCT batches that are running
SELECT * FROM batches;

SELECT COUNT(DISTINCT id) FROM batches;


/*
GROUP BY
*/

SELECT COUNT(*), batch_id FROM students
GROUP BY(batch_id); 
-- this returns total count of students in that particular batch_id 
-- so with batch_id 1 there are 3 students
-- with batch_id 2 there is 1 student etc

-- MAX psp per batch
SELECT MAX(psp), batch_id FROM students
GROUP BY(batch_id);


-- what is the output

SELECT name, batch_id FROM students
GROUP BY(batch_id); 
-- for this we will get an error as rows length mismatch, as there can be muliple names or no names in the column as it is not agregated
-- so for this above to work we also have to include name in the group by default if we want that also as output
SELECT name, batch_id FROM students
GROUP BY batch_id, name;  -- when having muliple we should not use ()


-- Find the AVG batch wise psp

SELECT AVG(psp), batch_id FROM students
GROUP BY(batch_id);


-- ** Find the number of movies released every year

USE sakila;

SELECT * FROM film;

SELECT COUNT(*), release_year FROM film
GROUP BY(release_year);

SELECT @@sql_safe_updates;


-- ** HAVING

-- SQL devs created HAVING to do filtering on Groups rather than Rows
-- As WHERE filters Rows and not on Groups

-- Assignment: FInd all the batches that have more than 2 students

SELECT batch_id, COUNT(*)
FROM students
GROUP BY(batch_id);
-- WHERE COUNT(*) > 2;  This line will raise an error as this is not the correct place for using the WHERE Clause as WHERE should be used before GROUP BY
-- So when filtering on groups we have to use HAVING

USE scaler;

SELECT * FROM students;
SELECT * FROM batches;


SELECT batch_id, COUNT(*)
FROM students
GROUP BY(batch_id)
HAVING COUNT(*) > 2;


-- Assignment: now only inlcude the people whose name starts with s 

INSERT INTO students(name, psp, batch_id) VALUES
('Saturo', 93, 2),
('Sasuke', 91, 2),
('Sukuna', 94, 3),
('Zoro', 87, 3);


SELECT batch_id, COUNT(*)
FROM students
WHERE students.name LIKE 'S%'
GROUP BY(batch_id)
HAVING COUNT(*) > 2;


SELECT batches.id, batches.name, AVG(students.psp) FROM students
INNER JOIN batches ON students.batch_id = batches.id
GROUP BY batches.id, batches.name

-- Give in the decreasing order of PSP
-- just add this line below the above query
ORDER BY AVG(students.psp) DESC;


-- Assignment: Find rental duration which  more than the
-- Rental duration of more than 200 movies
USE sakila;

SELECT * FROM film;

SELECT rental_duration, COUNT(*) FROM film
GROUP BY rental_duration
HAVING COUNT(*) > 200;


-- Assignment: List the customers who have made atleast 30 rentals
-- And for each of those customers, display their customer ID
-- And the count of rentals that they have made

SELECT * FROM rental;
SELECT * FROM customer;
-- SELECT * FROM staff;

SELECT 
	c1.customer_id, 
    c1.first_name,
    COUNT(*)
FROM customer c1
INNER JOIN 
	rental r1 
    ON c1.customer_id = r1.customer_id
GROUP BY(c1.customer_id)
HAVING COUNT(*) > 30;


-- IMPLICIT JOINS

-- syntactical sugar
SELECT * FROM students
JOIN batches;

-- can be written as
SELECT * FROM students s, batches b; -- so this is INNER JOIN syntactical sugar can also be written like this simply
-- NOTE: we have to alias the implicit joins it will give same output as above query


-- JOIN with WHERE vs ON 
-- Using ON (Standard)

SELECT * FROM students
JOIN batches
ON batches.id = students.batch_id;

-- The ON clause defines the join condition -- how the two tables relate.
-- Using WHERE (Older Style)

SELECT * FROM students
JOIN batches
WHERE batches.id = students.batch_id;


-- For INNER JOIN, these produce the same result.

-- Key Difference (Outer Joins)

-- For Outer Joins, ON and WHERE behave differently (covered in SQL 4):

-- ON clause: 
-- Determines whether rows MATCH during the join.
-- Unmatched outer-table rows still appear (with NULLs).

--  WHERE clause: 
-- Filters AFTER the join.
--  Removes rows entirely (can undo the outer join effect).


