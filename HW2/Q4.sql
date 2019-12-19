-- Remote server-based DB: http://sqlfiddle.com
-- Database: PostgreSQL 9.6

-- Build Schema

DROP TABLE IF EXISTS junkmail;

CREATE TABLE junkmail
(Name CHAR(30) NOT NULL,
Address CHAR(1) NOT NULL,
ID INTEGER NOT NULL,
SameFam INTEGER NULL,
PRIMARY KEY (ID)
);

-- Run SQL

INSERT INTO junkmail(Name, Address, ID, SameFam)
VALUES 
('Alice', 'A', 10, NULL),
('Bob', 'B', 15, NULL),
('Carmen', 'C', 22, NULL),
('Diego', 'A', 9, 10),
('Ella', 'B', 3, 15),
('Farkhad', 'D', 11, NULL); 

-- Delete family members names that have 'NULL' for SameFam and another family member in the db
DELETE FROM junkmail
WHERE  ID IN (SELECT SameFam
              FROM junkmail
             );

-- According to Piazza post @73
UPDATE junkmail   
SET SameFam = NULL;

SELECT * 
FROM junkmail;   