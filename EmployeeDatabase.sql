create database employee;
use employee;

create table DEPT(deptNo int primary key,dName varchar(30),dLoc varchar(30));
create table Employee(empNo int primary key,ename varchar(30),mgr_No  int, hireDate date, sal double, deptNo int , foreign key (deptNo) references DEPT(deptNo));
create table Project(pNo int primary key, pLoc varchar(30),pName varchar(30));
create table Incentives(empNo int, incentive_Date date, incentive_Amount double, foreign key (empNo) references Employee(empNo));
create table Assigned_to(empNo int,pNo int,Job_Role varchar(30), foreign key (empNo) references Employee(empNo), foreign key (pNo) references Project(pNo));

INSERT INTO DEPT(deptNo, dName, dLoc)
VALUES
(1, 'Human Resources', 'Bengaluru'),
(2, 'Finance', 'Mysuru'),
(3, 'Research & Development', 'Hyderabad'),
(4, 'Marketing', 'Bengaluru'),
(5, 'Operations', 'Delhi'),
(6, 'IT support', 'Hyderabad');

INSERT INTO Employee(empNo, eName, mgr_No, hireDate, sal, deptNo)
VALUES
(201, 'Rahul', NULL, '2014-03-10', 90000, 1),
(202, 'Suryansh', NULL, '2016-05-20', 85000, 2),
(203, 'Ajay', NULL, '2015-07-25', 65000, 3),
(101, 'Rohan', 201, '2020-01-15', 55000, 1),
(102, 'Kartik', 201, '2019-05-22', 60000, 2),
(103, 'Mathews', 202, '2021-03-10', 45000, 3),
(104, 'Aditya', 203, '2018-11-12', 75000, 4),
(105, 'Aksh', 203, '2020-09-05', 50000, 5),
(106, 'Sambhav', 202, '2022-07-19', 48000, 6);

INSERT INTO Project(pNo, pLoc, pName)
VALUES
(1, 'Bengaluru', 'Employee Engagement System'),
(2, 'Delhi', 'Automated Payroll Tracker'),
(3, 'Hyderabad', 'AI Innovation Lab'),
(4, 'Bengaluru', 'Digital Marketing Portal'),
(5, 'Mysuru', 'Operational Workflow Manager'),
(6, 'Hyderabad', 'IT Helpdesk Assistant');


INSERT INTO Incentives(empNo, incentive_Date, incentive_Amount)
VALUES
(101, '2023-01-15', 2000),
(102, '2020-01-25', 2500),
(103, '2022-01-05', 3000),
(104, '2020-02-10', 0),
(105, '2023-01-18', 2200),
(106, '2023-01-15', 0);

INSERT INTO Assigned_to(empNo, pNo, Job_Role)
VALUES
(101, 1, 'Developer'),
(102, 2, 'Database Admin'),
(103, 3, 'IoT Engineer'),
(104, 4, 'Project Lead'),
(105, 5, 'Designer'),
(106, 6, 'Electrical Analyst'),
(201, 1, 'Manager'),
(202, 2, 'Manager'),
(203, 3, 'Manager');
#query3
select e.empNo from Employee e,Project p,Assigned_to a where e.empNo=a.empNo and a.pNo=p.pNo and p.pLoc in( 'Bengaluru','Hyderabad','Mysuru');
#query4
SELECT e.empNo
FROM Employee e
WHERE e.empNo NOT IN (
    SELECT i.empNo
    FROM Incentives i
    WHERE i.incentive_Amount != 0
);

#query5
select e.eName,e.empNo,d.dName,a.Job_Role,d.dLoc,p.pLoc from Employee e,DEPT d ,Assigned_to a , Project p where e.empNo=a.empNo and a.pNo=p.pNo and e.deptNo=d.deptNo and p.pLOC=d.dLoc;

# ADDITIONAL QUERIES
#query3
select mgr_No,count( mgr_No) from Employee group by mgr_No;
#query4
SELECT m.eName AS Manager_Name
FROM Employee m
WHERE m.empNo IN (
    SELECT e.mgr_No
    FROM Employee e
    WHERE e.mgr_No IS NOT NULL
)
AND m.sal > (
    SELECT AVG(e.sal)
    FROM Employee e
    WHERE e.mgr_No = m.empNo
);
#query5
SELECT e.eName AS Second_Top_Level_Manager,
       m.eName AS Top_Level_Manager,
       d.dName AS Department_Name
FROM Employee e
JOIN Employee m ON e.mgr_No = m.empNo
JOIN DEPT d ON e.deptNo = d.deptNo
WHERE m.mgr_No IS NULL        
  AND e.deptNo = m.deptNo;    
  #query6
SELECT e.*
FROM Employee e
JOIN Incentives i ON e.empNo = i.empNo
WHERE MONTH(i.incentive_Date) = 1 AND YEAR(i.incentive_Date) = 2023
ORDER BY i.incentive_Amount DESC
LIMIT 1 OFFSET 1;

#query7
SELECT e.empNo, e.eName, e.deptNo, d.dName
FROM Employee e
JOIN Employee m ON e.mgr_No = m.empNo
JOIN DEPT d ON e.deptNo = d.deptNo
WHERE e.deptNo = m.deptNo;
