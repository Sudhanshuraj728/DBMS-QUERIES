CREATE DATABASE IF NOT EXISTS Bank;
USE Bank;

CREATE TABLE Branch(Branch_name varchar(20) PRIMARY KEY, Branch_city varchar(20), Assests int);
INSERT INTO Branch(Branch_name, Branch_city, Assests)
VALUES
("SBI_Chamrajpet", "Banglore", 50000),
("SBI_ResidencyRoad", "Banglore", 10000),
("SBI_ShivajiRoad", "Bombay", 20000),
("SBI_ParliamentRoad", "Delhi", 10000),
("SBI_JantarMantar", "Delhi", 20000);

CREATE TABLE BankAccount(Acc_no int PRIMARY KEY, Branch_name varchar(20) references Branch(Branch_name), Balance int);
INSERT INTO BankAccount(Acc_no, Branch_name, Balance)
VALUES
(1, "SBI_Chamrajpet", 2000),
(2, "SBI_ResidencyRoad", 5000),
(3, "SBI_ShivajiRoad", 6000),
(4, "SBI_ParliamentRoad", 9000),
(5, "SBI_JantarMantar", 8000),
(6, "SBI_ShivajiRoad", 4000),
(8, "SBI_ResidencyRoad", 4000),
(9, "SBI_ParliamentRoad", 3000),
(10, "SBI_ResidencyRoad", 5000),
(11, "SBI_JantarMantar", 2000);

CREATE TABLE BankCustomer(Customer_name varchar(20) PRIMARY KEY, Customer_city varchar(20) , City varchar(20));
INSERT INTO BankCustomer(Customer_name, Customer_city, City)
VALUES
("Avinash", "Bull_Temple_Road", "Banglore"),
("Dinesh", "Bannerghatta_Road", "Banglore"),
("Mohan", "NationalCollege_Road ", "Banglore"),
("Nikhil", "Akbar_Road", "Delhi"),
("Ravi", "Prithviraj_Road", "Delhi");

CREATE TABLE Depositer(Customer_name varchar(20) references BankCustomer(Customer_name), Acc_no int references BankAccount(Acc_no));
INSERT INTO Depositer(Customer_name, Acc_no)
VALUES
("Avinash", 1),
("Dinesh", 2),
("Nikhil", 4),
("Ravi", 5),
("Avinash", 8),
("Nikhil", 9),
("Dinesh", 10),
("Nikhil", 11);

CREATE TABLE Loan(Loan_number int, Branch_name varchar(20) references Branch(Branch_name), Amount int);
INSERT INTO Loan(Loan_number, Branch_name, Amount)
VALUES
(1, "SBI_Chamrajpet", 1000),
(2, "SBI_ResidencyRoad", 2000),
(3, "SBI_ShivajiRoad", 3000),
(4, "SBI_ParliamentRoad", 4000),
(5, "SBI_JantarMantar", 5000);

SELECT * FROM Loan ORDER BY Amount DESC;
(SELECT Customer_name FROM Depositer) UNION (SELECT Customer_name FROM BankCustomer);
CREATE VIEW BranchTotal AS SELECT Branch_name, SUM(Amount) FROM Loan GROUP BY Branch_name;
SELECT * FROM BranchTotal;
INSERT INTO Loan VALUES(6,"SBI_ShivajiRoad",2500);
SELECT * FROM Loan;
SELECT Branch_name, (Assests/100000) AS Assests_Lakhs FROM Branch;
UPDATE BankAccount SET Balance= Balance*1.05;
SELECT * FROM BankAccount;
