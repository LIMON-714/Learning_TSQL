--part3
-- unique constraint 
--part4
--primary key constraint
-- foreign keyconstraint
--part4
--check constraint
--default constraint

use TSQL2012;

--unique column create 
CREATE TABLE table_test (
    EmpName VARCHAR(50),
    EmpAddress VARCHAR(50),
    CONSTRAINT UK_EmpName UNIQUE (EmpName)
);

-- alter table CONSTRAINT
CREATE TABLE table_test2 (
    empName VARCHAR(50),
    empAddress VARCHAR(50),
 )
 alter table table_test2 add
 CONSTRAINT UK_empName2 UNIQUE (empName);

-- primary key constraint create 
CREATE TABLE table_test3 (
    empName VARCHAR(50),
    empAddress VARCHAR(50),
	CONSTRAINT pk_empname primary key (empName)
 );

 -- do make primary key if here any duplicate key 
 create table table_test4(
 testId int,
 empNmae varchar(50),
 enpAddress varchar(50),
 CONSTRAINT pk_empname4 primary key (testId)
 );

 --convert primary key ruls 
  create table table_test5(
 test5Id int not null,
 empNmae varchar(50),
 enpAddress varchar(50),
 )
 alter table table_test5 add
 CONSTRAINT pk_test5ID primary key (test5Id);

 -- remove t sql primary key 
ALTER TABLE dob.table_test5
DROP CONSTRAINT pk_test5ID;


--part5

-- table primary key and forign key make diagram 
-- primary key order_id in order table 
-- forign key in order_id in production table 
-



--part 6 
-- i also watch udamy ssis part 1 tutorial video section 13 to 16 and precties this accurading to the video