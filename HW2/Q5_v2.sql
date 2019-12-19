-- Remote server-based DB: http://sqlfiddle.com
-- Database: PostgreSQL 9.6

-- Build Schema

DROP TABLE IF EXISTS desserts;

CREATE TABLE desserts
(Chef CHAR(1) NOT NULL,
Dish CHAR(30) NOT NULL,
PRIMARY KEY (Chef, Dish)
);

-- Run SQL

INSERT INTO desserts(Chef, Dish)
VALUES 
('A', 'Apple pie'),
('A', 'Beignet'),
('A', 'Andes Chocolate Cake'),
('B', 'Tiramisu'),
('B', 'Creme brulee'),
('B', 'Beignet'),
('C', 'Tiramisu'),
('C', 'Creme brulee'),
('D', 'Apple pie'),
('D', 'Tiramisu'),
('D', 'Creme brulee'),
('E', 'Apple pie'),
('E', 'Bananas Foster'),
('E', 'Creme brulee'),
('E', 'Tiramisu'); 

-- In this version, I do inner joins consecutively.  Inner join will join two tables in such a way that it will display only common elements.\
-- I take the whole desserts table and join it table having only 'Creme brulee' Dish column entries.  Now, I take the resultant table and join it with\
-- table having only 'Apple Pie' Dish column entries.  Finally, I take this resulting table and join it with table with 'Tiramisu' Dish column elements.\
-- All these inner join operations are performed on Chef column, thus finally, we get DISTINCT Chefs from all these inner joins.
-- Assumption: Dish values are hard-coded as per HW guidelines.


SELECT DISTINCT desserts.Chef
FROM ((desserts 
INNER JOIN  (SELECT Chef
               FROM desserts
               WHERE Dish = 'Creme brulee') AS Creme 
             ON desserts.Chef = Creme.Chef)
             
INNER JOIN  (SELECT Chef
               FROM desserts
               WHERE Dish = 'Apple pie') AS Apple 
            ON desserts.Chef = Apple.Chef)
            
INNER JOIN  (SELECT Chef
               FROM desserts
               WHERE Dish = 'Tiramisu') AS Tiramisu 
            ON desserts.Chef = Tiramisu.Chef;