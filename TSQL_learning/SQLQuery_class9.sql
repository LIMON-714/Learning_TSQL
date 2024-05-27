use TSQL2012;

--part1 

select d.n N1, s.n N2 from
(select n from nums where n <=4) D
right outer join 
(select n from nums where n <=5) S
on D.n = S.n
order by N1,N2;

-- use right outer table with supplierid
select s.supplierid, s.companyname,s.contactname,
s.country,p.* from Production.Suppliers s
right outer join 
Production.Products p
on s.supplierid = p.supplierid and  s.country= 'uk';

--multi join query
SELECT 
    s.companyname AS supplier, 
    s.country, 
    p.productid, 
    p.productname,
    p.unitprice,
    c.categoryname
FROM 
    Production.Suppliers AS s
LEFT OUTER JOIN 
    Production.Products AS p ON s.supplierid = p.supplierid
INNER JOIN 
    Production.Categories AS c ON c.categoryid = p.categoryid
WHERE 
    s.country = N'uk';



--part2

-- self-contained Subqueries
select productid,productname, unitprice
from Production.Products
where unitprice = (select min(unitprice) 
FROM Production.Products);


-- if we find maximum price 
select productid,productname, unitprice
from Production.Products
where unitprice = (select max(unitprice) 
FROM Production.Products);


-- which category price high or min
select categoryid, productid,productname, unitprice
from Production.Products as p1
where unitprice = (select min(unitprice) 
FROM Production.Products as p2
where p2.categoryid = p1.categoryid);