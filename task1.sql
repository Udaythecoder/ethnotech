create database training;
create table sales(id int primary key,name varchar(7),age int,product_name varchar(10),price int);
insert into sales values(1,"uday",21,"mobile",25000),(2,"vicky",20,"laptop",49000),(3,"vignesh",20,"laptop",60000),(4,"santhu",19,"mobile",19000);
select* from sales;
alter table sales add region varchar(6);
update sales set region="a" where id=1;
update sales set region="b" where id=2;
update sales set region="c" where id=3;
update sales set region="d" where id=4;
rename table sales to personal;
select* from personal;
commit;
select* from personal;
DELETE FROM personal WHERE id = 101;
DELETE FROM personal WHERE id = 102;
DELETE FROM personal WHERE id = 103;
DELETE FROM personal WHERE id = 104;
select* from personal;
create table personal1(id int primary key,name varchar(7));
insert into personal1 values(101,"u"),(102,"d");
create table personal2(pid int,name varchar(7),id int,foreign key(id) references personal1(id));
insert into personal2 values(103,"a",101),(104,"y",102);
select* from personal2;
alter table personal add voter_id  int NULL;
desc personal;

create table employee
(frst_name TEXT,
last_name TEXT,
gender varchar(1));

alter table employee add age int;
alter table employee add salary int;
alter table employee drop column gender;
alter table employee rename column salary to emp_salary;

desc employee;

alter table employees rename to employee;

SET SQL_SAFE_UPDATES =0;

desc employee;

insert into employee values('u','m',21,20000),('d','a',20,23000),('a','l',19,19000),('y','a',20,22000);

select* from employee;

alter table employee add gender varchar(1);

update employee set gender='M' where frst_name='u';
update employee set gender='M' where frst_name='d';
update employee set gender='M' where frst_name='a';
update employee set gender='M' where frst_name='y';

insert into employee values('k','y',18,20000,'M');
#delete
delete from employee where frst_name='k';
commit;
 
#create sample dataset
create table emp_info(first varchar(10),last varchar(8),id int primary key,age int,city varchar(6),state varchar(8)); 
#insert details
insert into emp_info values('uday','kiran',1001,21,'mpl','ap');
insert into emp_info values('bana','vamsee',1002,20,'atp','ap'),('royal','nandha',1003,21,'atp','ap'),('golla','santhu',1004,18,'mpl','ap'),('verriboina','vignesh',1005,21,'kdp','ap'); 
desc emp_info;

select first,last from emp_info where id=1003;
select* from emp_info;
update emp_info set city='bgl' where first='golla';
SET SQL_SAFE_UPDATES =0;

select city from emp_info;
select count(*) from emp_info;
alter table emp_info add gender varchar(1);

update emp_info set gender='m' where id=1001;
update emp_info set gender='m' where id=1002;
update emp_info set gender='m' where id=1003;
update emp_info set gender='m' where id=1004;
update emp_info set gender='m' where id=1005;

select gender,age from emp_info;
select* from emp_info;
alter table emp_info add salary int;
update emp_info set salary=50000 where gender='m';
update emp_info set salary=70000 where id=1004;
update emp_info set salary=68000 where id=1002;
update emp_info set salary=48000 where id=1003;

select count(*) from emp_info where salary<68000;
select* from emp_info where salary>68000 and city='atp';
select* from emp_info where salary>68000 or city='atp';

select id,age,first from emp_info where city like '%l';
select id,age,first from emp_info where city like '%g%';
select id,age,first from emp_info where city like '%mpl%';

select first,last,id,age from emp_info where salary between 50000 and 70000;
select *from emp_info where city in ('atp','bgl');
drop table emp_old1;
drop table emp_new;

#sample work
create table emp_new1(first_name text,last_name text,age int,designation text,salary int);
insert into emp_new1 values('jonie','weber',40,'secretary',30000),('bob','williams',37,'programmer',38000),
('dirk','smith',40,'secretary',43000),('bana','vamsee',40,'programmerII',34000),
('golla','santhosh',20,'programmer',25000),('royal','nandha',19,'programmerII',29000);

update emp_new1 set designation='admin_asst' where designation='secretary';
update emp_new1 set designation='programerIII' where designation='programmerII';
update emp_new1 set designation='programeII' where designation='programmer';

select* from emp_new1;
update emp_new1 set salary=salary+3500 where salary<30000;
update emp_new1 set salary=salary+4500 where salary>33500;


update emp_new1 set last_name='williams' where first_name='jonie';
update emp_new1 set first_name='weber' where first_name='jonie';
select* from emp_new1;