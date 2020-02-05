create table Person(
    driver_id varchar2(20),
    driver_name varchar2(20),
    address varchar2(20),
    primary key(driver_id)
    
);

create table Car(
    reg_no number(3),
    car_model varchar2(10),
    car_year number(4),
    primary key(reg_no)
);

create table accident(
    report_no number(5),
    acc_date date,
    acc_location varchar2(20),
    primary key(report_no)
    
);

create table owns(
    driver_id varchar2(10),
    reg_no number(3),
    primary key(driver_id,reg_no),
    foreign key(driver_id) references person(driver_id),
    foreign key(reg_no) references car(reg_no)
);

create table participated(
    driver_id varchar2(10),
    reg_no number(3),
    report_no number(5),
    damage_amt number(6,2),
    primary key(driver_id,reg_no),
    foreign key(driver_id,reg_no) references owns(driver_id,reg_no) on delete cascade,
    foreign key(report_no) references accident(report_no) on delete cascade
);
insert into participated values('&driver_id',&reg_no,'&report_no',&damage_amt);
update participated set damage_amt=2500 where reg_no=102 and driver_id='1bm088';
select * from accident where acc_date like '__-__-02';
select * from Accident A,participated P,Car C
    where C.CAR_MODEL='model1'
    and   C.reg_no=P.reg_no
    and   P.report_no=A.report_no;
select * from person;
select * from car;
select * from accident;
select * from owns;
select * from PARTICIPATED;
