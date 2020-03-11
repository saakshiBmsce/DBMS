create database b1;
use b1;
create table customer
(
	cust_name varchar(20),
    cust_id int,
    cust_city varchar(10),
    primary key(cust_id)
);
insert into customer values('cust1',001,'city1');
insert into customer values('cust2',002,'city1');
insert into customer values('cust3',003,'city2');
insert into customer values('cust4',004,'city2');
insert into customer values('cust5',005,'city3');
insert into customer values('cust6',006,'city3');
drop table cust_order;
create table cust_order
(
	order_no int,
    order_amt decimal,
    order_date date,
    cust_id int,
    primary key (order_no),
    foreign key(cust_id) references customer(cust_id)
);
insert into cust_order values(001,1000,01/01/2020,001);
insert into cust_order values(007,1000,01/01/2020,001);
insert into cust_order values(002,2000,02/01/2020,002);
insert into cust_order values(003,3000,03/01/2020,003);
insert into cust_order values(004,4000,04/01/2020,004);
insert into cust_order values(005,5000,05/01/2020,005);
insert into cust_order values(006,6000,05/01/2020,006);

update cust_order set order_date='2020/01/05' where cust_id=6;

select * from cust_order;
create table item
(
	item_no int,
    unit_price decimal,
    primary key(item_no)
);
insert into item values(001,100);
insert into item values(002,200);
insert into item values(003,300);
insert into item values(004,400);
insert into item values(005,500);
create table order_item
(
	order_no int,
    item_no int,
    quantity int,
    foreign key(order_no) references cust_order(order_no),
    foreign key(item_no) references item(item_no)
);
insert into order_item values(001,001,1);
insert into order_item values(002,002,2);
insert into order_item values(003,003,3);
insert into order_item values(004,004,4);
insert into order_item values(005,005,5);
select * from order_item;
create table warehouse
(
	warehouse_no int,
    city varchar(10),
    primary key(warehouse_no)
);
insert into warehouse values(001,'city1');
insert into warehouse values(002,'city1');
insert into warehouse values(003,'city2');
insert into warehouse values(004,'city2');
insert into warehouse values(005,'city3');
insert into warehouse values(006,'city3');
select * from warehouse;
create table shipment
(
	order_no int,
    shipment_dat date,
    warehouse_no int,
    foreign key(warehouse_no) references warehouse(warehouse_no),
    foreign key(order_no) references cust_order(order_no)
);
insert into shipment values(001,01/01/2020,001);
insert into shipment values(002,01/01/2020,002);
insert into shipment values(003,02/01/2020,003);
insert into shipment values(004,02/01/2020,004);
insert into shipment values(005,03/01/2020,005);
insert into shipment values(006,03/01/2020,006);
update shipment set shipment_dat='2020/01/03' where order_no=6;
select * from shipment;

update order_item set item_no=NULL where item_no=5;
delete from item where item_no=5;

select co.order_no,w.city from shipment s,cust_order co,warehouse w 
where w.city='city1' and w.warehouse_no=s.warehouse_no and s.order_no=co.order_no;


select c.cust_name,count(co.order_no) from customer c,cust_order co where c.cust_id=co.cust_id; 