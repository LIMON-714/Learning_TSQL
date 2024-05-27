----- sorting 
use TSQL2012;

select* from Sales.Orders
order by orderdate, requireddate desc;

select * from Sales.Orders
order by orderid;


select empid,firstname,lastname,firstname+' '+lastname as Fullname, Month(birthdate) as birthmonth
from HR.Employees
where country = N'USA' and region = N'WA'
order by birthmonth;
--desc
select empid,firstname,lastname,firstname+' '+lastname as Fullname, Month(birthdate) as birthmonth
from HR.Employees
where country = N'USA' and region = N'WA'
order by birthmonth desc;

-- by column order 
select empid,firstname,lastname,firstname+' '+lastname as Fullname, Month(birthdate) as birthmonth
from HR.Employees
where country = N'USA' and region = N'WA'
order by 5;


---string function
select shipname, shipaddress from Sales.Orders
order by shipname;


--len
select shipname,shipaddress,  len(shipaddress) as 'len' from Sales.Orders;


---- ship name ar first 3 letter 
select shipname, shipaddress,left(shipaddress,4) as 'left4' from Sales.Orders;
--right
select shipname, shipaddress,right(shipaddress,2) as 'right' from Sales.Orders;


-- string concat
select shipname,shipaddress, shipname+' '+shipaddress as new_call from Sales.Orders;


-- 1 to 15 porjonto data call substring function
select shipname, shipaddress, SUBSTRING(shipname+' '+shipaddress, 1,15) as newCal from Sales.Orders;

--replace
select lastname, firstname, title from HR.Employees;
select lastname, firstname, replace(title ,'Sales','IT') from HR.Employees;
select lastname, firstname, replace(title , 'Sales','sell') from hr.Employees;

----upper 
select Upper(lastname) lastname, lower(firstname) firstname, upper(firstname)+' '+upper(lastname) as Fullname from hr.Employees;

























