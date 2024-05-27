
-- temporary table variable 
 use TSQL2012;

 CREATE TABLE Sales.myOrder
(
	order_id INT NOT NULL IDENTITY(1,1),
	custid INT NOT NULL,
	empid INT NOT NULL,
	order_date DATE NOT NULL 
	CONSTRAINT DET_MyOrder_order_date DEFAULT (CAST(GETDATE() AS DATE)),
	shipcountry VARCHAR(50) NOT NULL,
	Freight MONEY NOT NULL,
	CONSTRAINT PK_MyOrder_orderID PRIMARY KEY (order_id)
);
INSERT INTO Sales.myOrder (custid, empid, order_date, shipcountry, Freight)
VALUES
(1, 101, '2024-04-02', 'USA', 50.00),
(2, 102, '2024-04-03', 'Canada', 75.50),
(3, 103, '2024-04-04', 'UK', 100.25);

select * from Sales.myOrder;

--without orderdate what heppend
--get current date 
INSERT INTO Sales.myOrder (custid, empid, shipcountry, Freight)
VALUES
(4,101,N'RSU', 50.00);
INSERT INTO Sales.myOrder ( custid,empid, shipcountry, Freight)
VALUES
(9,108,N'ISU', 50.00);

-- data insert by select 
SET IDENTITY_INSERT Sales.myOrder ON;

INSERT INTO Sales.myOrder (order_id, custid, empid, order_date, shipcountry, Freight)
SELECT order_id, custid, empid, order_date, shipcountry, Freight
FROM Sales.myOrder
WHERE shipcountry = N'Norway';

SET IDENTITY_INSERT Sales.myOrder OFF;


--see
 select * from Sales.myOrder;



