/*
Junjia Lin (#002269013)
Luyun Nie (#002268087)
Wentao Lu (#002276355)
Yi Ren (#002269013)
*/

INSERT INTO TEACHER VALUES 
(00111,'John A. Brown','P','CS'),
(00112,'James kareter','P','ECE'),
(00113,'Christopher Lee','AP', 'ECE'),
(00114,'Susanne Hambrusch','L','CS'),
(00115,'Sheron Noel','P','MA'),
(00116,'Kim Basinger','AP','ECE'),
(00117,'Christopher Clifton','P','CS'),
(00118,'Elisa Bertino','P','CS'), 
(00119,'Susanne Hambrusch','AP','CS');

INSERT INTO COURSE VALUES
('CS110','Intro to Computers','F'),
('CS348','Information Systems','S'),  
('CS250','Computer Architecture','SP'),
('CS448','Intro to Data Bases','S'),
('MA511','Linear Algebra','GR'),
('CS503','Operating System','GR'), 
('MA525','Intro to Complex Analysis','GR'), 
('ECE264','Advanced C Programming','S'),
('ECE255','Intro to Electric Analysis & Design','S');

INSERT INTO STUDENT VALUES
(234,'Anglo Anebal','F'),
(235,'Abram Ace','S'),
(236,'Adelbert Antti','SP'), 
(237,'William Walker','GR'),
(238,'Emila Wdyth','GR'),
(239,'Judith Elba','S'),
(240,'Benjamin Bratt','SP'),
(241,'Tawny Kitaen','F');

INSERT INTO ENROLMENT VALUES
('CS110',    240),
('CS110',    241),
('CS348',   235),
('CS348',     239),
('CS348',     237),
('CS250',     236),
('CS250',     241),
('ECE264',    236),
('ECE264',    237),
('ECE264',    238),
('MA525',     236),
('CS503',     238),
('CS503',     239),
('CS448',     240),
('CS250',     240),
('MA511',     240);

INSERT INTO COURSE_SCHEDULE VALUES
('CS110',       00114),
('CS348',       00117),
('CS250',       00118),
('CS448',       00114),
('MA511',       00115),
('CS503',       00119),
('MA525',       00115),
('ECE264',      00113),
('ECE255',      00116);