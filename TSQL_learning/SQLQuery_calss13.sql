use TSQL2012;



-- auhte increment 
IF OBJECT_ID('Sales.MyOrders') IS NOT NULL 
    DROP TABLE Sales.MyOrders;

CREATE TABLE Sales.MyOrders
(
    orderid INT NOT NULL IDENTITY(1, 1) CONSTRAINT PK_MyOrders_orderid PRIMARY KEY,
    custid INT NOT NULL CONSTRAINT CHK_MyOrders_custid CHECK (custid > 0), 
    empid INT NOT NULL CONSTRAINT CHK_MyOrders_empid CHECK (empid > 0), 
    orderdate DATE NOT NULL 
);

select * FROM Sales.MyOrders;

INSERT INTO Sales. MyOrders (custid, empid, orderdate) 
VALUES (1,2,'20120620'),
		(1,3,'20120620'),
		(2,2,'20120620');

-- last generate Identity value

SELECT
SCOPE_IDENTITY() AS SCOPE_IDENTITY,
@@IDENTITY AS [@@IDENTITY],
IDENT_CURRENT ('Sales. MyOrders') AS IDENT_CURRENT;

-- insert again 

INSERT INTO Sales.MyOrders (custid, empid, orderdate) VALUES
(1, 2,'20120620'),
(1, 3, '20120620'),
(2, 2, '20120620');

select * from Sales.MyOrders;

delete from Sales.MyOrders;

-- if truncate table 
truncate table Sales.MyOrders;

--but show same 
SELECT
SCOPE_IDENTITY() AS SCOPE_IDENTITY,
@@IDENTITY AS [@@IDENTITY],
IDENT_CURRENT ('Sales. MyOrders') AS IDENT_CURRENT;

-- value again 

INSERT INTO Sales.MyOrders (custid, empid, orderdate) VALUES
(1, 2,'20120620'),
(1, 3, '20120620'),
(2, 2, '20120620');

select*from Sales.MyOrders;
-- and show 3 again
SELECT
SCOPE_IDENTITY() AS SCOPE_IDENTITY,
@@IDENTITY AS [@@IDENTITY],
IDENT_CURRENT ('Sales. MyOrders') AS IDENT_CURRENT;






create proc p2
as 
    INSERT INTO Sales.MyOrders (custid, empid, orderdate) VALUES
    (1, 2, '20120620'),
    (1, 3, '20120620'),
    (2, 2, '20120620');
create proc p1
as 
    INSERT INTO Sales.MyOrders (custid, empid, orderdate) VALUES
    (1, 2, '20120620'),
    (1, 3, '20120620'),
    (2, 2, '20120620');
exec p2


--DBCC CHECKIDENT

DBCC CHECKIDENT ('Sales.MyOrders', RESEED, 100); 
SELECT IDENT_CURRENT ('Sales.MyOrders') AS [IDENT CURRENT];

--SEQUENCE

CREATE SEQUENCE [dbo].[SQ001] 
    AS INT
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 5
    CYCLE;

--create table 

create table sqltest
(
id bigint,
name varchar (50)
)
--data insert 

insert into sqltest values (next value for sq001, 'hasan')
insert into sqltest values (next value for sq001, 'habib')

select * from sqltest;

insert into sqltest values (next value for sq001, 'hasan')
insert into sqltest values (next value for sq001, 'habib')

-- if don't use  cycle not used don't make report
-- example 

CREATE SEQUENCE [dbo].[SQ002] AS INT
START WITH 1
INCREMENT BY 1
MINVALUE 1
MAXVALUE 5;

-- data insert
insert into sqltest values (next value for sq001, 'hasan')
insert into sqltest values (next value for sq001, 'habib')

select * from sqltest;

-- if we restart 
alter SEQUENCE SQ002 RESTART WITH 1;

