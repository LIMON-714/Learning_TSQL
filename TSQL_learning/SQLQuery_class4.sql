use TSQL2012;

--2008 ar order date omly
select* from Sales.Orders
where year(orderdate )=2008;

select* from Sales.Orders
where year(orderdate) =2008 and MONTH(orderdate) = 1 and DAY(orderdate) = 12;

--again 
select * from Sales.Orders
where year (orderdate) = 2007 and month(orderdate) = 02 and DAY (orderdate) = 12;


--and
select* from Sales.Orders
where orderdate ='20080112';


-- freight
select orderid,freight from Sales.Orders;
--round
select orderid,round(freight ,0) as freight from Sales.Orders;
--another method
select orderid,round(freight ,0) as 'round' from Sales.Orders
where ROUND(freight,0)>15 and ROUND(freight,0)<30
order by 'round'; 



-- using case here 

select orderid,freight, round(freight,0),
(case
	when round(freight,0)<=11 then 'very low freight'
	when round(freight,0)>=12 and round(freight,0)<16 then 'low freight'
	when round(freight,0)>=16 and round(freight,0)<25 then 'mid freight'
	when round(freight,0)>=25  and round(freight,0)<30 then 'Height freight'
	else
	'very high'
 end

)as freightchose from Sales.Orders;



-- imm if
--again
select orderid,freight, (iif(freight>=10,'high','low')) as 'status' from Sales.Orders;


-- choose here 
select choose(2, 'hasan','harun','kasam','murad') as name_c; -- index 0 1  name here
select choose(4, 'hasan','harun','kasam','murad') as name_c; -- index 0123 index name here

-- top filtering process
select top 10 orderid, orderdate,custid,empid
from Sales.Orders
order by orderdate;

--des
select top 10 orderid, orderdate,custid,empid
from Sales.Orders
order by orderdate desc;

select count(*) as numberders
from Sales.Orders;


select top 1 percent orderid, orderdate,custid,empid
from Sales.Orders
order by orderdate;



-- offset row
select orderid, orderdate,custid,empid
from Sales.Orders
order by orderdate desc,orderid desc
offset 0 rows fetch next 10 rows only;  -- for this 0 to fetch next 10 rows



-- union intersection
select top 10 ProductID, unitPrice from Sales.OrderDetails
union
select top 10 ProductID, unitPrice from Production.Products
order by ProductID;



select top 10 ProductID, unitPrice from Sales.OrderDetails
union ALl
select top 10 ProductID, unitPrice from Production.Products
order by ProductID;


-- intersecttion here 
select TOP 200 ProductID, unitPrice from Sales.OrderDetails
intersect
select TOP 200 ProductID, unitPrice from Production.Products
order by ProductID;


-- EXCEPT WORK PROCESS
select top 10 ProductID, unitPrice from Sales.OrderDetails
except
select top 10 ProductID, unitPrice from Production.Products
order by ProductID;


-- grouping 
select count(*) as numberders
from Sales.Orders;
select count(*) as numberders
from Sales.OrderDetails;

select count (*) as total_number
from HR.Employees;

select count(*) as total 
from Sales.OrderDetails;

select shipperid, count(*) as numberders 
from Sales.Orders
Group by shipperid;


--bujhinai
select shipperid,year(shippeddate) as shipper_year, count(*) as numberders 
from Sales.Orders
Group by shipperid,year(shippeddate);

--condition
select shipperid,year(shippeddate) as shipper_year, count(*) as numberders 
from Sales.Orders
where shippeddate is not Null
Group by shipperid,year(shippeddate)
Having count(*)<100;



-- aggrigrade  function
select shipperid,
count(*) as numberdes,
count(shippeddate) as shippedorders,
MIN(shippeddate) as FirstShipdate,
max(shippeddate) as lastShipdate,
SUM(val) as Total_value
from Sales.OrderValues
Group by Shipperid;




select * from Sales.Shippers;

---------------------------------------------
select S.shipperid, S.companyname, count(*) as numberders
from sales.Shippers as s
join Sales.Orders as o
On s.shipperid= o.shipperid
Group by S.shipperid;

-- solve this problems 
select S.shipperid, S.companyname, count(*) as numberders
from Sales.Shippers as s
join Sales.Orders as o
On s.shipperid= o.shipperid
Group by S.shipperid , s.companyname;


-- multipul groping
select shipperid, year(shippeddate) as shipyear, count(*) as numberders
from Sales.Orders
group by grouping SETS
((shipperid, year(shippeddate) ),
(shipperid),
(year(shippeddate)),
()
);


-- cube
select shipperid, year(shippeddate) as shipyear, count(*) as numberders
from Sales.Orders
group by cube
(
shipperid, year(shippeddate)

);

-- rollup work 
select shipcountry, shipregion,shipcity, count(*) as n 
from Sales.Orders
Group by rollup(shipcountry, shipregion, shipcity );


-- work rollup or not work
select
shipcountry, grouping(shipcountry) as grpcountry,
shipregion, grouping(shipregion) as grpregion,
shipcity, grouping(shipcity) as grpcity
from Sales.Orders
group by rollup(shipcountry, shipregion, shipcity );


--joins
--three kind of joine
	--cross join
	--ineer join
	--outer join

	use TSQL2012;

CREATE TABLE Nums (
    n INT
);

INSERT INTO Nums (n) VALUES (1), (2), (3), (4), (5); -- Add some sample data

-- cross join
select D.n as N1, s.n as N2 from
(SELECT n FROM Nums WHERE n <= 4) D
CROSS JOIN 
(SELECT n FROM Nums WHERE n <= 3) s
order by N1,N2;

select d.n N1,s.n N2 from nums D cross join nums s
where d.n<=4 and s.n<=3
order by N1,N2;



--inner join
select D.n as N1, s.n as N2 from
(SELECT n FROM Nums WHERE n <= 4) D
inner JOIN 
(SELECT n FROM Nums WHERE n <= 3) s
on D.n=s.n
order by N1,N2;


select s.Supplierid, s.companyname , s.contactname  , p.*
from Production.Suppliers as s
inner join 
Production.Products as p
on s.supplierid = p.supplierid
where s.country='japan';


select E.empid,
E.firstname+' '+E.lastname as fullName,
M.firstname+' '+M.lastname as Mangr_fullName
from hr.Employees as E
inner join 
HR.Employees as M
ON E.mgrid = M.mgrid;



-- outer join (left)
select D.n as x1, s.n as x2 from
(SELECT n FROM Nums WHERE n <= 4) D
LEFT OUTER JOIN
(SELECT n FROM Nums WHERE n <= 3) s 
ON D.n = s.n
order by  x1,x2;




select E.empid,
E.firstname+' '+E.lastname as fullName,
M.firstname+' '+M.lastname as Mangr_fullName
from hr.Employees as E
left outer join 
HR.Employees as M
ON E.mgrid = M.mgrid;


select s.Supplierid, s.companyname , s.contactname  , p.*
from Production.Suppliers as s
left outer join 
Production.Products as p
on s.supplierid = p.supplierid and s.country='japan';



--right outer valus

select D.n as x1, s.n as x2 from
(SELECT n FROM Nums WHERE n <= 3) D
right OUTER JOIN
(SELECT n FROM Nums WHERE n <= 5) s 
ON D.n = s.n
order by  x1,x2;


select s.Supplierid, s.companyname , s.contactname  , p.*
from Production.Suppliers as s
right outer join 
Production.Products as p
on s.supplierid = p.supplierid and s.country='japan';


--full outer join
select D.n as x1, s.n as x2 from
(SELECT n FROM Nums WHERE n>=2 and  n <= 5) D
full OUTER JOIN
(SELECT n FROM Nums WHERE n <= 4) s 
ON D.n = s.n
order by  x1,x2;


--multi join
select s.companyname as supplier, s.country , p.productid,p.productname,p.unitprice,c.categoryname
from Production.Suppliers as s
left outer join 
Production.Products as p
ON s.supplierid= p.supplierid
inner join 
Production.Categories as c
ON  c.categoryid = p.categoryid
where country = N'japan';

-- query for min products price here 
select p.productid ,productname,unitprice
from Production.Products as p
where unitprice = (select min(unitprice) 
from Production.Products) ;

-- high price 
select pt.productid,pt.productname,pt.unitprice 
from Production.Products as pt
where unitprice = (select max(unitprice) 
from Production.Products);


-- avg 
select p.productid ,productname,unitprice
from Production.Products as p
where unitprice = (select AVG(unitprice) 
from Production.Products) ;

-- pricr 80 to 100
select p.productid ,productname,unitprice
from Production.Products as p
WHERE unitprice BETWEEN 80 AND 100;

-- co-related subqueries 

select p1.categoryid, p1.productid,p1.productname,p1.unitprice 
from Production.Products as p1
where p1.unitprice =(
	select min(p2.unitprice)
	from Production.Products as p2 
	where p2.categoryid= p1.categoryid
);

-- catagories was its a max price products
select p1.categoryid, p1.productid,p1.productname,p1.unitprice 
from Production.Products as p1
where p1.unitprice =(
	select max(p2.unitprice)
	from Production.Products as p2 
	where p2.categoryid= p1.categoryid
);
