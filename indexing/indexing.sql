--  Topics to be covered
-- 1. Introduction to Indexing (Book Index analogy)
-- 2. How Indexes Work
-- 3. Data Structures Used for Indexing (HashMap -> BST -> B-Tree -> B+ Tree)
-- 4. Types of Indexes (Clustered vs Non-Clustered)
-- 5. Indexes on Multiple Columns (Composite Indexes)
-- 6. Prefix R
-- 7. ule
-- 8. Cons of Indexing
-- 9. Indexing on Strings (Prefix Indexes)
-- 10. Self-Study: Full-Text Indexes


-- Dense vs Sparse Index Problem

-- Dense Index (line-by-line): Every single line is listed in the 
-- index. The index itself becomes as big as the book 
-- defeats the purpose.

-- Sparse Index (multi-chapter): Very few entries. You still 
-- have to scan large sections of the book


USE sakila;

SELECT * FROM actor;

-- EXPLAIN ANALYZE ( using this we can know how long does it take for the query to fetch and give us the result )
EXPLAIN ANALYZE
SELECT * FROM actor WHERE last_name = 'MCQUEEN';

/* 
on first run this below output
'-> Index lookup on actor using idx_actor_last_name (last_name=\'MCQUEEN\')  
(cost=0.7 rows=2) (actual time=0.0454..0.0515 rows=2 loops=1)\n' 


on second run this below output
'-> Index lookup on actor using idx_actor_last_name (last_name=\'MCQUEEN\')  
(cost=0.7 rows=2) (actual time=0.0466..0.0503 rows=2 loops=1)\n'


you can see that the for 2 runs the cost is same but the time is different
so execution time differs 

and now about cost 

you can see that the cost is low because the last_name column is indexed in the actor table
you can check by opening actor tablet and going to indexes and you can see idx_actor_last_name, so the last_name 
is being indexed thats why the cost is low

*/

EXPLAIN ANALYZE
SELECT * FROM actor WHERE first_name = 'Faraan';

/*
'-> Filter: (actor.first_name = \'Faraan\')  (cost=20.4 rows=20.1) 
(actual time=0.237..0.239 rows=1 loops=1)\n    -> Table scan on actor  (cost=20.4 rows=201) (actual time=0.0553..0.202 rows=201 loops=1)\n'

now in this above example I used first_name as example you can see the cost is to high which is 20


'-> Filter: (actor.first_name = \'Faraan\')  (cost=20.4 rows=20.1) 
(actual time=0.235..0.237 rows=1 loops=1)\n    -> Table scan on actor  (cost=20.4 rows=201) (actual time=0.0545..0.201 rows=201 loops=1)\n'

Same you can see the time is different but the cost remains constant 

so to reduce the cost I can Index this first_name column so that it will imrove the look up time 
*/


-- Indexing the first_name in the actors table
CREATE INDEX idx_actor_first_name ON actor(first_name);


-- and now will do the look up again

EXPLAIN ANALYZE
SELECT * FROM actor WHERE first_name = 'Faraan';

/*
'-> Index lookup on actor using idx_actor_first_name (first_name=\'Faraan\')  
(cost=0.35 rows=1) (actual time=0.0458..0.0476 rows=1 loops=1)\n'

now you can see the cost has dropped from 20.4 to 0.35

we just optimized our query by creating an index
*/
