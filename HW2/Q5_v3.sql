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

-- In this version, I use EXISTS keyword and use co-related sub-queries.  This is a typical programming for-loops scenario.\
-- First, the inner-most loop(query) gets executed and results in all combinations of Chef column having 'Apple pie'\
-- , 'Tiramisu' and 'Creme brulee' with one row at the outermost query.  Second row will be taken from the outermost query and same procedure\
-- is followed till we complete all the co-related sub-queries.  Finally, we will have only DISTINCT Chefs from these co-related sub-queries\
-- who can cook all three dishes.
-- Assumption: Dish values are hard-coded as per HW guidelines.

SELECT DISTINCT Chef
FROM desserts as t1
WHERE EXISTS ( SELECT Chef
               FROM desserts as t2
               WHERE t1.Chef = t2.Chef AND t2.Dish = 'Creme brulee' 
               AND 
               EXISTS ( SELECT Chef
                        FROM desserts as t3
                        WHERE t2.Chef = t3.Chef AND t3.Dish = 'Apple pie'
               AND 
               EXISTS ( SELECT Chef
                        FROM desserts as t4
                        WHERE t3.Chef = t4.Chef AND t4.Dish = 'Tiramisu'       
                      )
                      )
              );