
--task 13
use assignment;

--Countries table
CREATE TABLE Countries (
    CountryID INT PRIMARY KEY,
    CountryName VARCHAR(100)
);

--Matches table
CREATE TABLE Matches (
    MatchID INT PRIMARY KEY,
    MatchDate DATE,
    Venue VARCHAR(100),
    WinningCountryID INT,
    LosingCountryID INT,
    FOREIGN KEY (WinningCountryID) REFERENCES Countries(CountryID),
    FOREIGN KEY (LosingCountryID) REFERENCES Countries(CountryID)
);

--Innings table
CREATE TABLE Innings (
    InningsID INT PRIMARY KEY,
    MatchID INT,
    CountryID INT,
    TotalRuns INT,
    WicketsLost INT,
    FOREIGN KEY (MatchID) REFERENCES Matches(MatchID),
    FOREIGN KEY (CountryID) REFERENCES Countries(CountryID)
);

-- Players table
CREATE TABLE Players (
    PlayerID INT PRIMARY KEY,
    Name VARCHAR(100),
    CountryID INT,
    Role VARCHAR(50),
    FOREIGN KEY (CountryID) REFERENCES Countries(CountryID)
);

--BattingStats table
CREATE TABLE BattingStats (
    BattingID INT PRIMARY KEY,
    InningsID INT,
    PlayerID INT,
    RunsScored INT,
    FOREIGN KEY (InningsID) REFERENCES Innings(InningsID),
    FOREIGN KEY (PlayerID) REFERENCES Players(PlayerID)
);

-- BowlingStats table
CREATE TABLE BowlingStats (
    BowlingID INT PRIMARY KEY,
    InningsID INT,
    PlayerID INT,
    WicketsTaken INT,
    RunsConceded INT,
    FOREIGN KEY (InningsID) REFERENCES Innings(InningsID),
    FOREIGN KEY (PlayerID) REFERENCES Players(PlayerID)
);

--Countries table
INSERT INTO Countries (CountryID, CountryName)
VALUES 
    (1, 'Australia'),
    (2, 'India'),
    (3, 'England'),
    (4, 'New Zealand'),
    (5, 'South Africa'),
    (6, 'Pakistan'),
    (7, 'Bangladesh'),
    (8, 'Sri Lanka'),
    (9, 'West Indies'),
    (10, 'Afghanistan');

--  Matches table
INSERT INTO Matches (MatchID, MatchDate, Venue, WinningCountryID, LosingCountryID)
VALUES 
    (1, '2023-06-01', 'Melbourne', 1, 2),
    (2, '2023-06-02', 'Sydney', 3, 4),
    (3, '2023-06-03', 'London', 5, 6),
    (4, '2023-06-04', 'Auckland', 7, 8),
    (5, '2023-06-05', 'Dhaka', 9, 10);

--Innings table
INSERT INTO Innings (InningsID, MatchID, CountryID, TotalRuns, WicketsLost)
VALUES 
    (1, 1, 1, 350, 8),
    (2, 1, 2, 280, 10),
    (3, 2, 3, 310, 7),
    (4, 2, 4, 290, 9),
    (5, 3, 5, 320, 6),
    (6, 3, 6, 280, 8),
    (7, 4, 7, 260, 10),
    (8, 4, 8, 240, 9),
    (9, 5, 9, 330, 7),
    (10, 5, 10, 250, 10);

--Players table
INSERT INTO Players (PlayerID, Name, CountryID, Role)
VALUES 
    (1, 'Virat Kohli', 2, 'Batsman'),
    (2, 'Steve Smith', 1, 'Batsman'),
    (3, 'Joe Root', 3, 'Batsman'),
    (4, 'Kane Williamson', 4, 'Batsman'),
    (5, 'Quinton de Kock', 5, 'Batsman'),
    (6, 'Babar Azam', 6, 'Batsman'),
    (7, 'Tamim Iqbal', 7, 'Batsman'),
    (8, 'Dimuth Karunaratne', 8, 'Batsman'),
    (9, 'Jason Holder', 9, 'Batsman'),
    (10, 'Rashid Khan', 10, 'Bowler');

--BattingStats table
INSERT INTO BattingStats (BattingID, InningsID, PlayerID, RunsScored)
VALUES 
    (1, 1, 1, 120),
    (2, 1, 2, 90),
    (3, 2, 3, 110),
    (4, 2, 4, 85),
    (5, 3, 5, 130),
    (6, 3, 6, 80),
    (7, 4, 7, 100),
    (8, 4, 8, 75),
    (9, 5, 9, 140),
    (10, 5, 10, 65);

--BowlingStats table
INSERT INTO BowlingStats (BowlingID, InningsID, PlayerID, WicketsTaken, RunsConceded)
VALUES 
    (1, 1, 1, 2, 40),
    (2, 1, 2, 3, 55),
    (3, 2, 3, 1, 45),
    (4, 2, 4, 2, 60),
    (5, 3, 5, 2, 50),
    (6, 3, 6, 1, 65),
    (7, 4, 7, 3, 40),
    (8, 4, 8, 2, 55),
    (9, 5, 9, 4, 35),
    (10, 5, 10, 1, 70);
select* from Countries;






--Which batsman has the most runs
SELECT TOP 1 p.Name AS Batsman,
       SUM(bs.RunsScored) AS TotalRuns
FROM Players p
JOIN BattingStats bs ON p.PlayerID = bs.PlayerID
GROUP BY p.Name
ORDER BY TotalRuns DESC;

--Which bowler has the most wickets?
SELECT TOP 1 p.Name AS Bowler,
       SUM(bs.WicketsTaken) AS TotalWickets
FROM Players p
JOIN BowlingStats bs ON p.PlayerID = bs.PlayerID
GROUP BY p.Name
ORDER BY TotalWickets DESC;

--Which country has the highest score in a single innings
SELECT TOP 1 c.CountryName AS Country,
       MAX(i.TotalRuns) AS HighestScore
FROM Countries c
JOIN Innings i ON c.CountryID = i.CountryID
GROUP BY c.CountryName
ORDER BY HighestScore DESC;



--Which country has the lowest score in a single innings
SELECT TOP 1 c.CountryName AS Country,
       MIN(i.TotalRuns) AS LowestScore
FROM Countries c
JOIN Innings i ON c.CountryID = i.CountryID
GROUP BY c.CountryName
ORDER BY LowestScore ASC;

--What is the highest score made by a batsman played at position 6
SELECT p.Name AS Batsman,
       MAX(bs.RunsScored) AS HighestScore
FROM Players p
JOIN BattingStats bs ON p.PlayerID = bs.PlayerID
WHERE p.Role = 'Batsman' AND p.PlayerID = 6
GROUP BY p.Name;


--What is the average score of Bangladesh
SELECT AVG(i.TotalRuns) AS AverageScore
FROM Innings i
JOIN Countries c ON i.CountryID = c.CountryID
WHERE c.CountryName = 'Bangladesh';



select * from Countries;
select *from Players,Innings,BattingStats;
