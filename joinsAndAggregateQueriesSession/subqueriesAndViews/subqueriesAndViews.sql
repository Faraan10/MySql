USE scaler;

SHOW tables;

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
)


