CREATE DATABASE IF NOT EXISTS Students;
USE Students;
CREATE TABLE Student_Info(Std_ID int, Std_name varchar(20), DOB date, DOJ date, Fee int, Gender char);
INSERT INTO Student_Info(Std_ID, Std_name, DOB, DOJ, Fee, Gender)
VALUES
(1, "Sharif", "2001-01-10", "2001-10-05", 10000, "M"),
(2, "Nadeem", "2019-11-03", "2001-10-26", 11000, "M");
ALTER TABLE Student_Info ADD Phone_no int;
ALTER TABLE Student_Info RENAME COLUMN Phone_no TO Student_no;
SELECT * FROM Student_Info;
DELETE FROM Student_Info WHERE Std_ID = 2