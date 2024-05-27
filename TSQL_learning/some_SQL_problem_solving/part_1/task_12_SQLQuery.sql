
--task 12
use assignment;

--Employees table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(100),
    Department VARCHAR(100),
    JobPosition VARCHAR(100),
    Level INT,
    JoinDate DATE
);

--ReportingRelationships table
CREATE TABLE ReportingRelationships (
    ReportingID INT PRIMARY KEY,
    EmployeeID INT,
    ReportingManagerID INT,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (ReportingManagerID) REFERENCES Employees(EmployeeID)
);

-- Employees table
INSERT INTO Employees (EmployeeID, Name, Department, JobPosition, Level, JoinDate)
VALUES 
    (1, 'Rahim kahn', 'Engineering', 'Junior Developer', 1, '2024-01-02'),
    (2, 'Karim khan', 'Engineering', 'Junior Developer', 1, '2024-02-02'),
    (3, 'sk Huda', 'Engineering', 'Senior Developer', 2, '2023-03-01'),
    (4, 'aria khan', 'Engineering', 'Senior Developer', 2, '2023-06-05'),
    (5, 'Limon Rahman', 'Engineering', 'Team Leader', 3, '2024-03-01'),
    (6, 'xyz_khan', 'Engineering', 'Senior Team Leader', 4, '2022-12-03');
	
	-- ReportingRelationships table
INSERT INTO ReportingRelationships (ReportingID, EmployeeID, ReportingManagerID)
VALUES
    (1, 1, 3),  -- Rahim Khan reports to Sk Huda (EmployeeID 3)
    (2, 2, 3),  -- Karim Khan reports to Sk Huda (EmployeeID 3)
    (3, 3, 5),  -- Sk Huda reports to Limon Rahman (EmployeeID 5)
    (4, 4, 5),  -- Aria Khan also reports to Limon Rahman (EmployeeID 5)
    (5, 5, 6),  -- Limon Rahman reports to xyz_khan (EmployeeID 6)
    (6, 6, NULL); -- xyz_khan has no reporting manager


	select* from ReportingRelationships;