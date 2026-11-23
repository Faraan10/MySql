-- Left transaction connection

USE scaler;

-- this below will show autocomit ON which will be of default
SHOW VARIABLES LIKE 'autocommit';


-- below I am starting a transaaction now what happens is below from this line any change that we make or update in a table will only be changed in
-- this table and not in the other connection
-- such as this is Left Transaction, Now I made a achange by updating the psp of a student where id = 4 earlier it was 87 and now Imade it to 91 
-- it will show me 91 after updation, but when i run SELECT * FROM students; In the Right Transaction connection the value will not be updated 
-- and it will show 87 only as once we start a transaction then we have to COMMIT manually so that the changes be visible in the Right Connection

START TRANSACTION;

SELECT * FROM students;

UPDATE students
set psp=91 
WHERE id = 4;

COMMIT;

-- Now below I am showing example of ROLLBACK
SELECT * FROM students; -- psp of student of id 4 is 91

UPDATE students
set psp=70 -- updating it to 70 here now and checking again
WHERE id = 4;

SELECT * FROM students; -- so now here it shows 70

ROLLBACK; -- Now i rolled back suppose there was an issue in the process and I rolled back it will not show 70 now and will show 91 
-- which was the previous value


SELECT * FROM students; -- now it shows 91 as we rolled back


-- this shows the isolation level of MySQL database
-- MySql uses repeatable Read isolation level
-- where as MSSQL, Postgres and Oracle DB use Read Commited Isolation level
SHOW VARIABLES LIKE 'transaction_isolation';





-- Right transaction connection

USE scaler;

SELECT * FROM students;