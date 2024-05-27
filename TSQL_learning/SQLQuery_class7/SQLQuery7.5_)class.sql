use TSQL2012;

select *from [dbo].[vw_T1];

-- cl1 change 
update dbo.[vw_T1] set col1 = 526,col2= 808 where testid = 17;


select *from [dbo].[T1];


-- delete 
delete FROM Stats.Tests
where testid = 11;

delete FROM Stats.Tests
where testid = 18;

select * from Stats.Tests;


-- delete with loop 
while 1=1
begin 
	delete top (1000) from Sales.OrderDetails
	where productid =12;
	if @@ROWCOUNT<1000 break;
end

select *from Sales.OrderDetails;




-- delete with joining
/*
delete from Sales.myOrder as o 
inner join Sales.Customers as c
on o.custid= c.custid
where country = N'USA';
*/

-- SEQUENCE MAKING
-- sequence not deppend on nany spacific table if i make sql002 table same sequence will work same.its an indipendent object
CREATE SEQUENCE dbo.SQ001 AS INT
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 5
    CYCLE; -- without cycle its shoe error after 5 rows insert

create table sqltest(
	id bigint, c_name varchar(50)
);

INSERT INTO sqltest values (next value for SQ001,'Jon');
INSERT INTO sqltest values (next value for SQ001,'Jamal_khan_AM');
INSERT INTO sqltest values (next value for SQ001,'Jossim_RR');
-- for the next value auto id set 

--AFTER 5 GO TO 1 
INSERT INTO sqltest values (next value for SQ001,'P_Jossim_RR');

select * from sqltest;


