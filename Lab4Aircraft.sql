
use db;
create table flight(fno int,fromname varchar(20),toname varchar(20),dis int,departs time,arrive time,price float,primary key(fno));
create table aircraft(aid int,aname varchar(20),air_engine int,primary key(aid));
create table employee(eid int,ename varchar(20),salary float,primary key(eid));
create table certified(eid int,aid int,foreign key(eid) references employee(eid),foreign key(aid) references aircraft(aid));

drop table flight;
drop table certified;
drop table employee;
drop table aircraft;

INSERT INTO FLIGHT VALUES(111,'BENGALURU','FRANKFURT',1000,'09:30','16:00',10000);
INSERT INTO FLIGHT VALUES(222,'MANDISION','BENGALURU',1020,'01:30','7:00',9000);
INSERT INTO FLIGHT VALUES(333,'BENGALURU','FRANKFURT',1000,'01:40','12:00',9500);
INSERT INTO FLIGHT VALUES(444,'BENGALURU','NEW DELHI',550,'08:00','13:00',5000);
INSERT INTO FLIGHT VALUES(555,'NEW DELHI','NEW YORK',5000,'13:30','17:00',15000);
INSERT INTO FLIGHT VALUES(666,'MANDISION','NEW YORK',12000,'16:30','19:00',20000);
INSERT INTO FLIGHT VALUES(777,'BENGALURU','NEW YORK',12000,'16:30','19:00',20000);
delete from flight where fno=222;

INSERT INTO AIRCRAFT VALUES(10,'AIR ASIA',12000);
INSERT INTO AIRCRAFT VALUES(20,'GO AIR',2000);
INSERT INTO AIRCRAFT VALUES(30,'AIR ASIA',600);
INSERT INTO AIRCRAFT VALUES(40,'INDIGO',5000);
INSERT INTO AIRCRAFT VALUES(50,'SPICE JET',900);
INSERT INTO AIRCRAFT VALUES(60,'SPICE JET',12500);

INSERT INTO EMPLOYEE VALUES(1,'EMPLOYEE1',82000);
INSERT INTO EMPLOYEE VALUES(2,'EMPLOYEE2',15000);
INSERT INTO EMPLOYEE VALUES(3,'EMPLOYEE3',60000);
INSERT INTO EMPLOYEE VALUES(4,'EMPLOYEE4',81000);
INSERT INTO EMPLOYEE VALUES(5,'EMPLOYEE5',9000);
INSERT INTO EMPLOYEE VALUES(6,'EMPLOYEE6',70000);

INSERT INTO CERTIFIED VALUES(1,10);
INSERT INTO CERTIFIED VALUES(4,10);
INSERT INTO CERTIFIED VALUES(3,40);
INSERT INTO CERTIFIED VALUES(5,30);
INSERT INTO CERTIFIED VALUES(5,50);
INSERT INTO CERTIFIED VALUES(4,50);
INSERT INTO CERTIFIED VALUES(4,20);
INSERT INTO CERTIFIED VALUES(4,30);

SELECT * FROM FLIGHT;
SELECT * FROM AIRCRAFT;
SELECT * FROM EMPLOYEE;
SELECT * FROM CERTIFIED;

-- Find the names of aircraft such that all pilots certified to operate them have salaries more than Rs.80,000
select * from aircraft a where exists(
	select * from employee e,certified c where
		e.eid=c.eid
        and a.aid=c.aid 
        and salary>80000
	
);


-- For each pilot who is certified for more than three aircrafts, find the eid and the maximum cruising range of the aircraft for which 
-- she or he is certified. 
select e.eid,count(e.eid),max(a.air_engine) from certified c,aircraft a,employee e
where c.eid=e.eid and c.aid=a.aid
group by e.eid
having count(e.eid)>3;



-- Find the names of pilots whose salary is less than the price of the cheapest route from Bengaluru to Frankfurt. 
select * from employee e where
e.salary <=(
select min(f.price) from flight f where f.fromname='BENGALURU' and f.toname='FRANKFURT'
);

-- For all aircraft with cruising range over 1000 Kms, find the name of the aircraft and the average salary 
-- of all pilots certified for this aircraft.
select *,avg(e.salary) from employee e,certified c,aircraft a 
where c.eid=e.eid and a.aid=c.aid and a.air_engine>1000 
group by(a.aid);

-- Find the names of pilots certified for some Boeing aircraft. 

-- Find the aids of all aircraft that can be used on routes from Bengaluru to New Delhi
select * from aircraft a 
where a.air_engine>(select min(f1.dis) from flight f1 where  f1.fromname='BENGALURU' and f1.toname='NEW DELHI'); 

-- Print the name and salary of every non-pilot whose salary is more than the average salary for pilots
select * from employee e where
e.eid not in(select c1.eid from certified c1)
 and e.salary>(select avg(salary) from employee e2,certified c2 where c2.eid=e2.eid); 
 
-- A customer wants to travel from Madison to New York with no more than two changes of flight. List the choice of 
-- departure times from Madison if the customer wants to arrive in New York by 6 p.m. 
select * from flight f 
where f.fno in 
(select f1.fno from flight f1 where f1.fromname='MANDISION' and f1.toname='NEW YORK' and  extract(hour from f1.arrive)>18)
or f.fno in
(select f2.fno from flight f2 where f2.fromname='MANDISION' 
							  and f2.arrive<= ANY (select f3.arrive from flight f3 where f3.toname='NEW YORK' 
																			  and extract(hour from f3.arrive)>18
											 )
);


