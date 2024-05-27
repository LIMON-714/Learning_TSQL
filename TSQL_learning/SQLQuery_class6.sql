
use TSQL2012;

-- unique constraints
-- primary key constrants
-- foreign key constrants
-- check constraints
-- default constraints

create table test(
	
	id int primary key not null,
	emp_name varchar(50),
	emp_address varchar (50)
	constraint uK_emp_name unique(emp_name)
);


create table test2(
	emp_name varchar(50),
	emp_address varchar(50)
);
alter table test2 add
constraint uk_empname2 unique(emp_name);


create table test3(
	
emp_name varchar(50),
	emp_address varchar (50)
	constraint pK_emp_name primary key(emp_name)
);


create table test4(
	
	id int,
	emp_name varchar(50),
	emp_address varchar (50)
	constraint pK_emp_name4 primary key(id)
);

create table test5(
	
	id5Table int,
	emp_name varchar(50),
	emp_address varchar (50)
	constraint pK_emp_name5 primary key(id5Table)
);


select * from test5;
-- drop constraint here 
alter table dbo.test5
drop constraint pK_emp_name5;



-- open diagram to need the code if any problems
EXEC sp_changedbowner 'sa';

-- drop usless table

drop table dbo.test;
drop table dbo.test2;
drop table dbo.test3;
drop table dbo.test4;
drop table dbo.test5;



-- ctrate diagram
CREATE TABLE produ (
    pro_id BIGINT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    pro_date DATE,
    pro_itemName VARCHAR(50),
    unit_price FLOAT,
    quantity FLOAT,
    total FLOAT,
    remark VARCHAR(50) NOT NULL,
    order_id BIGINT
);

-- Calculate total based on unit price and quantity
UPDATE produ
SET total = unit_price * quantity;

--value 


select* from dbo.produ;



CREATE TABLE oRderpro (
    OrderID BIGINT NOT NULL,
    c_name VARCHAR(50) NOT NULL,
    pro_name VARCHAR(50) NOT NULL,
    orderDate DATE,
    pro_id BIGINT NOT NULL,  -- Foreign key column
    FOREIGN KEY (pro_id) REFERENCES produ(pro_id) 
);





-- Insert data into the 'produ' table
INSERT INTO produ (pro_date, pro_itemName, unit_price, quantity, total, remark, order_id)
VALUES 
    ('2024-03-30', 'Item 1', 10.50, 5, 52.50, 'Remark 1', 1001),
    ('2024-03-31', 'Item 2', 15.75, 3, 47.25, 'Remark 2', 1002),
    ('2024-04-01', 'Item 3', 20.00, 2, 40.00, 'Remark 3', 1003);

-- Insert data into the 'oRderpro' table
INSERT INTO oRderpro (OrderID, c_name, pro_name, orderDate, pro_id)
VALUES
    (1001, 'Customer A', 'Product 1', '2024-03-30', 1),  -- Assuming pro_id 1 corresponds to the first entry in 'produ'
    (1002, 'Customer B', 'Product 2', '2024-03-31', 2),  -- Assuming pro_id 2 corresponds to the second entry in 'produ'
    (1003, 'Customer C', 'Product 3', '2024-04-01', 3);  -- Assuming pro_id 3 corresponds to the third entry in 'produ'



select* from oRderpro;
select* from produ;


--how to create view
SELECT* FROM dbo.oRderpro 
INNER JOIN
dbo.produ ON dbo.oRderpro.pro_id = dbo.produ.pro_id;

select*from [TSQL2012].[dbo].View_test_bangCalss;


-- temp table 
create table test6(
testId bigint not null primary key identity(1,1),
e_name varchar(50),
e_address varchar(50) 
);

INSERT INTO test6(e_name, e_address)
VALUES
    ('John Doe', '123 Main St'),
    ('Jane Smith', '456 Elm St'),
    ('Michael Johnson', '789 Oak St');

select * from test6;


--tmp table
create table #test12(
testId bigint not null,
e_name varchar(50),
e_address varchar(50) 
);
insert into #test12 select* from test6;

select* from #test12;



--another work \


create table loan(
	member_number varchar(50),
	pencipal_amount int,
	interest_rate float
);

select* from loan;

-- create function customer 
CREATE FUNCTION calculateLoanDue
(
	@principal_amount int, 
	@interest_rate float
)
RETURNS int
AS
BEGIN
	DECLARE @loan_due int;
		SET @loan_due = (@principal_amount * @interest_rate) / 100;
	RETURN @loan_due;
END
GO

-- inline function 
SELECT member_number, pencipal_amount, interest_rate, dbo.calculateLoanDue(pencipal_amount, interest_rate) AS loan_due
FROM  dbo.loan;
-- if we drop function run
-- drop function[functionName]



-- who loan <20000 
create function OnlyBigloan
(
	@pencipal_amount int 
)
returns table 
return (
	select* from loan
	where  pencipal_amount>@pencipal_amount
);

select* from OnlyBigloan(50000);

-- update function

alter function OnlyBigloan
(
	@pencipal_amount int 
)
returns table 
return (
	select* from loan
	where  pencipal_amount=@pencipal_amount
);

select* from OnlyBigloan(150000);


create function InterestHigh
(
	@interest_rate float
)
returns table 
as return
(
	select * from loan 
	where interest_rate<@interest_rate -- low from user input
);

select * from InterestHigh(12);

