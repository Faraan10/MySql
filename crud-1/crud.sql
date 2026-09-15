-- comments start with -- in mysql

SHOW DATABASES; -- command to show all databases

USE HERO; -- comand to switch or use that specific database

USE sakila;

DROP DATABASE HERO; -- for dropping database

SHOW DATABASES;

CREATE DATABASE tennis; -- command to create the databse

USE tennis;

-- CREATING TABLE
CREATE TABLE atp_rankings( -- creating a table inside database
	id INT PRIMARY KEY AUTO_INCREMENT, -- using id as PRIMARY KEY as it is unique for each row
    name VARCHAR(50) NOT NULL,
    age INT
);

-- INSERT 
INSERT INTO atp_rankings(name, age) values -- insertig vales into the table
("Alcaraz", 24),
("Sinner", 25),
("Novak", 39),
("Roger", 44),
("Rafa", 40),
("Wawrinka", 42),
("Medvedev", 30);

-- SELECT
SELECT * FROM atp_rankings; -- * means everything (show all the columns in that table)

SELECT name from atp_rankings;

SELECT name as "Full Name" from atp_rankings; -- example for alias prints Full Name as Column name - just for representative purpose

CREATE TABLE tennis_profile(
	id INT PRIMARY KEY AUTO_INCREMENT, 
    player_alias VARCHAR(50),
    player_id INT,
    FOREIGN KEY(player_id) REFERENCES atp_rankings(id) -- creating foreign key relationship with parent table atp_rankings with player_id which references the id in atp_rankings table
);

-- NOTE: Now as we created a foreign key relationship with the parent table atp_rankings and child table is tennis_profile 
-- We cannot delte the Parent table ie: atp_rankings first as there is a Referential Integrity in between those 2 tables
-- First we have to delete the child table which is tennis_profile and then the parent table atp_rankings
-- While creating we create the parent table first and then the child table 
-- and while deleting the child table first and then the parent table

SELECT * FROM tennis_profile;

INSERT INTO tennis_profile(player_alias, player_id) VALUES
("Carlos", 1),
("Jannik", 2),
("Joker", 3),
("Maestro", 4),
("King Of Clay", 5);

SELECT * FROM tennis_profile;


-- ON UPDATE and ON DELETE
--  deleted above tennis_profile table and creating below again for showing ON UPDATE and ON DELETE 
CREATE TABLE tennis_profile(
	id INT PRIMARY KEY AUTO_INCREMENT, 
    player_alias VARCHAR(50),
    draw_id INT,
    FOREIGN KEY(draw_id) REFERENCES atp_rankings(id)
    ON UPDATE CASCADE
    ON DELETE SET NULL
);

INSERT INTO tennis_profile(player_alias, draw_id) VALUES
("Carlos", 1),
("Jannik", 3),
("Joker", 1),
("Maestro", 2),
("King Of Clay", 2),
("best one handed backhand", 3),
("Hard court specialist", 4);

SELECT * FROM atp_rankings;

SELECT * FROM tennis_profile;

-- showing all the distinct names in the table atp_rankings
SELECT DISTINCT name from atp_rankings; 


-- NOTE: -- **** represents new topic
-- **** crud 2 starts from below
-- using sakila database from below
USE sakila;

-- *****
-- gives distinct rental rates from rental_rate column in film table
SELECT DISTINCT rental_rate from film;

-- gives rental rates with distinct length from film table (using distinct to get unique comination of 2 columns applied to every row
SELECT DISTINCT rental_rate, length from film;

-- this is an error as DISTINCT can only be applied to the entire selected row/combination and not one particular column
-- The problem is simply that SQL syntax doesn't allow DISTINCT to be placed before an individual column like that.
-- DISTINCT comes immediately after SELECT: like shown in above example

SELECT rental_rate, DISTINCT length from film;


-- *****
-- ROUND
SELECT 1234; -- SELECT means give me the output 

-- gives output 1234.57
SELECT ROUND(1234.567, 2) as rounded_num;


-- *****
-- WHERE
-- WHERE clause works as filter and it works only for rows only bascally filtering rows as per requirement

-- printing all films whose rating="PG-13"
SELECT * FROM film WHERE rating = "PG-13";

-- printing all films whose rating="PG-13" or "g" NOTE: sal is case insensitive so even if we give "g" small g it will give "G" rating films as well
SELECT * FROM film WHERE rating = "PG-13" || rating = "g";

-- printing all films whose rating="PG-13" or "g" NOTE: If we specifically want only small g films then we have to use BINARY before the column then it will
-- become case sensitive and only give small g rating films output 
-- Note: BINARY only works for strings
SELECT * FROM FILM WHERE rating = "PG-13" || BINARY rating = "g";


-- Find all films with rating not euqal to PG-13
SELECT * FROM film WHERE rating != "PG-13"; -- we can also use <> instead of != so it will be WHERE rating <> "PG-13"


-- *****
-- Logical operator
-- NOTE: Always use parenthesis when multiple logical operators are being used as the higest takes precendence first

SELECT * FROM film
WHERE (rating = 'PG-13' OR rental_rate = 0.99) AND (release_year = 2006);


SELECT title, rental_duration from film
	WHERE
		rental_duration = 3
        OR rental_duration = 4
        OR rental_duration = 6;
        
/*
	IN --> Syntactical Sugar
    means rather than writing 
    rental_duration = 3
	OR rental_duration = 4
	OR rental_duration = 6;
    
    we can directly use IN (3,4,6) or if we dont want the films with rental_duration 3,4,6 then  NOT IN (3,4,6)
*/

SELECT * FROM film WHERE rental_duration IN (3,4,6);

SELECT * FROM film WHERE rental_duration NOT IN (3,4,6);


-- *****
-- ORDER BY
-- used for sorting the results
-- NOTE: Mysql always guarentees rows are always sorted on Primary Key in ascending order means they are always sorted 
-- by default we use ORDER BY it sortes in ascening order on whatever column we are applying on if we want in descending order we have to use DESC

SELECT * FROM film
ORDER BY title DESC; -- it gives output starting from the title which starts with Z

 -- first it sorts based on the rental_duration in ascending order then takes title with descending order and sorts both accordingly and returns output
 -- If both the rows have same sorting values suppose row 1 --> 2 B and row 2 also same --> 2 B then it takes id also as a part and sorts accordingly
 -- For the above example 2 is the rental_duration and B is the title
SELECT rental_duration, title FROM film
ORDER BY rental_duration, title DESC;

-- *****
-- Assignment: Films with a Rating of PG-13 Sorted by their titles
-- when doing operations like this it is best to filter first and then sort as sort takes O(N log N) time complexity if we filter first it will be reducing 
-- the overall time complexity as we will sorting on millions and billions of records so,
-- Filter --> Sort  (Filter first and then Sort)
SELECT title, rating FROM film
WHERE rating='PG-13'
ORDER BY title;

-- *****
-- ORDER BY with DISTINCT
-- NOTE: when we are using DISTINCT with ORDER BY  we have to keep in mind that the columns we are applying DISTINCT on should also be included in ORDER BY
-- 	as if they are not mentioned at both of those there will be a vaugeness in between them and it cannot sort properly 
SELECT distinct rental_rate FROM film
ORDER BY title DESC;
-- we get this error below 
-- Error Code: 3065. Expression #1 of ORDER BY clause is not in SELECT list, references column 'sakila.film.title' which is not in SELECT list; this is incompatible with DISTINCT

-- so we can use it like this 
SELECT distinct title FROM film
ORDER BY title DESC;
-- OR 
SELECT distinct title, rental_rate FROM film
ORDER BY title DESC;


-- ****
-- NULL (this is not same as programming languages) it represents emptiness so when comparing anything with NULL it returns NULL

SELECT 3 = 3; -- returns 1 as output
SELECT 3 = 2; -- returns 0 as output
SELECT 3 = NULL; -- retuns NULL as output
SELECT NULL = true; -- retuns NULL as output

-- question
SELECT * FROM film
WHERE title != NULL; -- here this will return output as null for the entire table for every column as we will only get correct output when 
-- the title is not null will be true but when we compare title to emptiness there is  nothing to compare with so it returns null 
-- So when we want to use NUll we have to use it like below

SELECT * FROM film
WHERE title is NOT NULL; -- this gives correct output, we have to use IS NULL or IS NOT NULL

-- If a column is NULLABLE always check before comparison
-- for example below PSP is NULLABLE column as it can be NULL if there are new students as they will not have psp (problem solving percentage)
SELECT * FROM students
WHERE psp >= 80 OR psp IS NULL;


-- ****
-- LIKE

-- Theory of Computation
-- Pattern Matching

-- It will return all the films whose title starts with letter D
-- Note: mysql is case insensitive so it returns all small and capital D if present in rows
SELECT * FROM film WHERE title LIKE 'D%';

-- Assignment: Find all the films with 'Love' in the title
SELECT * FROM film WHERE title LIKE '%Love%';

-- Assignment: Find all the Students whose Name ends with 'e'
-- for example using students there is no table with students 
SELECT * FROM students WHERE title LIKE '%e';

-- Assignment: Find all the Students whose Name ends with 'e' and is 4 characters long
SELECT * FROM students WHERE title LIKE '___e';


-- ****
-- LIMIT and OFFSET

-- Pagination

-- LIMIT --> Restricts the number of rows being returned
SELECT * FROM film LIMIT 10;

SELECT * FROM film
ORDER BY title DESC
LIMIT 10;

-- OFFSET --> Skip N rows before returning

-- Skip the first 10 rows, then return 10

SELECT * FROM film
LIMIT 10
OFFSET 10;

-- NOTE: We can use LIMIT without OFFFSET but
-- NOTE: We cannot use OFFSET without LIMIT as Production DB consists of millions and billions of data and if we did not use LIMIT when returning the from
-- OFFSET point onwards it would return the entire data which will crash the DB


-- Assignment: Get 2nd Highest PSP using LIMIT and OFFSET

SELECT * FROM students
ORDER BY psp DESC
LIMIT 1
OFFSET 1;


-- UPDATE

UPDATE film SET title = 'Ford vs Ferrari'
WHERE film_id = 1;

SELECT * FROM film;

UPDATE film SET title = 'Ford vs Ferrari'; -- this will not allow the command to execute as it will update title for entire columns as 
-- by default we are in safe mode if you want to change it and update all records then use this below
SET @@SQL_SAFE_UPDATES = 0; -- Set this to like this and then run command it will update all titles
-- Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.  To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.





