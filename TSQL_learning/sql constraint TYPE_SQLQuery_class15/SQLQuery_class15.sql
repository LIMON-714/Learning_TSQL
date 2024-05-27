
use TSQL2012;

--part 1
-- type of constraints 
-- unique
create table student55 (
  id int unique,
  age int,
  s_name varchar (50)
);
select * from student55;

-- not null 
 create table student66 (
  id int not null,
  age int,
  s_name varchar (50)
);

-- & default
 create table student77 (
  id int not null ,
  age int,
  s_name varchar (50) default 'not value'
);
select * from student77;



-- check
 create table student88 (
  id int not null ,
   age int check(age >=20),
  s_name varchar (50)
);
select * from student88;


--key constraints
-- primary and foreign 
 create table student99 (
  id int primary key ,
   age int check(age >=20),
  s_name varchar (50)
);

-- after create table desite primary key 
alter table student99 
add primary key (id);


--again 
alter table student99 
ADD constraint pk_student99 primary key (id);

ALTER TABLE student99 
DROP PRIMARY KEY;

;







-- Creating the first table
CREATE TABLE students2023 (
    id INT NOT NULL,
    name VARCHAR(50),
    age INT
);

-- Creating the second table
CREATE TABLE students2024 (
    id INT NOT NULL,
    name VARCHAR(50),
    age INT
);

-- Inserting data into the first table
INSERT INTO students2023 (id, name, age) VALUES
(1, 'Alice', 23),
(2, 'Bob', 24),
(3, 'Charlie', 22);

-- Inserting data into the second table
INSERT INTO students2024 (id, name, age) VALUES
(2, 'Bob', 24),
(3, 'Charlie', 22),
(4, 'David', 25);

-- union 

-- Using UNION to combine the data from both tables
SELECT * FROM students2023
UNION 
SELECT * FROM students2024;

SELECT id, name, age FROM students2023
UNION all
SELECT id, name, age FROM students2024;


-- Using INTERSECT to get the common data from both tables
SELECT id, name, age FROM students2023
INTERSECT
SELECT id, name, age FROM students2024;







--part 2

-- some problems solving 

-- 2nd hight salary

SELECT TOP 1 *
FROM (
    SELECT TOP 2 *
    FROM salary
    ORDER BY Salary DESC
) AS TOL
ORDER BY Salary ASC;



-- another same
select* from emp2;

SELECT TOP 1 *
FROM (
    SELECT TOP 3 *
    FROM emp2 
    ORDER BY salary  DESC
) AS TOL
ORDER BY salary  ASC;



-- problem solving 2 calculate total salary every depertnent in desc order 

select emp2.dept, sum(salary)
from emp2
group by dept 
order by sum(salary) desc;



-- problem 3 
-- Creating the stu table
CREATE TABLE stu (
    s_id INT NOT NULL,
    name_s VARCHAR(50),
    dept VARCHAR(10),
    age INT
);

-- Inserting values into the stu table
INSERT INTO stu (s_id, name_s, dept, age) VALUES
(1, 'Alice', 'CSE', 22),
(2, 'Bob', 'EEE', 23),
(3, 'Charlie', 'EIE', 22),
(4, 'David', 'CSE', 24),
(5, 'Eve', 'EEE', 23),
(6, 'Frank', 'EIE', 24),
(7, 'Grace', 'CSE', 22),
(8, 'Hank', 'EEE', 25),
(9, 'Ivy', 'EIE', 23),
(10, 'Jack', 'CSE', 24);

-- Creating the result table
CREATE TABLE result (
    s_id INT NOT NULL,
    cgpa DECIMAL(3, 2)
);

-- Inserting values into the result table
INSERT INTO result (s_id, cgpa) VALUES
(1, 3.75),
(2, 3.80),
(3, 3.65),
(4, 3.90),
(5, 3.50),
(6, 3.85),
(7, 3.95),
(8, 3.60),
(9, 3.70),
(10, 3.55);

-- serial by result after join 2 table 
select stu.s_id,stu.name_s , result.cgpa
from stu
inner join 
result
on stu.s_id = result.s_id
order by s_id asc;

-- who get >3.80
select  stu.s_id,stu.name_s , r.cgpa
from stu
inner join
result as r
on stu.s_id = r.s_id
where r.cgpa >=3.80 ;

-- who is the 1st with cgpa
SELECT Top 1 stu.s_id, stu.name_s, stu.dept, stu.age, result.cgpa
FROM stu
JOIN 
result 
ON stu.s_id = result.s_id
ORDER BY result.cgpa DESC;


-- problem 4
-- Creating the stuADD table
CREATE TABLE stuADD (
    s_id INT NOT NULL,
    admit_date DATE
);

-- Inserting values into the stuADD table
INSERT INTO stuADD (s_id, admit_date) VALUES
(1, '2023-01-10'),
(2, '2023-01-11'),
(3, '2023-01-12'),
(4, '2023-01-13'),
(5, '2023-01-14'),
(6, '2023-01-15'),
(7, '2023-01-16'),
(8, '2023-01-17'),
(9, '2023-01-18'),
(10, '2023-01-19');


select stu.s_id, stu.name_s, stu.dept , stuADD.admit_date
from stu
inner join 
stuADD
on stu.s_id = stuADD.s_id
where stuADD.admit_date LIKE '2023-01-11';    --'%2023%'; or we also use ;that all 20233 date


--part 3
-- load adata ssis process

