
use assignment;
-- task 1
CREATE DATABASE assignment;


--Make table here 
CREATE TABLE ProductSales(
    Product varchar(10),
    Customer varchar(10),
    Sales int
);

-- Insert data into the table
INSERT INTO ProductSales  (Product, Customer, Sales) VALUES ('A', 'C1', 1200);
INSERT INTO ProductSales  (Product, Customer, Sales) VALUES ('B', 'C1', 250);
INSERT INTO ProductSales  (Product, Customer, Sales) VALUES ('A', 'C2', 110);
INSERT INTO ProductSales  (Product, Customer, Sales) VALUES ('C', 'C3', 450);
INSERT INTO ProductSales  (Product, Customer, Sales) VALUES ('B', 'C3', 1000);



select* from ProductSales ;

SELECT Product, SUM(Sales) AS TotalSales
FROM ProductSales
GROUP BY Product;

--max sell
SELECT Product
FROM ProductSales
WHERE Sales = (SELECT MAX(Sales) FROM ProductSales);



-- task 2

-- Create table
CREATE TABLE Student (
    Roll int PRIMARY KEY,
    Name varchar(50)
);
-- Student table
INSERT INTO Student (Roll, Name) VALUES (1, 'A');
INSERT INTO Student (Roll, Name) VALUES (2, 'B');
INSERT INTO Student (Roll, Name) VALUES (3, 'C');
-- Marks table
CREATE TABLE Marks (
    Roll int PRIMARY KEY,
    Mark int,
    FOREIGN KEY (Roll) REFERENCES Student(Roll)
);
-- Insert data Marks table
INSERT INTO Marks (Roll, Mark) VALUES (1, 85);
INSERT INTO Marks (Roll, Mark) VALUES (3, 95);

--task 3 add two table
SELECT s.Roll, s.Name, COALESCE(m.Mark, 0) AS Mark --(null or 0 where not any mark)
FROM Student s
LEFT JOIN Marks m ON s.Roll = m.Roll
ORDER BY m.Mark desc;

--task 4 position sttudent
SELECT 
    s.Roll,
    s.Name,
    COALESCE(m.Mark,0) AS Mark,
    ROW_NUMBER() OVER (ORDER BY COALESCE(m.Mark, 0)desc) AS Position
FROM 
    Student s
LEFT JOIN 
    Marks m ON s.Roll = m.Roll
ORDER BY 
    Roll;

--task 4 result show
SELECT 
    s.Roll,
    s.Name,
    CASE 
        WHEN COALESCE(m.Mark, 0) >= 90 THEN 'A+'
        WHEN COALESCE(m.Mark, 0) >= 80 THEN 'A'
        ELSE 'F'
    END AS Grade
FROM 
    Student s
LEFT JOIN 
    Marks m ON s.Roll = m.Roll
ORDER BY 
    s.Roll;

--task 5

-- Update table
UPDATE Student
SET Name = CASE Roll
            WHEN 1 THEN 'Karim'
            WHEN 2 THEN 'Rahim'
            WHEN 3 THEN 'Karim'
            END
WHERE Roll IN (1, 2, 3);

--DISTINCT keyword (only one use the name)
SELECT DISTINCT Name AS 'Unique Name'
FROM Student;

select* from Student;


--task 6
CREATE TABLE color (
    name VARCHAR(255) PRIMARY KEY
);

INSERT INTO color (name) VALUES ('red');
INSERT INTO color (name) VALUES ('black');
INSERT INTO color (name) VALUES ('white');
INSERT INTO color (name) VALUES ('green');
INSERT INTO color (name) VALUES ('orange');


select* from color;

SELECT DISTINCT c1.name AS color1, c2.name AS color2
FROM color c1
JOIN color c2 ON c1.name < c2.name;


--task7
CREATE TABLE TestValue (
    Value1 INT,
    Value2 INT,
    Value3 INT
);

INSERT INTO TestValue (Value1, Value2, Value3) VALUES (10, 19, 17);
INSERT INTO TestValue (Value1, Value2, Value3) VALUES (78, 8, 91);

select* from TestValue;

SELECT CEILING(GREATEST(Value1, Value2, Value3) / 10.0) * 10 AS max_ceiled_value
FROM TestValue;


--task 8 FizzBuzz

SELECT
    CASE
        WHEN num % 3 = 0 AND num % 5 = 0 THEN 'FizzBuzz'
        WHEN num % 3 = 0 THEN 'Fizz'
        WHEN num % 5 = 0 THEN 'Buzz'
        ELSE CAST(num AS VARCHAR)
    END AS output
FROM
    (SELECT ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS num FROM sys.all_columns) AS numbers
WHERE
    num BETWEEN 1 AND 100;


--task 9 Find the Closest number of a given number from the table

CREATE TABLE number_table (
    Number INT
);
INSERT INTO number_table (Number) VALUES (2);
INSERT INTO number_table (Number) VALUES (4);
INSERT INTO number_table (Number) VALUES (98);
INSERT INTO number_table (Number) VALUES (34);
INSERT INTO number_table (Number) VALUES (55);
INSERT INTO number_table (Number) VALUES (23);
INSERT INTO number_table (Number) VALUES (45);
INSERT INTO number_table (Number) VALUES (65);
select* from number_table;

DECLARE @given_number INT;
SET @given_number = 27;

SELECT TOP 1 Number
FROM number_table
ORDER BY ABS(Number - @given_number);



--task 10

--task 10 Write a function that takes a string and give a Boolean output that indicates whether the string is a palindrome or not
CREATE FUNCTION dbo.IsPalindrome (@inputString VARCHAR(MAX))
RETURNS BIT
AS
BEGIN
    DECLARE @reversedString VARCHAR(MAX);
    DECLARE @isPalindrome BIT;
    
    --case-insensitive comparison
    SET @inputString = LOWER(REPLACE(@inputString, ' ', ''));
    
    -- Reverse string
    SET @reversedString = REVERSE(@inputString);
    
    -- Check
    IF @inputString = @reversedString
        SET @isPalindrome = 1; --(Palindrome)
    ELSE
        SET @isPalindrome = 0; -- (Not a palindrome)
    
    -- Result
    RETURN @isPalindrome;
END;


-- IsPalindrome function witw strings
SELECT dbo.IsPalindrome('madam') AS IsPalindrome; --1 (True)
SELECT dbo.IsPalindrome('Cssc') AS IsPalindrome; --1 (True)
SELECT dbo.IsPalindrome('adam') AS IsPalindrome; --0 (False)




