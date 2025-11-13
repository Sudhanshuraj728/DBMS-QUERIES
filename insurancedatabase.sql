CREATE DATABASE IF NOT EXISTS Insurance;
USE Insurance;

CREATE TABLE Person(Driver_ID varchar(15) PRIMARY KEY, Name varchar(20), Address varchar(50));
INSERT INTO Person(Driver_ID, Name, Address)
VALUES
("A01", "Richard", "Srinivas Nagar"),
("A02", "Pradeep", "Rajaji Nagar"),
("A03", "Smith", "Ashok Nagar"),
("A04", "Venu", "N R Colony"),
("A05", "John", "Hanumanth Nagar");

CREATE TABLE Car(Reg_num varchar(8) PRIMARY KEY, Model varchar(20), Year int);
INSERT INTO Car(Reg_num, Model, Year)
VALUES
("KA052250", "Indica", 1999),
("KA031181", "Lancer", 1957),
("KA095477", "Toyota", 1998),
("KA053408", "Honda", 2008),
("KA041702", "Audi", 2005);

CREATE TABLE Owns(Driver_ID varchar(15) references Person(Driver_ID), Reg_num varchar(8) references Car(Reg_num));
INSERT INTO Owns(Driver_ID, Reg_num)
VALUES
("A01", "KA052250"),
("A02", "KA031181"),
("A03", "KA095477"),
("A04", "KA053408"),
("A05", "KA041702");

CREATE TABLE Participated(Driver_ID varchar(15) references Person(Driver_ID), Reg_num varchar(8) references Car(Reg_num), Report_num int PRIMARY KEY, Damage_amt int);
INSERT INTO Participated(Driver_ID, Reg_num, Report_num, Damage_amt)
VALUES
("A01", "KA052250", 11, 10000),
("A02", "KA031181", 12, 50000),
("A03", "KA095477", 13, 25000),
("A04", "KA053408", 14, 3000),
("A05", "KA041702", 15, 5000);

CREATE TABLE Accident(Report_num int references Participated(Report_num), Accident_date date, Location varchar(50));
INSERT INTO Accident(Report_num, Accident_date, Location)
VALUES
(11, "2003-01-01", "Mysore Road"),
(12, "2004-02-02", "South End Circle"),
(13, "2003-01-21", "Bull Temple Road"),
(14, "2008-02-17", "Mysore Road"),
(15, "2005-03-04", "Kanakpura Road");

SELECT * FROM Person;
SELECT * FROM Car;
SELECT * FROM Owns;
SELECT * FROM Accident;
SELECT * FROM Participated;

UPDATE Participated SET Damage_amt= 25000 WHERE Reg_num="KA031181" AND Report_num=12;
INSERT INTO Accident VALUES(16,"2008-03-15","Domlur");
SELECT Driver_ID FROM Participated WHERE Damage_amt>=25000;
SELECT COUNT(DISTINCT Driver_ID) Count FROM Participated, Accident WHERE Participated.Report_num=Accident.Report_num AND Accident.Accident_date LIKE "2008%";

select * from Participated order by Damage_amt Desc;

select AVG(Damage_amt) from Participated;

delete from Participated where Damage_amt < 13600;
SET SQL_SAFE_UPDATES = 0;

select Name from Person A , Participated B where A.Driver_ID = B.Driver_ID AND Damage_amt > (select AVG(Damage_amt) from Participated);

select max(Damage_amt) from Participated;
