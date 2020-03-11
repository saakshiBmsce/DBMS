create database db;
use db;
create table author(
	author_id int,
    a_name varchar(10),
    city varchar(10),
    country varchar(10),
    primary key (author_id)
);
insert into author values(1,'aname1','city1','country1'),
						(2,'aname2','city2','country2'),
                        (3,'aname3','city3','country3'),
                        (4,'aname4','city4','country4');

create table publisher(
	publisher_id int,
    p_name varchar(10),
    city varchar(10),
    country varchar(10),
    primary key (publisher_id)
);
insert into publisher values(1,'pname1','city1','country1'),
						(2,'pname2','city2','country2'),
                        (3,'pname3','city3','country3'),
                        (4,'pname4','city4','country4');
 create table category(
	category_id int,
    descr varchar(10),
    primary key(categoy_id)
 );                 
 
 insert into category values(1,'cat1'),(2,'cat2'),(3,'cat3');
 
 create table catalog(
	Book_id int,
    title varchar(10),
    b_year int,
    price int,
    publisher_id int,
    category_id int,
    author_id int,
    primary key(Book_id),
    foreign key(publisher_id) references publisher(publisher_id),
    foreign key(category_id) references category(category_id),
    foreign key(author_id) references author(author_id)
 );
 insert into catalog values
 (1,'book1',2000,1000,1,1,1),
  (2,'book2',2000,1000,1,1,1),
  (3,'book3',2000,1000,2,1,1)
(,'book1',2000,1000,1,1,1)
