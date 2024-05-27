-- all detailse for joine work
use TSQL2012;

DROP TABLE IF EXISTS Emoloyeees;


create table Emoloyeees(
	emp_id int primary key,
	name_emp varchar (50) null
);

insert into Emoloyeees( emp_id , name_emp)
values ( 101, 'rahim'),
(102, 'dnash'),
(105,'hamim'),
(107, 'rahim khan'),
(111, 'firoz rahman');

create table salary(
 emp_id int,
 salary varchar (20) null
);


insert into salary(emp_id , salary)
values (101, '20000'),
(102, '50337'),
(103,'44443'),
(104, '3322556'),
(107, '332416'),
(111, '10944675');


select Emoloyeees.emp_id, Emoloyeees.name_emp, salary.salary from
Emoloyeees 
inner join 
salary
on Emoloyeees.emp_id = salary.emp_id; 


select Emoloyeees.emp_id, Emoloyeees.name_emp, salary.salary from
Emoloyeees 
left join 
salary
on Emoloyeees.emp_id = salary.emp_id; 

-- all detailse for joine work
use TSQL2012;

DROP TABLE IF EXISTS Emoloyeees;


create table Emoloyeees(
	emp_id int primary key,
	name_emp varchar (50) null
);

insert into Emoloyeees( emp_id , name_emp)
values ( 101, 'rahim'),
(102, 'dnash'),
(105,'hamim'),
(107, 'rahim khan'),
(111, 'firoz rahman');

ALTER TABLE Emoloyeees
ADD dept VARCHAR(50) NULL;

UPDATE Emoloyeees
SET dept = CASE
    WHEN emp_id = 101 THEN 'IT'
    WHEN emp_id = 102 THEN 'HR'
    WHEN emp_id = 105 THEN 'Finance'
    WHEN emp_id = 107 THEN 'Marketing'
    WHEN emp_id = 111 THEN 'Sales'
    ELSE NULL
END;

create table salary(
 emp_id int,
 salary varchar (20) null
);


insert into salary(emp_id , salary)
values (101, '20000'),
(102, '50337'),
(103,'44443'),
(104, '3322556'),
(107, '332416'),
(111, '10944675');


ALTER TABLE salary
ADD dept VARCHAR(50) NULL;

UPDATE salary
SET dept = CASE
    WHEN emp_id = 101 THEN 'IT'
    WHEN emp_id = 102 THEN 'HR'
	WHEN emp_id = 103 THEN 'Legal'
    WHEN emp_id = 105 THEN 'Management'
    WHEN emp_id = 107 THEN 'Marketing'
    WHEN emp_id = 111 THEN 'Sales'
    ELSE NULL
END;

select Emoloyeees.emp_id, Emoloyeees.name_emp, salary.salary from
Emoloyeees 
inner join 
salary
on Emoloyeees.emp_id = salary.emp_id; 

select Emoloyeees.emp_id, Emoloyeees.name_emp, salary.salary from
Emoloyeees 
left join 
salary
on Emoloyeees.emp_id = salary.emp_id; 



select Emoloyeees.emp_id, Emoloyeees.name_emp, salary.salary from
Emoloyeees 
right join 
salary
on Emoloyeees.emp_id = salary.emp_id; 




-- outer join 

-- natural show extea all data  
select Emoloyeees.emp_id,Emoloyeees.name_emp, Emoloyeees.dept, salary.salary
from 
Emoloyeees
full outer join 
salary
on Emoloyeees.emp_id = salary.emp_id;


-- left outer join return alll left table 

select Emoloyeees.emp_id,Emoloyeees.name_emp, Emoloyeees.dept, salary.salary
from 
Emoloyeees
left outer join 
salary
on Emoloyeees.emp_id = salary.emp_id;

-- right outer table return alll right table 
select Emoloyeees.emp_id,Emoloyeees.name_emp, Emoloyeees.dept, salary.salary
from 
Emoloyeees
right outer join 
salary
on Emoloyeees.emp_id = salary.emp_id;




select* from salary;

-- group by /order by 

select Emoloyeees.dept , count(*)
from Emoloyeees
group by dept;


select salary , max(salary) as new_value
from salary
group by salary
order by max(salary) asc;




CREATE TABLE teacher (
    teacher_name VARCHAR(100),
    department VARCHAR(100),
    salary DECIMAL(10, 2),
    age INT
);

INSERT INTO teacher (teacher_name, department, salary, age) VALUES ('Alice Johnson', 'Mathematics', 50000.00, 40);
INSERT INTO teacher (teacher_name, department, salary, age) VALUES ('Bob Smith', 'Physics', 55000.00, 45);
INSERT INTO teacher (teacher_name, department, salary, age) VALUES ('Catherine Davis', 'Chemistry', 52000.00, 38);
INSERT INTO teacher (teacher_name, department, salary, age) VALUES ('David White', 'Biology', 51000.00, 42);
INSERT INTO teacher (teacher_name, department, salary, age) VALUES ('Eva Brown', 'English', 53000.00, 36);
INSERT INTO teacher (teacher_name, department, salary, age) VALUES ('Frank Green', 'History', 48000.00, 50);
INSERT INTO teacher (teacher_name, department, salary, age) VALUES ('Grace Wilson', 'Geography', 49500.00, 37);
INSERT INTO teacher (teacher_name, department, salary, age) VALUES ('Hannah Lewis', 'Computer Science', 60000.00, 34);
INSERT INTO teacher (teacher_name, department, salary, age) VALUES ('Ian Walker', 'Physical Education', 47000.00, 43);
INSERT INTO teacher (teacher_name, department, salary, age) VALUES ('Jane King', 'Art', 52000.00, 39);



select teacher.department, sum(salary)
from teacher
group by department
order by sum(salary) asc;

select teacher.department , count(*)
from teacher
group by department;

-- having clause 

select dept , count(*) as new
from Emoloyeees
group by dept
having count(*)>=2
order by count(*);



-- sub querry 
-- it also used  sIUD and where, = <> , between and so on

SELECT name_emp 
FROM Emoloyeees 
WHERE emp_id = (SELECT emp_id FROM salary WHERE salary = '10944675');


SELECT name_emp
FROM Emoloyeees
WHERE dept = (SELECT dept FROM salary WHERE dept = 'hr');
