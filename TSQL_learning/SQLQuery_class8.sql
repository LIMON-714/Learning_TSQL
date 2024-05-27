use TSQL2012;

Select Top 10 Productid, Unitprice from  
Sales.OrderDetails ;

Select Top 10 productid, Unitprice from  
Production.Products;

-- union OrderDetails and Products
Select Top 10 Productid, Unitprice from  
Sales.OrderDetails  
Union 
Select Top 10 Productid, Unitprice from  
production.products 

-- intersct use
SELECT top 10 ProductID, UnitPrice FROM  
Sales.OrderDetails 
INTERSECT 
SELECT top 10 ProductID, UnitPrice FROM  
Production.Products

-- again 100 item if under 10 is not any value
SELECT top 100 ProductID, UnitPrice FROM  
Sales.OrderDetails
INTERSECT 
SELECT top 100 ProductID, UnitPrice FROM  
Production.Products;

-- distinct

SELECT top 10 ProductID, UnitPrice FROM  
Sales.OrderDetails 
EXCEPT 
SELECT top 10 ProductID, UnitPrice FROM  
Production.Products ;

-- EXCEPT -using ORDER BY 

SELECT TOP 10 ProductID, UnitPrice FROM 
Sales.OrderDetails 
UNION 
SELECT TOP 10 ProductID, UnitPrice FROM 
Production.Products 
ORDER BY ProductID;


-- groping
select * from Sales.Orders
where orderid=10261;

SELECT shipperid, COUNT(*) AS numorders 
FROM Sales.Orders 
GROUP BY shipperid;
-- if add Attribute 
SELECT shipperid, YEAR(shippeddate) AS shippedyear, COUNT(*) AS numorders 
FROM Sales.Orders 
GROUP BY shipperid, YEAR(shippeddate);

--if logic is true
SELECT shipperid, YEAR(shippeddate) AS shippedyear, COUNT(*) AS numorders 
FROM Sales.Orders 
WHERE shippeddate IS NOT NULL 
GROUP BY shipperid, YEAR(shippeddate) 
HAVING COUNT(*)<100;

--  if more then 100 
SELECT shipperid, YEAR(shippeddate) AS shippedyear, COUNT(*) AS numorders 
FROM Sales.Orders 
WHERE shippeddate IS NOT NULL 
GROUP BY shipperid, YEAR(shippeddate) 
HAVING COUNT(*)>100;

-- CREATE VIEW Sales.OrderValues
CREATE VIEW Sales.OrderValues
  WITH SCHEMABINDING
AS

SELECT O.orderid, O.custid, O.empid, O.shipperid, O.orderdate, O.requireddate, O.shippeddate,
  SUM(OD.qty) AS qty,
  CAST(SUM(OD.qty * OD.unitprice * (1 - OD.discount))
       AS NUMERIC(12, 2)) AS val
FROM Sales.Orders AS O
  JOIN Sales.OrderDetails AS OD
    ON O.orderid = OD.orderid
GROUP BY O.orderid, O.custid, O.empid, O.shipperid, O.orderdate, O.requireddate, O.shippeddate;


-- min max shipperid count(_name) without null count if we use count(*) all show with null
SELECT 
    shipperid, 
    COUNT(*) AS numorders, 
    COUNT(shippeddate) AS shippedorders, 
    MIN(shippeddate) AS firstshipdate, 
    MAX(shippeddate) AS lastshipdate, 
    SUM(val) AS totalvalue 
FROM 
    Sales.OrderValues 
GROUP BY 
    shipperid;


-- use here count(*) all here
SELECT shipperid, COUNT(*) AS numshippingdates FROM Sales.Orders 
GROUP BY shipperid;

-- when use shippeddate count(shippeddate)
SELECT shipperid, COUNT(shippeddate) AS  
numshippingdates 
FROM Sales.Orders 
GROUP BY shipperid;

-- when shipperid 2 is 315 if use DISTINCT
SELECT shipperid, COUNT(DISTINCT shippeddate) AS  numshippingdates 
FROM Sales.Orders 
GROUP BY shipperid;

-- we can use Count Aggregate Function

SELECT S.shipperid, S.companyname, COUNT(*) AS  numorders 
FROM Sales.Shippers AS S 
JOIN Sales.Orders AS O 
ON S.shipperid = O.shipperid 
GROUP BY S.shipperid,S.companyname;

-- after GROUP BY we use must GROUPING SETS
SELECT shipperid, YEAR(shippeddate) AS shipyear,  COUNT(*) AS numorders 
FROM Sales.Orders 
GROUP BY GROUPING SETS 
( 
( shipperid, YEAR(shippeddate) ), 
( shipperid ), 
( YEAR(shippeddate) ), 
( ) 
);


--cube is a Multiple Grouping Clause using here
SELECT shipperid, YEAR(shippeddate) AS shipyear,  COUNT(*) AS numorders 
FROM Sales.Orders 
GROUP BY CUBE 
( 
shipperid, YEAR(shippeddate) 
);

--rollup, cube and  rollup are same but main different is it use for higher key

SELECT shipcountry, shipregion, shipcity, COUNT(*) AS n FROM Sales.Orders 
GROUP BY ROLLUP( shipcountry, shipregion, shipcity ); 

--Country >Region >City this type of higher key
--Self Join
SELECT A.ORDERID,A.CUSTID,A.EMPID, B.Orderdate,  B.requireddate 
FROM Sales.Orders A, Sales.Orders B 
where A.orderid=B.orderid ;


--INSERT  ROW here

INSERT INTO Production.Suppliers 
(companyname, contactname, contacttitle, address, city,  postalcode, country, phone) 
VALUES(N'Supplier XYZ', N'Jiru', N'Head of Security', N'42  Sekimai Musashino 
shi',N'Tokyo', N'01759', N'Japan', N'(02) 4311-2609');



-- Cross Joins  
select d.n N1,s.n N2 from 
(select n from Nums where n<=4) D 
cross join 
(select n from Nums where n<=3) S 
order by N1, N2;

-- again easy process
select d.n N1, S.n N2 from nums D cross join nums S where d.n<=4 and S.n<=3 
order by N1,N2 


--Inner Joins  

select d.n N1,s.n N2 from
(select n from Nums where n<=4) D 
inner join 
(select n from Nums where n<=3) S 
on D.n=S.n 
order by N1, N2 
-- first Query 4 then 2nd table is not any value
select d.n N1, S.n N2 from nums D inner join nums S on d.n=s.n 
where d.n<=4 and S.n<=3 
order by N1,N2

-- for inner join  need to mark column
select s.supplierid ,s.companyname ,s.contactname,p.* from Production.Suppliers S 
inner join Production.Products P 
on s.supplierid =p.supplierid 
where s.country ='uk' 

-- make easy same code using and
select s.supplierid ,s.companyname ,s.contactname,p.* from Production.Suppliers S 
inner join Production.Products P 
on s.supplierid =p.supplierid and s.country = 'uk';

-- another exmple
SELECT E.empid, 
E.firstname + ' ' + E.lastname AS emp, 
M.firstname + ' ' + M.lastname AS mgr 
FROM HR.Employees AS E 
INNER JOIN hr.Employees AS M 
ON E.mgrid = M.empid; 


--Outer Joins 
-- if we use Outer Joins  same in inner join we can get 4 value if with null
select d.n N1,s.n N2 from 
(select n from Nums where n<=4) D 
left outer join 
(select n from Nums where n<=3) S 
on D.n=S.n 
order by N1, N2 

--another eample
SELECT E.empid, 
E.firstname + ' ' + E.lastname AS emp, 
M.firstname + ' ' + M.lastname AS mgr 
FROM HR.Employees AS E 
left outer JOIN HR.Employees AS M
ON E.mgrid = M.empid;

-- again left join in Supplier table
select s.supplierid ,s.companyname  
,s.contactname,s.country,p.* 
from Production.Suppliers S 
left outer join Production.Products P 
on s.supplierid =p.supplierid and s.country ='uk';

-- if we need without null value we can use here
select s.supplierid ,s.companyname 
,s.contactname,s.country,p.* 
from Production.Suppliers S 
left outer join Production.Products P 
on s.supplierid =p.supplierid 
where s.country ='uk';


