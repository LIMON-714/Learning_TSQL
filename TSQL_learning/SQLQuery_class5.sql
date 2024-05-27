use TSQL2012;


create table TestTable(
	id int primary key
	);


--alter table 
alter table TestTable add Cus_name varchar(50);
select* from TestTable;

ALTER TABLE TestTable
ALTER COLUMN Cus_name VARCHAR; 


INSERT INTO TestTable (id, Cus_name)
VALUES (101, 'modon');
INSERT INTO TestTable (id, Cus_name)
VALUES (102, 'mirzafor');
INSERT INTO TestTable (id, Cus_name)
VALUES (103, 'labib');

update TestTable
set Cus_name = 'modon mohon'
where Cus_name = 'modon';

select* from TestTable
order by Cus_name;



-- data transfer another table 
select * into student from TestTable;
select * from student;

--mofify

alter table student add DOB date;
update student
set DOB ='19981201'
where id = 101;

update student
set DOB ='19881001'
where id = 102;
update student
set DOB ='19990201'
where id = 103;

--rename table 
exec sp_rename student , Old_student; 

select* from Old_student;

--again
exec sp_rename old_student, student;
select* from student;



-- transfer only table name column  not data 

select * into TBstudent from student where 1=2; -- is not possiable condition 1=2 thats why data not gone. 
select * from TBstudent;

-- add new column here
alter table Tbstudent add FatherName varchar(50);

select * from TBstudent;

insert into TBstudent (id ,Cus_name,DOB,FatherName)
values
(1011,'manik mia','19880127','harun mia'),
(1012,'nahid mia','19800127','kabir molla'),
(1013,'bisa khan','19811122','habib mia'),
(1014,'babu ','19800102','kamal');


-- column rename 
exec sp_rename 'TBstudent.FatherName', 'Father_Name','column';


-- how can we transfer schema to another schema 
create schema sir authorization dbo;
alter schema sir transfer dbo.TestTable;

select * from TestTable;

alter schema dbo transfer sir.TestTable;

-- drop  schema here 
drop schema sir;



-- create another table value autu increment here
create table emp(
id int identity(1,1) not null
);

alter table emp 
add c_name varchar(50);

insert into emp( c_name)
values
('hasan'),
('habib'),
('hamim');

update emp
set c_name= 'iallam'
where id = 1;

select* from emp;


--computed columns calculated 
create table orders
(
	oeder_id int identity(1,1) not null,
	unitprice  int  default(0) not null,
	quantity int default(0) not null,
	total_price as unitprice*quantity
);


select* from orders;
 insert into  orders ( unitprice, quantity) 
 values (100, 50);

















