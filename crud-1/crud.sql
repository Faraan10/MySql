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

-- NOTE: Now as we created a foreign key relarionship with the parent table atp_rankings and child table is tennis_profile 
-- We cannot delte the Parent table ie: atp_rankings first as there is a referential Integrity in between those 2 tables
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



