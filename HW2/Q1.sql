-- Remote server-based DB: http://sqlfiddle.com
-- Database: PostgreSQL 9.6

-- Build Schema

CREATE TABLE "2016020200"
(roomNum INTEGER NOT NULL,
arrDate DATE NOT NULL,
depDate DATE NOT NULL,
guestName CHAR(30) NOT NULL,
arrTime INTEGER NOT NULL,
depTime INTEGER NOT NULL,
PRIMARY KEY (roomNum),
CONSTRAINT CHK_arr_dep_same_date_check_time CHECK ( ( (arrDate = depDate) AND (arrTime <= depTime) ) OR ( (arrDate < depDate) ) )
);

CREATE TABLE "2016020301"
(roomNum INTEGER NOT NULL,
arrDate DATE NOT NULL,
depDate DATE NOT NULL,
guestName CHAR(30) NOT NULL,
arrTime INTEGER NOT NULL,
depTime INTEGER NOT NULL,
PRIMARY KEY (roomNum),
CONSTRAINT CHK_arr_dep_same_date_check_time CHECK ( ( (arrDate = depDate) AND (arrTime <= depTime) ) OR ( (arrDate < depDate) ) )
);

CREATE TABLE "2016020402"
(roomNum INTEGER NOT NULL,
arrDate DATE NOT NULL,
depDate DATE NOT NULL,
guestName CHAR(30) NOT NULL,
arrTime INTEGER NOT NULL,
depTime INTEGER NOT NULL,
PRIMARY KEY (roomNum),
CONSTRAINT CHK_arr_dep_same_date_check_time CHECK ( ( (arrDate = depDate) AND (arrTime <= depTime) ) OR ( (arrDate < depDate) ) )
);

CREATE TABLE "2016020503"
(roomNum INTEGER NOT NULL,
arrDate DATE NOT NULL,
depDate DATE NOT NULL,
guestName CHAR(30) NOT NULL,
arrTime INTEGER NOT NULL,
depTime INTEGER NOT NULL,
PRIMARY KEY (roomNum),
CONSTRAINT CHK_arr_dep_same_date_check_time CHECK ( ( (arrDate = depDate) AND (arrTime <= depTime) ) OR ( (arrDate < depDate) ) )
);

CREATE TABLE "2016020604"
(roomNum INTEGER NOT NULL,
arrDate DATE NOT NULL,
depDate DATE NOT NULL,
guestName CHAR(30) NOT NULL,
arrTime INTEGER NOT NULL,
depTime INTEGER NOT NULL,
PRIMARY KEY (roomNum),
CONSTRAINT CHK_arr_dep_same_date_check_time CHECK ( ( (arrDate = depDate) AND (arrTime <= depTime) ) OR ( (arrDate < depDate) ) )
);

-- Run SQL

-- Assumptions & solution:
-- Table name = "YYYYMMDDHH"
-- I re-designed the table in a such way that it takes care of time of the day as well.  Since, the solution is not concerned with efficiency, I create below number of tables:
-- Number of tables = Number of days * 24
-- Furthermore, time can be divided into more categories and we can have days * 24 * 60 * 60 tables per second.
-- Since I plan to maintain these number of tables, I insert customer based on their arrival/departure date and time in all of the tables ranging from (arrDate,arrTime) to (depDate, depTime).
-- I have created only 5 sample tables above to illustrate and customer 'A' will be inserted in all tables from 2016020200 - 2016020610

INSERT INTO "2016020200"(roomNum, arrDate, depDate, guestName, arrTime, depTime)
VALUES 
(123, to_date('20160202', 'YYYYMMDD'), to_date('20160206','YYYYMMDD'), 'A', 0, 10 );

INSERT INTO "2016020301"(roomNum, arrDate, depDate, guestName, arrTime, depTime)
VALUES 
(123, to_date('20160202', 'YYYYMMDD'), to_date('20160206','YYYYMMDD'), 'A', 0, 10 )

-- CASE 3: When arrDate == depDate and arrTime > depTime
-- Below insert would fail because of the constraint CHK_arr_dep_same_date_check_time
-- (124, to_date('20160203', 'YYYYMMDD'), to_date('20160203','YYYYMMDD'), 'D', 13, 11 )
;

INSERT INTO "2016020402"(roomNum, arrDate, depDate, guestName, arrTime, depTime)
VALUES 
(123, to_date('20160202', 'YYYYMMDD'), to_date('20160206','YYYYMMDD'), 'A', 0, 10 )
-- CASE 2: Requirement for issue2 is handled here-
-- Below case would fail, since guest 'A' already resides in room 123(Primary key) and addition of guest 'B' is not possible in the same room 123 because of PK constraint.
--(123, to_date('20160204', 'YYYYMMDD'), to_date('20160208','YYYYMMDD'), 'B', 2, 13 )
;

INSERT INTO "2016020503"(roomNum, arrDate, depDate, guestName, arrTime, depTime)
VALUES 
(123, to_date('20160202', 'YYYYMMDD'), to_date('20160206','YYYYMMDD'), 'A', 0, 10 );

INSERT INTO "2016020604"(roomNum, arrDate, depDate, guestName, arrTime, depTime)
VALUES 
(123, to_date('20160202', 'YYYYMMDD'), to_date('20160206','YYYYMMDD'), 'A', 0, 10 )
-- CASE 1: Requirement for issue1 is handled here-
-- Below case would fail since arrDate > depDate by constraint CHK_arr_dep_same_date_check_time
-- (201, to_date('20160206', 'YYYYMMDD'), to_date('20160204','YYYYMMDD'), 'C', 4 , 11)
; 

-- CASE 4: new arrDate == current depDate
-- The above is handled by comparing the time in the constraint CHK_arr_dep_same_date_check_time


