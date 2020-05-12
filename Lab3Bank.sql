create database Bank1;
use Bank1;
create table branch(
branch_name varchar(20),
branch_city varchar(20),
assets int,
primary key(branch_name)
);
create table accounts(
account_no int,
branch_name varchar(20),
balance real,
primary key(account_no),
foreign key(branch_name) references branch(branch_name)
);

create table depositor(
customer_name varchar(20),
customer_street varchar(20),
customer_city varchar(20),
primary key(customer_name)
);
create table Loan(
loan_number int,
branch_name varchar(20),
amount real,
primary key(loan_number),
foreign key(branch_name) references branch(branch_name)
);

create table borrower(
customer_name varchar(20),
loan_number int,
foreign key(customer_name) references depositor(customer_name),
foreign key(loan_number) references Loan(loan_number)
);
create table customer(
customer_name varchar(20),
account_no int,
foreign key(customer_name) references depositor(customer_name),
foreign key(account_no) references accounts(account_no)
);
insert into branch values('branch_name12','branch_city1',100000),
('branch_name22','branch_city2',200000),
('branch_name32','branch_city3',300000);
select * from branch;
insert into accounts values
(11111,'branch_name12',111),
(22222,'branch_name12',222),
(33333,'branch_name22',333),
(44444,'branch_name22',444),
(55555,'branch_name32',555),
(66666,'branch_name32',666);
insert into accounts values
(11112,'branch_name12',111),
(11113,'branch_name12',111)
;
insert into accounts values
(77777,'branch_name11',111);
select * from accounts;
insert into depositor values
('cust1','street1','city1'),
('cust2','street2','city2'),
('cust3','street3','city3'),
('cust4','street4','city4'),
('cust5','street5','city5');
select * from depositor;
insert into Loan values
(11,'branch_name12',120000),
(12,'branch_name12',120000),
(21,'branch_name22',220000),
(22,'branch_name22',220000),
(31,'branch_name32',320000),
(32,'branch_name32',320000);
select * from loan;
insert into borrower values
('cust1',11),
('cust2',12),
('cust3',21),
('cust4',22),
('cust5',31);
select * from borrower;
select * from depositor ;
insert into customer values
('cust1',11111),
('cust2',22222),
('cust3',33333),
('cust4',44444),
('cust5',55555);
insert into customer values
('cust1',77777);
insert into customer values
('cust1',11112),
('cust1',11113);
select * from customer;
-- select (c.customer_name) from customer c,Accounts a
-- where a.account_no=c.account_no and a.branch_name= 'branch_name12' group by c.customer_name having count(*)>=2;
-- select (c.customer_name) from customer c,Accounts a,branch b
-- where a.account_no=c.account_no and a.branch_city= 'branch_city1' 

-- customers having atleast 2 accounts at main branch
select * from customer c,Accounts a where c.account_no=a.account_no and  a.branch_name='branch_name12';

-- customer who have accounts at all branches at a city
select customer_name ,account_no from customer c
where	 not exists(
					select branch_name from branch 
                    where branch_city=' branch_city1'
						 and not exists (
											select account_no from Accounts where account_no=c.account_no
										)
				);

-- delete all accounts located at specific city
