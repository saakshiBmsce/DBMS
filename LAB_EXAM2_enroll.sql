-- STUDENT (regno: String, name: String, major: String, bdate: date)  
-- COURSE (course #: int, cname: String, dept: String)  
-- ENROLL (regno: String, cname: String, sem: int, marks: int)  
-- BOOK_ADOPTION (course #: int, sem: int, book-ISBN: int)  
-- TEXT(book-ISBN:int, book-title:String, publisher:String, author:String) 

-- create database enrollment;
-- use enrollment;

-- drop table book_adop;
-- drop table enrol;
-- drop table course;
-- drop table student;
-- drop table text;

create table student(
	s_id varchar(10),
    s_name varchar(10),
    s_major varchar(10),
    s_bdate date,
    primary key(s_id)
);
insert into student values
("1","s1","m1","2000/1/1"),
("2","s2","m1","2001/2/2"),
("3","s3","m1","2001/3/3"),
("4","s4","m2","2002/4/4"),
("5","s5","m2","2002/5/5"),
("6","s6","m3","2002/6/6");

create table course (
	c_id int,
    c_name varchar(10),
    c_dep varchar(10),
    primary key(c_id)
);
insert into course values
(1,"c1","d1"),
(2,"c2","d1"),
(3,"c3","d1"),
(4,"c4","d2"),
(5,"c5","d3");

create table enrol(
	s_id varchar(10),
    c_id int,
    sem int,
    marks int,
    primary key(s_id,c_id),
    foreign key (s_id) references student(s_id),
    foreign key (c_id) references course(c_id)
);
insert into enrol values
("1",1,4,100),
("2",1,4,90),
("3",1,4,95),
("1",2,3,96),
("2",2,6,60),
("4",1,4,95),
("5",2,3,96),
("6",2,6,60);

create table text_book(
	b_id int,
    b_name varchar(10),
    b_pub varchar(10),
    b_author varchar(10),
    primary key(b_id)
);
insert into text_book values
(1,"b1","p1","a1"),
(2,"b2","p1","a1"),
(3,"b3","p2","a1"),
(4,"b4","p3","a3"),
(5,"b5","p2","a2"),
(6,"b6","p4","a4");


create table book_adop(
	c_id int,
    sem int,
    b_id int,
    foreign key (c_id) references course(c_id),
    foreign key (b_id) references text_book(b_id)
);

insert into book_adop values
(1,4,1),
(1,4,2),
(2,6,3),
(2,3,4),
(2,3,5),
(2,6,6);

insert into book_adop values
(5,4,1);




-- iii) Demonstrate how you add a new text book to the database and make this book be adopted by some department. 

-- iv) Produce a list of text books (include Course #, Book-ISBN, Book-title) in the alphabetical order for courses offered by the ‘CS’ department that use more than two books.
select c.c_id,b.b_id,b.b_name 
from course c,text_book b,book_adop ba
where c.c_id=ba.c_id
and b.b_id=ba.b_id
and c.c_dep="d1"
and c.c_id in(select ba1.c_id from book_adop ba1
				group by ba1.c_id
                having count(ba1.b_id)>=2)
order by (c.c_name);


-- v) List any department that has all its adopted books published by a specific publisher. 
select c.c_dep from course c
where not exists (select * from course c1,book_adop ba1 ,text_book b1
									where c1.c_id=ba1.b_id
                                    and c1.c_dep=c.c_dep
                                    and ba1.b_id=b1.b_id
                                    and b1.b_pub <>"p2"
                                    ) 
