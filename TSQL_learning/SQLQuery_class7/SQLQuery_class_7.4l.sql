use TSQL2012;

use TSQL2012;
-- insert exec 
create proc testproc
as 
select custid,empid,orderdate, shipcountry, freight
from Sales.Orders
where shipcountry = N'Brazil';


-- run proc
exec testproc;


-- insert it my order 
insert into Sales.myOrder exec testproc; 
select * from Sales.myOrder;

--another
create proc testproc_2
as 
select orderid,custid,empid,orderdate, shipcountry, freight
from Sales.Orders
where shipcountry = N'Brazil';

-- alter brazil to canada
alter proc testproc_2
as 
select orderid,custid,empid,orderdate, shipcountry, freight
from Sales.Orders
where shipcountry = N'india';


-- need to identity off
set identity_insert Sales.myOrder on;
insert into Sales.myOrder(order_id,custid,empid,order_date, shipcountry, freight)exec testproc_2
exec testproc_2;
set identity_insert Sales.myOrder off;


-- again
create proc testproc_3
as 
select custid,empid,orderdate, shipcountry, freight
into Sales.myOrder2
from Sales.Orders
where shipcountry = N'Belgium';

set identity_insert Sales.myOrder on;
insert into Sales.myOrder(order_id,custid,empid,order_date, shipcountry, freight)exec testproc_3
exec testproc_3;
set identity_insert Sales.myOrder off;



--update again 
select* 
from Sales.OrderDetails
where orderid = 10251;

-- update here 
update Sales.OrderDetails
set discount *=0.5
where orderid = 10251;

-- update  here 
update Sales.OrderDetails
set discount += 0.5
where orderid= 10251;



-- update  based on join 

SELECT OD.* 
FROM Sales.Customers AS C
inner join Sales.myOrder as O
on c.custid = o.custid
inner join Sales.OrderDetails as OD
on o.order_id = OD.orderid
where c.country = N'Norway';

-- update 
update OD
set OD.discount +=0.05 , OD.qty += 1
FROM Sales.Customers AS C
INNER JOIN 
Sales.myOrder AS O 
ON C.custid = O.custid
INNER JOIN 
Sales.OrderDetails AS OD 
ON O.order_id = OD.orderid
WHERE C.country = N'Norway';


-- update base on variable 
declare @value numeric(4,3)
update OD
set @value = OD.discount +=0.05 , OD.qty += 1 -- set data into valuer from od discount 
FROM Sales.Customers AS C
INNER JOIN 
Sales.myOrder AS O 
ON C.custid = O.custid
INNER JOIN 
Sales.OrderDetails AS OD 
ON O.order_id = OD.orderid
WHERE C.country = N'Norway';
select @value




-- update here another way

create table dbo.T1
(
	keycol int not null
	constraint pk_T1 primary key,
	col1 int not null,
	col2 int not null
);

insert into T1(keycol,col1,col2)
values
	(1,100,0);
select* from T1;


--add variable 
declare @add as int =10;

update dbo.T1
set col1+=@add, col2 =col1
where keycol = 1;

select* from T1;
