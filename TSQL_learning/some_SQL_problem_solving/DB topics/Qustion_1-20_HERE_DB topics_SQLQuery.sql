USE assignment;

CREATE TABLE MyTable (
    ID INT,
    Name NVARCHAR(100),
    Age INT,
    Gender CHAR(1)
);
-- Setting a Primary key (single column primary key and composite primary key)

-- Add a NOT NULL
ALTER TABLE MyTable
ALTER COLUMN ID INT NOT NULL;

-- Setting a Single Column Primary Key
ALTER TABLE MyTable
ADD CONSTRAINT PK_MyTable_ID PRIMARY KEY (ID);

-- Add a NOT NULL constraint
ALTER TABLE MyTable
ALTER COLUMN Name VARCHAR(100) NOT NULL;

-- Composite primary key
ALTER TABLE MyTable
ADD CONSTRAINT PK_MyTable_Composite PRIMARY KEY (ID, Name);

-- Creating a calculated column
ALTER TABLE MyTable
ADD FullData AS (Name + ', Age: ' + CAST(Age AS NVARCHAR(10)));

-- Inserting rows using INSERT INTO script
INSERT INTO MyTable (ID, Name, Age, Gender)
VALUES 
    (1, 'imti', 30, 'M'),
    (2, 'limon', 25, 'F'),
    (3, 'sk', 35, 'M');

UPDATE MyTable
SET Gender = 'm'
WHERE ID = 2;
select* from MyTable;

select * from MyTable;


---q 6 

-- Creating a view
CREATE VIEW MyView
AS
SELECT ID, Name, Age
FROM MyTable;


--7.	Using some built in functions like isnull, floor, ceiling, round etc
SELECT 
    ID,
    Name,
    Age,
    Gender,
    ISNULL(Name, 'Unknown') AS UpdatedName, 
    FLOOR(Age / 10) AS AgeGroup,
    CEILING(Age / 10.0) AS CeilAgeGroup, 
    ROUND(Age / 10.0,1) AS AvgAgeGroup
FROM 
    MyTable;

-- q8 8.	String functions
SELECT UPPER(Name) AS UppercaseNames FROM MyTable;

SELECT LOWER(Name) AS LowercaseNames FROM MyTable;

SELECT Name, LEN(Name) AS NameLength FROM MyTable;

SELECT LEFT(Name, 3) AS FirstThreeChars FROM MyTable;

SELECT RIGHT(Name, 3) AS LastThreeChars FROM MyTable;

SELECT SUBSTRING(Name, 2, 4) AS SubstringName FROM MyTable;

SELECT REPLACE(Name, 'i', 'y') AS ReplacedName FROM MyTable;

select* from MyTable;


--q9 9.	Date time functions
SELECT GETDATE() AS Current_DateTime;
-- specified time interval
SELECT DATEADD(day, 7, GETDATE()) AS DateA_fter_7Days;
--difference between two
SELECT DATEDIFF(year, '1999-12-01', GETDATE()) AS Age_Years;
--specific part of a datetime
SELECT DATEPART(year, GETDATE()) AS Current_Year;
-- datetime value
SELECT CONVERT(VARCHAR, GETDATE(), 101) AS ShortDate;
-- specified format
SELECT FORMAT(GETDATE(), 'MM/dd/yyyy') AS FormattedDate;




-- q 10  10.	Creating a user defined function
CREATE FUNCTION dbo.Concatenate_NameAndAge 
(
    @Name NVARCHAR(100),
    @Age INT
)
RETURNS NVARCHAR(200)
AS
BEGIN
    DECLARE @Result NVARCHAR(200);
    SET @Result = @Name + ', Age: ' + CAST(@Age AS NVARCHAR(10));
    RETURN @Result;
END;

SELECT dbo.Concatenate_NameAndAge(Name, Age) AS FullData FROM MyTable;



-- q 11 11.	Creating a table valued function
CREATE FUNCTION dbo.Get_Persons()
RETURNS TABLE
AS
RETURN (
    SELECT Name, Age
    FROM MyTable
);
SELECT *
FROM dbo.Get_Persons();



-- q 12 12.	Creating a stored procedure (with input parameters and output parameters)
CREATE PROCEDURE get_persons_older_than_age
    @Age INT,
    @Count INT OUTPUT
AS
BEGIN
    SELECT Name
    FROM MyTable
    WHERE Age > @Age;

    SELECT @Count = COUNT(*)
    FROM MyTable
    WHERE Age > @Age;
END;
use assignment;
--  call function
DECLARE @Count INT;
EXEC get_persons_older_than_age @Age = 30, @Count = @Count OUTPUT;
PRINT 'Number of persons older than 30: ' + CAST(@Count AS NVARCHAR(10));

	select* from myTable;


-- q 13 13.	Calling a stored procedure with output params
CREATE PROCEDURE Person_Count
    @Count INT OUTPUT
AS
BEGIN
    SELECT @Count = COUNT(*)
    FROM MyTable;
END;

--call
DECLARE @TotalPersons INT;
EXEC Person_Count @Count = @TotalPersons OUTPUT;
PRINT 'Total number of persons: ' + CAST(@TotalPersons AS NVARCHAR(10));


--q 14	Creating a temporary table
CREATE TABLE #TempTable (
    ID INT,
    Name NVARCHAR(100),
    Age INT
);
INSERT INTO #TempTable (ID, Name, Age)
VALUES 
    (1, 'xxx', 40),
    (2, 'yyy', 20),
    (3, 'zzz', 47);
select* from #TempTable;


-- q 15 15.	Inner join, left outer join, right outer join syntax (prb)
-- row
SELECT MyTable.*, MyView.*
FROM MyTable
INNER JOIN MyView ON MyTable.ID = MyView.ID;

-- Left Outer Join
SELECT MyTable.*, MyView.*
FROM MyTable
LEFT JOIN MyView ON MyTable.ID = MyView.ID;

--Right Outer Join
SELECT MyTable.*, MyView.*
FROM MyTable
RIGHT JOIN MyView ON MyTable.ID = MyView.ID;


-- q16 16.	Dynamic sql
DECLARE @sql NVARCHAR(MAX);
DECLARE @tableName NVARCHAR(50);
DECLARE @columnName NVARCHAR(50);

SET @tableName = 'MyTable';
SET @columnName = 'Name';

SET @sql = 'SELECT ' + @columnName + ' FROM ' + @tableName;

EXEC sp_executesql @sql;


-- q 17	Executing a dynamic sql
DECLARE @sql NVARCHAR(MAX);
DECLARE @tableName NVARCHAR(50);
DECLARE @columnName NVARCHAR(50);

SET @tableName = 'MyTable';
SET @columnName = 'Name';

SET @sql = 'SELECT ' + QUOTENAME(@columnName) + ' FROM ' + QUOTENAME(@tableName);

EXECUTE(@sql);


-- q 18 18.	If else in sql

CREATE PROCEDURE Check_Age
    @Age INT
AS
BEGIN
    IF @Age < 18
    BEGIN
        PRINT 'Age Category: Child';
    END
    ELSE IF @Age BETWEEN 18 AND 65
    BEGIN
        PRINT 'Age Category: Adult';
    END
    ELSE
    BEGIN
        PRINT 'Age Category: Senior Citizen';
    END
END;

-- call 
EXEC Check_Age @Age = 25;


-- q 19	Sql case when statement
SELECT
    Name,
    Age,
    CASE
        WHEN Age < 18 THEN 'Child'
        WHEN Age BETWEEN 18 AND 65 THEN 'Adult'
        ELSE 'Senior Citizen'
    END AS AgeGroup
FROM
    MyTable;


-- 20 Sql aggregate function with group by clause
SELECT Gender, COUNT(*) AS TotalCount
FROM MyTable
GROUP BY Gender;







