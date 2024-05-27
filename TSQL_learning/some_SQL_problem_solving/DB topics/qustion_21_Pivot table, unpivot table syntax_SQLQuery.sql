
----- 21	Pivot table, unpivot table syntax

CREATE TABLE Employee_data (
    EmployeeID INT,
    EmployeeName NVARCHAR(50),
    Department NVARCHAR(50),
    Salary DECIMAL(10, 2),
    Gender CHAR(1)
);

INSERT INTO Employee_data (EmployeeID, EmployeeName, Department, Salary, Gender)
VALUES 
    (1, 'kamal', 'HR', 50000.00, 'M'),
    (2, 'nur', 'IT', 60000.00, 'F'),
    (3, 'sk', 'Finance', 55000.00, 'M'),
    (4, 'Depu', 'HR', 52000.00, 'M'),
    (5, 'Eva', 'IT', 62000.00, 'F');

-- Pivot Table Syntax
SELECT Department,
       COUNT(*) AS TotalEmployees
FROM Employee_data
GROUP BY Department;

-- Unpivot Table Syntax
SELECT Department, Gender, Salary
FROM
(
    SELECT EmployeeID, EmployeeName, Department, Salary, Gender
    FROM Employee_data
) AS Source
UNPIVOT
(
    SalaryValue FOR GenderCode IN ([M], [F])
) AS UnpivotData;

