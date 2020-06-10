-- AUTHOR(author-id: int, name: String, city: String, country: String)  
-- PUBLISHER(publisher-id: int, name: String, city: String, country: String) 
-- CATALOG(book-id: int, title: String, author-id: int, publisher-id: int, category-id:    int, year: int, price: int)  
-- CATEGORY(category-id: int, description: String)  ORDER-DETAILS(order-no: int, book-id: int, quantity: int) 

create database bookDealer;
use bookDealer;

create table author(
	a_id int,
    a_name varchar(10),
    a_city varchar(10),
    a_country varchar(10),
    primary key (a_id)
);
insert into author values
(1,"a1","bangalore","india"),
(2,"a2","bangalore","india"),
(3,"a3","bangalore","india"),
(4,"a4","chennai","india"),
(5,"a5","mumbai","india"),
(6,"a6","London","England");


create table publisher(
	p_id int,
	p_name varchar(10),
    p_city varchar(10),
    p_country varchar(10),
    primary key (p_id)
);
insert into publisher values
(1,"p1","bangalore","india"),
(2,"p2","bangalore","india"),
(3,"p3","bangalore","india"),
(4,"p4","chennai","india"),
(5,"p5","mumbai","india"),
(6,"p6","London","England");

create table catalog(
	b_id int,
    b_title varchar(10),
    a_id int,
    p_id int,
    cat_id int,
    b_year int,
    b_price int,
    primary key(b_id),
    foreign key (a_id) references author(a_id),
	foreign key (p_id) references publisher(p_id) 
);

insert into catalog values
(1,"b1",1,1,1,2020,1000),
(2,"b2",1,1,1,2020,2000),
(3,"b3",1,2,2,2020,3000),
(4,"b1",2,1,1,2020,5000),
(5,"b4",2,2,3,2020,6000),
(6,"b5",3,4,5,2020,4000);



create table catergory(
	cat_id int,
    cat_des varchar(10),
    primary key(cat_id)
);
insert into catergory values
(1,"horror"),(2,"Rom-com"),(3,"comedy"),(4,"thriller"),(5,"romance");

create table order_details(
	o_id int,
    b_id int,
    qty int,
    primary key(o_id),
    foreign key (b_id) references catalog(b_id)
);
insert into order_details values
(1,1,2),
(2,2,3),
(3,2,3),
(4,3,4),
(5,4,4);


-- iii) Give the details of the authors who have 2 or more books in the catalog and the price of the books in the catalog and the year of publication is after 2000. 
select * from author a,catalog c 
			where a.a_id=c.a_id
            and a.a_id in(
				select a1.a_id from author a1,catalog c1 
								where a1.a_id=c1.a_id
                                group by a1.a_id
                                having count(c1.b_id)>=2
            );

-- iv) Find the author of the book which has maximum sales. 

select * from order_details o,catalog c
		where o.b_id=c.b_id
        and o.qty=(select max(qty) from order_details);
                

select * from order_details;
						
										
-- v) Demonstrate how you increase the price of books published by a specific publisher by 10%. 
select * from catalog;			
update  catalog set b_price=b_price+.1*b_price where p_id=2;
select * from catalog;			