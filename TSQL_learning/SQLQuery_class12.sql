

-- what is tsql = transact-sql


-- CRUD

CREATE DATABASE section9;

--drop
--drop database section9;

use section9;
create table dbo.products
(
	product_ID int  primary key not null,
	product_name varchar(25) not null,
	price money null,
	product_description varchar(max)
); 
GO

-- insert data here 
INSERT INTO dbo.products (product_ID, product_name, price, product_description)
VALUES (1, 'Product1', 19.99, 'Description for Product 1'),
		(2, 'Product2', 29.99, 'Description for Product 2'),
		(3, 'Product3', 27.09, 'Description for Product 3'),
		(4, 'Product4', 64.90, 'Description for Product 4'),
		(5, 'Product5', 20.99, 'Description for Product 5');

-- again insert use null
INSERT INTO dbo.products (product_ID, product_name, product_description)
VALUES (9, 'Product1', 'Description for Product 1'); --  vul 

-- delete
delete from dbo.products where product_ID = 6;


-- again dec 9
INSERT INTO dbo.products (product_ID, product_name, product_description)
VALUES (6, 'Product6', 'Description for Product 6');




-- select
select* from dbo.products;
--again 
select product_ID, price from dbo.products;

-- read 
select * from dbo.products
where product_ID <= 3;

-- read 
select * from dbo.products
where price <20;


-- view 
-- view is a vartual table base on result set of an sql statement 
-- view can consist one or more table and data in a view is usually up to data 

create view myView
	as 
	select product_name , price from products;
Go


--read
select * from myView;
GO


-- procedure  is one or more 



--update transact-sql statement that executes as a batch and use input and output statement 
-- they can contain statement to control the flow of the statement 

create procedure pr_mYpro @varPrice money
	as 
	Begin
	--the point statement returns text to the user 
	PRINT 'Pr0ducts less than ' + cast (@varPrice as varchar(10));
	--a second statement  strats here 
	select product_name , price from myView
		where price = @varPrice;
	END
GO

EXECUTE pr_mYpro 64.90;
GO


SELECT* FROM products;

-- USING UPDATE 

update dbo.products
	set product_name = 'empa_vag'
	where product_ID = 2;
	GO


-- backup database using t-sql 

backup database section9
to disk = 'E:\data\data.bak'
GO

-- deleting data 
delete from dbo.products
where product_ID = 3;
GO

-- truncating table 
--truncate table dbo.products
--GO

use farukh;
-- droping table , database 
drop database farukh;

-- restoring database 
restore database section9
from disk = 'E:\data\data.bak';
GO