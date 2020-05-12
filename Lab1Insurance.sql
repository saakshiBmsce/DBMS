create database db;
use db;
create table Person(
    driver_id varchar(20),
    driver_name varchar(20),
    address varchar(20),
    primary key(driver_id)
    
);
insert into person values('id1','Person1','address 1'),
						('id2','Person2','address 2'),
                        ('id3','Person3','address 3'),
                        ('id4','Person4','address 4');
create table Car(
    reg_no int(3),
    car_model varchar(10),
    car_year int(4),
    primary key(reg_no)
);
insert into car values(001,'model1',2000),
					(002,'model1',2002),
                    (003,'model1',2003),
                    (004,'model4',2004);
create table accident(
    report_no int(5),
    acc_date date,
    acc_location varchar(20),
    primary key(report_no)
    
);
insert into accident values(001,'2010-01-01','loc1'),
						   (002,'2010-02-02','loc2'),
                           (003,'2010-03-03','loc3'),
                           (004,'2010-04-04','loc4');

create table owns(
    driver_id varchar(10),
    reg_no int(3),
    primary key(driver_id,reg_no),
    foreign key(driver_id) references person(driver_id),
    foreign key(reg_no) references car(reg_no)
);
insert into owns values('id1',001),
						('id2',002),
                        ('id3',003),
                        ('id4',004);
						
create table participated(
    driver_id varchar(10),
    reg_no int(3),
    report_no int(5),
    damage_amt real(6,2),
    primary key(driver_id,reg_no),
    foreign key(driver_id,reg_no) references owns(driver_id,reg_no) on delete cascade,
    foreign key(report_no) references accident(report_no) on delete cascade
);
insert into participated values('id1',001,1,1000),('id2',002,2,2000),('id3',003,3,3000),('id4',004,4,4000);
-- update participated set damage_amt=2500 where reg_no=102 and driver_id='1bm088';
-- select * from accident where extract(year from acc_date)=2010;
-- select * from Accident A,participated P,Car C
--     where C.CAR_MODEL='model1'
--     and   C.reg_no=P.reg_no
--     and   P.report_no=A.report_no;
-- select distinct count(*) from participated p, car c where p.reg_no=c.reg_no and c.car_model="model1";


select * from person;
select * from car;
select * from accident;
select * from owns;
select * from PARTICIPATED;