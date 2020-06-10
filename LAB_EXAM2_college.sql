 -- STUDENT(USN, SName, Address, Phone, Gender)  
--  SEMSEC(SSID, Sem, Sec)  CLASS(USN, SSID)  
--  SUBJECT(Subcode, Title, Sem, Credits)  
--  IAMARKS(USN, Subcode, SSID, Test1, Test2, Test3, FinalIA)  

create database college;
use college;

create table student(usn varchar(10),s_name varchar(10),phone int,s_gen varchar(1),primary key(usn));
create table semsec(ssid int,sem int,sec varchar(1),primary key (ssid));
create table class(usn varchar(10),ssid int,foreign key (usn) references student(usn),foreign key (ssid) references semsec(ssid));
create table sub(sub_code int,s_name varchar(10),sem int,credits int,primary key(sub_code));
create table IAmarks(usn varchar(10),sub_code int,ssid int,t1 int,t2 int,t3 int,fIA int,primary key(usn,sub_code),
foreign key (usn) references student(usn),foreign key (sub_code) references sub(sub_code));

insert into student values
("1","s1",1234,"M"),
("2","s2",1234,"M"),
("3","s3",1234,"M"),
("4","s4",1234,"M"),
("5","s5",1234,"F"),
("6","s6",1234,"F"),
("7","s7",1234,"F"),
("8","s8",1234,"F");

insert into semsec values
(1,4,"A"),
(2,4,"B"),
(3,4,"C");

insert into class values
(1,1),
(2,1),
(3,1),
(4,2),
(5,2),
(6,2),
(7,3),
(8,3);

insert into sub values
(1,"s1",4,5),
(2,"s2",4,3),
(3,"s3",4,1),
(4,"s4",4,5),
(5,"s5",4,4);

insert into IAmarks values
(1,1,1,40,40,40,50),
(1,2,1,40,36,40,47),
(1,3,1,35,40,37,48),
(4,1,2,28,35,40,50),
(4,2,2,37,37,38,40),
(4,3,2,39,40,39,45),
(8,1,3,40,40,40,49),
(8,2,3,40,34,39,50);

insert into IAmarks values
(1,4,1,40,40,40,50),
(1,5,1,40,36,40,47);


 -- 1. List all the student details studying in fourth semester ‘C’section. 
 select s.s_name,sc.sec from student s,semsec sc,class c
						where s.usn=c.usn
                        and sc.ssid=c.ssid
                        and sc.sec="C";
--  2. Compute the total number of male and female students in each semester and in each section. 
select count(*) from student;
 select sc.sec,count(s.usn) from student s,semsec sc,class c
			where s.usn=c.usn
            and sc.ssid=c.ssid
            group by sc.sec;
-- male
select sc.sec,count(s.usn) from student s,semsec sc,class c
			where s.usn=c.usn
            and sc.ssid=c.ssid
            and s.s_gen="M"
            group by sc.sec;

-- female
select sc.sec,count(s.usn) from student s,semsec sc,class c
			where s.usn=c.usn
            and sc.ssid=c.ssid
            and s.s_gen="F"
            group by sc.sec;

--  3. Create a view of Test1 marks of student USN ‘1BI15CS101’ in all subjects.  
create view Test1(Sub_name,marks) as select sb.s_name,m.t1 from IAmarks m,sub sb where m.usn="1" and m.sub_code=sb.sub_code;
select * from Test1;
-- drop view Test1;

--  4. Calculate the FinalIA (average of best two test marks) and update the corresponding table for all students.  
update IAmarks set fIA=(t1+t2+t3-least(t1,t2,t3))/4 ;
select * from IAmarks;
--  5. Categorize students based on the following criterion:  
-- 	If FinalIA = 17 to 20 then CAT = ‘Outstanding’  
--     If FinalIA = 12 to 16 then CAT = ‘Average’  
--     If FinalIA< 12 then CAT = ‘Weak’  

alter table IAmarks add CAT varchar(10);
update IAmarks  set CAT=
			case
				when fIA>=17 and fIA<=20 then "Outstandin"
                when fIA>=12 and fIA<17 then "average"
                when fIA<12 then "weak"
			end;
select * from IAmarks;
