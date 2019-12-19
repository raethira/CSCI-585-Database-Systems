-- Remote server-based DB: http://sqlfiddle.com
-- Database: PostgreSQL 9.6

-- Build Schema

DROP TABLE IF EXISTS workOrders;

CREATE TABLE workOrders
(ProjectID CHAR(30) NOT NULL,
Step INTEGER NOT NULL,
Status_ CHAR(1) NOT NULL,
PRIMARY KEY (ProjectID, Step)
);

-- Run SQL

INSERT INTO workOrders(ProjectID, Step, Status_)
VALUES 
('P100', 0, 'C'),
('P100', 1, 'W'),
('P100', 2, 'W'),
('P201', 0, 'C'),
('P201', 1, 'C'),
('P333', 0, 'W'),
('P333', 1, 'W'),
('P333', 2, 'W'),
('P333', 3, 'W'); 

-- Selects projects which have completed Step 0, but waiting in step 1.
                                                                
SELECT ProjectID
FROM workOrders
WHERE (Step = 0 AND Status_ = 'C') AND ProjectID IN ( SELECT ProjectID
                                                 	  FROM workOrders
                                                 	   WHERE (Step = 1 AND Status_ = 'W')
                                                 	);