USE scaler;

SHOW tables;


-- *****************

-- Subqueries (Scalar, in WHERE, in FROM)

SELECT * FROM students;

-- Get all the students having PSP > PSP of student with s_id 2

-- Step 1: Find PSP of the Student with s_id = 2

SELECT psp FROM students WHERE id=2; -- call this X

-- Step 2: Find the students with psp  X

SELECT * FROM students WHERE psp > (SELECT psp FROM students WHERE id = 2);


-- Assignment: Find the data of all the students having
-- PSP > min(PSP) of b_id = 3

SELECT * FROM students WHERE psp > (SELECT MIN(psp) FROM students WHERE batch_id = 3);


-- Assignment: Find all the years where AVG(rental_rate) >= Global AVG(rental_rate) --> film table

USE sakila;

SELECT * FROM film;

-- step 1: Calculate global avg rental_rate

SELECT AVG(rental_rate) FROM film;

-- step 2: 

SELECT 
	release_year,
    AVG(rental_rate) AS 'year_avg_rental_rate'
FROM
	film
GROUP BY 
	release_year
HAVING
	AVG(rental_rate) >= (SELECT AVG(rental_rate) FROM film);

-- *****************
    
-- Subqueries with the IN Clause
-- Assignment: Find all the students where PSP > MIN(AVG(PSP) of every batch)

USE scaler;

SELECT * FROM students;

SELECT
	AVG(psp) AS psp
FROM 
	students
GROUP BY
	batch_id; -- X
   
   
-- Now find the min of all these

SELECT MIN(psp) FROM (
	SELECT
		AVG(psp) AS psp
	FROM 
		students
	GROUP BY
		batch_id) AS T1;
        

SELECT * FROM students
WHERE psp > (
	SELECT MIN(psp) FROM (
	SELECT
		AVG(psp) AS psp
	FROM 
		students
	GROUP BY
		batch_id) AS T1
);


-- this below query will not work as MySql does not allow stacked aggregated functions ex: MIN(AVG(psp))
SELECT MIN(AVG(psp)) FROM students GROUP BY batch_id;
--


-- *****************

-- ALL & ANY

-- ALL is used when you want to do Logical AND between all the values

-- ANY is used when you want to do Logical OR between all the values

-- Note:
-- IN only works with Equality comparisions
-- For Inequality comparisons we use ANY


-- Assignment: Find the data of the learners where PSP >= MIN(psp) of every batch

-- step 1: Get the Min (PSP) on a batch level (X)
SELECT 
	MIN(psp)
FROM students
GROUP BY batch_id;

-- step 2: 

SELECT * FROM students
WHERE psp >= ALL (
	SELECT 
	MIN(psp)
	FROM students
	GROUP BY batch_id
);



-- Assignment: Find the data of the learners where PSP >= MIN(psp) of any batch

SELECT 
	MIN(psp)
FROM students
GROUP BY
	batch_id;
    

SELECT
	*
FROM students 
WHERE 
	psp >= ANY (
	SELECT 
		MIN(psp)
	FROM 
		students
	GROUP BY
		batch_id
);


-- *****************

-- Correlated Subqueries
-- Correlated Subqueries are subqueries where the subquery uses a variable from the parent query.


-- Assignment: Find all the students where PSP > AVG(PSP) of their OWN batch


-- this below is X
SELECT 
	psp
FROM students
WHERE
	batch_id = 1;
    
    
SELECT
	*
FROM students
WHERE
	psp > (
		SELECT 
			AVG(psp)
		FROM students
		WHERE
			batch_id = 1
    );



-- but we want psp > AVG(psp) from their own batch so the psp of students which belongs to batch 2 should be greater than avg psp of batch 2
--  psp of students which belongs to batch 3 should be greater than avg psp of batch 3 and so on


SELECT
	*
FROM students s1
WHERE s1.psp > (
		SELECT 
			AVG(s2.psp)
		FROM students s2
		WHERE
			s1.batch_id = s2.batch_id -- s1.batch_id = reference to outer query
    );


-- So the time complexity for these subquery operations is O(N^2) 
-- As for every s1.psp is outer row and inner row s2.psp, similar to outer loop and inner loop



-- *****************

-- EXISTS

-- Assignment: Find all the actors who have acted in atleast 1 movie

USE sakila;

SELECT * FROM actor;

SELECT film_id FROM film_actor WHERE actor_id = 1;

-- where exists means even if actor acted in 1 movie it will show in output
SELECT * FROM actor a1
WHERE EXISTS (
	SELECT film_id  FROM film_actor f1 WHERE a1.actor_id = f1.actor_id
);


-- *****************

-- NOT EXISTS 
-- means actor did not even act in any movie
SELECT * FROM actor a1
WHERE NOT EXISTS (
	SELECT film_id  FROM film_actor f1 WHERE a1.actor_id = f1.actor_id
);



-- *****************

-- VIEWS

-- Complex production queries may have logic and joins that are hard to reason about. 
-- This makes mistakes easier to commit/happen.


-- Key Properties
-- Data is always fetched live from the underlying tables (not stored separately).
-- Simplifies complexity  (hides complex joins behind a simple name.)
-- Provides security  (exposes only certain columns/rows to users.)
-- Easy to manage  (can be dropped and recreated without affecting actual data.)
-- Also called virtual tables.


-- Solution: Write the Query and Save -> VIEW
-- VIEW is a saved Query


USE sakila;

SELECT
	CONCAT(a1.first_name, ' ', a1.last_name) AS 'Actor Name',
    f1.title AS 'film_name'
FROM actor a1
INNER JOIN film_actor fa1 ON a1.actor_id = fa1.actor_id
INNER JOIN film f1 ON fa1.film_id = f1.film_id
ORDER BY a1.first_name;
    

-- Creating a view for this above virtual table as the above table is not a actual table and is only derived using joins and relationships
CREATE OR REPLACE VIEW actor_film_info AS
SELECT
	CONCAT(a1.first_name, ' ', a1.last_name) AS 'Actor Name',
    f1.title AS 'film_name'
FROM actor a1
INNER JOIN film_actor fa1 ON a1.actor_id = fa1.actor_id
INNER JOIN film f1 ON fa1.film_id = f1.film_id
ORDER BY a1.first_name;



-- And you can call that derived table just by using its VIEW name 
SELECT * FROM actor_film_info; -- this is also called Virtual Tables


-- we can do other operarions as well example below
SELECT * FROM actor_film_info WHERE film_name LIKE '%DINOSAUR%';


-- NOTE: We can also perform crud operations on this virtual tables if it is only single table example below

USE scaler;

CREATE OR REPLACE VIEW active_students AS
SELECT id, name, psp FROM students WHERE psp > 80;

SELECT * FROM active_students; -- shows all the data for students where psp > 80

-- Now next step is modifying data

INSERT INTO active_students (name, psp) VALUES
('New Student', 85);


-- example 2

UPDATE active_students SET name = 'Luffy' WHERE id = 11;


-- example 3

UPDATE active_students SET psp = 95 WHERE id = 11;





