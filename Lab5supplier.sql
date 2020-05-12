use db;
create table supplier(
	sid int,
    sname varchar(10),
    address varchar(10),
    primary key(sid)
);

create table parts(
	pid int,
    pname varchar(10),
    pcolor varchar(10),
    primary key(pid)
);

create table catalog(
	sid int,
    pid int,
    cost real,
    primary key(sid,pid),
    foreign key(sid) references supplier(sid),
    foreign key(pid) references parts(pid)
);

insert into supplier values
(1,'s1','a1'),
(2,'s2','a1'),
(3,'s3','a2'),
(4,'s4','a1');

insert into parts values
(1,'p1','c1'),
(2,'p2','c1'),
(3,'p3','c1'),
(4,'p4','c2'),
(5,'p5','c3');

insert into catalog values
(1,1,1000),
(1,2,2000),
(1,3,3000),
(1,4,4000),
(1,5,5000),
(2,2,1000),
(2,3,1000),
(2,4,1000),
(3,1,1000);
insert into catalog values
(2,1,1000);

select* from parts;
select * from supplier;
select * from catalog;

-- names of parts for which there is supplier
select distinct p.pname  from parts p,catalog c where  p.pid=c.pid;

-- names of supp who supply every part
select s.sname from supplier s where not exists
(select p.pid from parts p where not exists(select c.pid from catalog c where c.pid=p.pid and s.sid=c.sid ));

-- names of supp who supply every c1 part
select s.sname from supplier s where not exists
(select p.pid from parts p where p.pcolor='c1' and not exists(select c.pid from catalog c where c.pid=p.pid and s.sid=c.sid ));

-- part supplied by  supplier s1 n by no one else
select p.pname from parts p where not exists
(select s.sid from supplier s,catalog c where s.sname!='s1' and c.pid=p.pid and c.sid=s.sid);

-- supplier who charges more than avg for a part
select s.sid,c.pid,c.cost from supplier s,catalog c
where s.sid=c.sid
and c.cost>(select avg(c1.cost) from catalog c1 where c1.pid=c.pid);
select * from catalog;

-- supp who charges most for that part
select c.sid,c.pid from catalog c
where c.cost=(
select max(c1.cost) from catalog c1 where c1.pid=c.pid 
);  

-- supplier who supplies only red part
delete from catalog where sid=2 and pid=4;
select * from supplier s where not exists(
	select p.pid from catalog c, parts p where c.sid=s.sid and c.pid=p.pid and p.pcolor!='c1'
);
