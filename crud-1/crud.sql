-- comments start with -- in mysql

SHOW DATABASES; -- command to show all the databases

USE hero; -- command used to switch table or use that specific table

-- CREATING TABLE
CREATE TABLE students( -- creating a table
	id INT PRIMARY KEY AUTO_INCREMENT,
    name varchar(50) NOT NULL,
    psp INT
);

-- SELECT

SELECT * FROM students; -- * means everything (show all the columns in that table)

-- INSERT 

INSERT INTO students(name, psp) VALUES
('Goku', 90),
('Gohan', 92),
('Vegeta', 94);

SELECT * FROM students;

SELECT name from students;

SELECT name as 'Full Name' from students; -- example for alias prints Full Name as Column name - just for representative purpose

USE hero;

CREATE TABLE tennis_profile(
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(50)
);

INSERT INTO tennis_profile(name) VALUES
("Alcaraz"),
("Sinner"),
("Novak"),
("Roger"),
("Rafa");

SELECT * FROM tennis_profile;

CREATE TABLE tennis(
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    age INT,
    player_id INT,
    FOREIGN KEY(player_id) REFERENCES tennis_profile(id)
);

INSERT INTO tennis(name, age, player_id) VALUES
("Alcaraz", 24, 1),
("Sinner", 25, 1),
("Novak", 39, 2),
("Roger", 44, 2),
("Rafa", 40, 3);

SELECT * FROM tennis;




