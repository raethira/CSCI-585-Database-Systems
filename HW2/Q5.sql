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

-- In this version, I am querying the same desserts table three times,\
-- each time selecting chefs who can make Creme brulee, Apple pie and Tiramisu respectively.  I grab those Chefs and find an intersection among all three\
-- results to get those chefs who can make all three dishes.  Finally, DISTINCT will remove repeating values in the Chef column.
-- Assumption: Dish values are hard-coded as per HW guidelines.

SELECT DISTINCT Chef
FROM desserts
WHERE 
Chef IN (SELECT Chef
               FROM desserts
               WHERE Dish = 'Creme brulee')
AND
Chef IN (SELECT Chef
               FROM desserts
               WHERE Dish = 'Apple pie')            
AND
Chef IN (SELECT Chef
               FROM desserts
               WHERE Dish = 'Tiramisu');
               
            
               
               

