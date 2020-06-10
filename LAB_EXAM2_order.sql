-- create database orderprocessing;
-- use orderprocessing;
drop table shipment;
drop table warehouse;
drop table order_item;
drop table item;
drop table Corder;
drop table cust;





create table cust(
 c_id int,
 c_name varchar(10),
 c_city varchar(10),
 primary key(c_id)
);
insert into cust values
(1,"c1","bangalore"),
(2,"c2","bangalore"),
(3,"c3","chennai"),
(4,"c4","chennai"),
(5,"c5","mumbai"),
(6,"c6","mumbai");


create table Corder(
	o_id int,
    o_amt float,
    o_date date,
    o_cid int,
    primary key(o_id),
    foreign key (o_cid) references cust(c_id)
);

insert into Corder values
(1,1000,"2020/1/1",1),
(2,2000,"2020/2/2",2),
(3,3000,"2020/3/3",3),
(4,4000,"2020/4/4",4),
(5,5000,"2020/5/5",5),
(6,6000,"2020/6/6",6);

insert into Corder values
(7,3000,"2020/1/1",1),
(8,5000,"2020/2/2",2),
(9,7000,"2020/3/3",3);

create table item(
	i_id int,
	i_unitPrice int,
    primary key(i_id)
);

insert into item values
(1,10),(2,20),(3,30),(4,40),(5,50),(6,60);

create table order_item(
	i_id int,
    o_id int,
    num int,
  --   primary key(i_id,o_id),
    foreign key (o_id) references Corder(o_cid),
    foreign key (i_id) references item(i_id) 
);

insert into order_item values
(1,1,10),
(2,2,20),
(3,3,30),
(1,2,20),
(4,4,40),
(5,5,50);

create table warehouse(
	w_id int,
    w_city varchar(10),
    primary key(w_id)
);

insert into warehouse values
(1,"bangalore"),
(2,"bangalore"),
(3,"bangalore"),
(4,"chennai"),
(5,"chennai"),
(6,"mumbai");

create table shipment(
	o_id int,
    w_id int,
    s_date date,
    primary key(o_id,w_id),
    foreign key (o_id) references Corder(o_id),
    foreign key (w_id) references warehouse(w_id)
); 

insert into shipment values
(1,1,"2020/1/1"),
(2,2,"2020/2/2"),
(3,3,"2020/3/3"),
(4,4,"2020/4/4"),
(5,5,"2020/5/5");

insert into shipment values
(1,2,"2020/1/1"),
(1,3,"2020/2/2");

insert into shipment values
(2,1,"2020/1/1"),
(2,3,"2020/2/2");


-- CUSTOMER (CUST #: int, cname: String, city: String) 
-- ORDER (order #: int, odate: date, cust #: int, ord-Amt: int) 
-- ITEM (item #: int, unit-price: int) 
-- ORDER-ITEM (order #: int, item #: int, qty: int) 
-- WAREHOUSE (warehouse #: int, city: String) 
-- SHIPMENT (order #: int, warehouse #: int, ship-date: date) 



-- queries

-- iii) Produce a listing: CUSTNAME, #oforders, AVG_ORDER_AMT, where the middle column is the total numbers of orders by the customer and the last column is the average order amount 
-- for that customer. 
select  c.c_name,count(o.o_id),avg(o.o_amt) 
from cust c, Corder o
where c.c_id=o.o_cid
group by c.c_id;

-- iv) List the order# for orders that were shipped from all warehouses that the company has in a specific city. 
select o.o_id from Corder o 
where not exists
(select w.w_id from warehouse w 
				where w.w_city="bangalore"
                and not exists(
					select * from shipment s
                    where s.w_id=w.w_id
                    and s.o_id=o.o_id
                ));

-- v) Demonstrate how you delete item# 10 from the ITEM table and make that field null in the ORDER_ITEM table. 
ALTER TABLE ORDER_ITEM ADD CONSTRAINT FOREIGN KEY(i_id) REFERENCES ITEM(i_id) ON DELETE SET NULL;
select * from order_item;
delete from order_item where o_id=1;
select * from order_item;