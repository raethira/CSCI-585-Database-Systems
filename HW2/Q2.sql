-- Remote server-based DB: http://sqlfiddle.com
-- Database: PostgreSQL 9.6

-- Build Schema

DROP TABLE IF EXISTS enrollment;

CREATE TABLE enrollment
(SID INTEGER NOT NULL,
ClassName CHAR(30) NOT NULL,
Grade CHAR(1) NOT NULL,
PRIMARY KEY (SID, ClassName)
);

-- Run SQL

INSERT INTO enrollment(SID, ClassName, Grade)
VALUES 
(123, 'ARCH201', 'A'),
(123, 'QUAN432', 'B'),
(662, 'AMER352', 'B'),
(662, 'ECON966', 'A'),
(662, 'QUAN432', 'B'),
(345, 'QUAN432', 'A'),
(345, 'ECON966', 'D')
; 

-- GROUP BY calculates number of students enrolled in the course and ORDER BY sorts it in reverse order of enrollment

SELECT ClassName, COUNT(*)
FROM enrollment
GROUP BY ClassName 
--According to Piazza post @60
ORDER BY 2 DESC, ClassName;