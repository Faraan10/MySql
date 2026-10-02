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
