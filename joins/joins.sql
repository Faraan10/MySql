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

