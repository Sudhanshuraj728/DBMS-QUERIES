create database if not exists SUPPLIER;
use SUPPLIER;

create table supplier(Sid int primary key, Sname varchar(30), city varchar(30));

insert into supplier(Sid, Sname, city)
values(10001, "acme_widget", "bangalore"),
	  (10002, "johns", "kolkata"),
      (10003, "vimal", "mumbai"),
      (10004, "reliance", "delhi");
     
create table parts(Pid int primary key, Pname varchar(30), color varchar(30));

insert into parts(Pid, Pname, color)
values(20001, "book", "red"),
      (20002, "pen", "red"),
      (20003, "pencil", "green"),
      (20004, "mobile", "green"),
      (20005, "charger", "black");
     
create table catalog(Sid int references supplier(Sid),Pid int references parts(Pid), cost int);

insert into catalog(Sid, Pid, cost)
values(10001, 20001, 10),
      (10001, 20002, 10),
      (10001, 20003, 30),
      (10001, 20004, 10),
      (10001, 20005, 10),
      (10002, 20001, 10),
      (10002, 20002, 20),
      (10003, 20003, 30),
      (10004, 20003, 40);
     
select * from supplier;
select * from parts;
select * from catalog;
-- i) Find the pnames of parts for which there is some supplier.
-- ii) Find the snames of suppliers who supply every part.
-- iii) Find the snames of suppliers who supply every red part.
-- iv) Find the pnames of parts supplied by Acme Widget Suppliers and by no one else.
-- v) Find the sids of suppliers who charge more for some part than the average cost of that
-- part (averaged over all the suppliers who supply that part).
-- vi) For each part, find the sname of the supplier who charges the most for that part.

select distinct p.Pname
from parts p, catalog c
where p.Pid = c.Pid;


select s.Sname
from supplier s where ((select count(p.Pid)
from parts p) =(select count(c.Pid)
				from catalog c
				where c.Sid = s.Sid));
                

select s.Sname
from supplier s where ((select count(p.Pid)
from parts p where color = "red" ) =
                        (select count(c.Pid)
                        from catalog c , parts p
                        where c.Sid = s.Sid and
                        c.Pid = p.Pid and p.color = "red"));
                        

select distinct p.Pname
from parts p, catalog c, supplier s
where c.Pid not  in (select p2.pid from parts p2, catalog c2, supplier s2 where s2.Sname!="acme_widget" and s2.Sid=c2.Sid and c2.Pid =p2.Pid ) and c.Sid = s.Sid and c.Pid = p.Pid
and s.Sname = "acme_widget";


select distinct c.Sid
from catalog c where c.cost > (select avg(c1.cost)
from catalog c1 where c1.Pid = c.Pid);


select p.Pid, s.Sname
from parts p, supplier s, catalog c
where c.Pid = p.Pid and c.Sid = s.Sid and
c.cost = (select max(c1.cost)
         from catalog c1 where 
         c1.Pid = c.Pid)