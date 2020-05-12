use db;
create table STUDENT(snum int, sname varchar(10), major varchar(10), slevel varchar(10), age int, primary key(snum)); 
create table FACULTY (fid int, fname varchar(10), deptid int,primary key(fid));
create table CLASS (
	cname varchar(10),
    meets_at time,
    room varchar(10),
    fid int,
    primary key(cname,meets_at,room),
    foreign key (fid) references faculty(fid)
);
create table ENROLLED (
	snum int,
    cname varchar(10),
    foreign key (cname) references class(cname),
    foreign key (snum) references student(snum),
    primary key(snum,cname)
);
insert into student values
(1,'s1','m1','l1',10),
(2,'s2','m1','l1',10),
(3,'s3','m1','l2',11),
(4,'s4','m1','l3',12),
(5,'s5','m2','l1',13),
(6,'s6','m2','l1',10),
(7,'s7','m2','l2',11),
(8,'s8','m2','l3',14)
;

insert into faculty values
(1,'f1',1),
(2,'f2',1),
(3,'f3',1),
(4,'f4',2),
(5,'f5',2),
(6,'f6',3),
(7,'f7',4);

-- drop table enrolled;
-- drop table class;
insert into class values
('c1','00:01:11','r1',1),
('c2','00:01:09','r2',2),
('c3','00:01:11','r3',3),
('c4','00:01:11','r1',4),
('c5','00:01:12','r1',5);

insert into class values
('c6','00:01:1','r2',1),
('c7','00:01:2','r3',1),
('c8','00:01:3','r4',1),
('c9','00:01:4','r5',1);

insert into enrolled values
(1,'c1'),
(1,'c2'),
(1,'c3'),
(1,'c4'),
(1,'c5'),
(2,'c1'),
(2,'c2'),
(3,'c3'),
(4,'c4'),
(5,'c5'),
(6,'c5');

select * from Student;
select * from faculty;
select * from enrolled;
select * from class;


-- names of all jrs who attend class taught by f1 
select * from student s,class c,faculty f 
where s.slevel='l1'
and c.fid=f.fid
and f.fname='f1';


-- clases that either meet in room208 or have 5 or more students enrolled
select * from class c 
where c.room='r2'
or ((select distinct count(e.snum) from enrolled e where e.cname=c.cname)>=3) ;

select * from Student;
select * from faculty;
select * from enrolled;
select * from class;

-- students who r enrolled in2 classes that meet at same time
select * from student s,enrolled e
where e.snum=s.snum and
not exists(
	select * from enrolled e1,class c1 
    where e1.snum=e.snum 
    and e1.cname!=e.cname
    and c1.cname=e1.cname
    and c1.meets_at=(select meets_at from class c where c.cname=e.cname)
);


-- Find the names of faculty members who teach in every room in which some class is taught
select * from faculty f
where not exists(
	select distinct(room) from class c where
    c.room NOT IN (select c1.room from class c1 where  c1.fid=f.fid)
);

-- Find the names of faculty members for whom the combined enrollment of the courses that they teach is less than five. 
select * from faculty f where 
((select count(*) from enrolled e,class c where e.cname=c.cname and c.fid=f.fid)<3);


-- Find the names of students who are not enrolled in any class.  
select * from student s where NOT EXISTS
(select * from enrolled e where s.snum=e.snum);


-- For each age value that appears in Students, find the level value that appears most often.
-- For example, if there are more FR level students aged 18 than SR, JR, or SO students aged 18, you should print the pair (18, FR). 
select  agelevel,max(levelcount) from (select slevel as agelevel,count(slevel)as levelcount  from student   group by slevel)levelncount; 
select distinct(s.age) ,s.slevel from student s
 where s.slevel in (
				select agelevel from(select  agelevel,max(levelcount) from 
                (select slevel as agelevel,count(slevel)as levelcount  from student where age=s.age   group by slevel)levelncount)maxlevels
				
) ;
 


