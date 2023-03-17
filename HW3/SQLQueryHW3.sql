-- Question 1
CREATE TABLE Persons_table(
    P_Id int IDENTITY(1,1),
    LastName varchar(255) NOT NULL,
    FirstName varchar(255) NOT NULL,
    Address varchar(255),
    City varchar(255),
    CONSTRAINT PK_Persons_table PRIMARY KEY (LastName, FirstName)
);
INSERT INTO Persons_table (LastName, FirstName, Address, City)
VALUES ('Hansen', 'Ola', 'Timoteivn 10', 'Sandnes');
INSERT INTO Persons_table (LastName, FirstName, Address, City)
VALUES ('Svendson', 'Tove', 'Borgvn 23', 'Sandnes');
INSERT INTO Persons_table (LastName, FirstName, Address, City)
VALUES ('Pettersen', 'Kari', 'Storgt 20', 'Stavanger');
INSERT INTO Persons_table (LastName, FirstName, Address, City)
VALUES ('Nilsen', 'Tom', 'Vingvn 23', 'Stavanger');

-- a
SELECT *
FROM Persons_table
ORDER BY LastName ASC;

-- b
BEGIN TRANSACTION;

-- add PhoneNumber column that allows NULL values
ALTER TABLE Persons_table
ADD PhoneNumber nvarchar(6) NULL
    CONSTRAINT CHK_Persons_table_PhoneNumber CHECK (PhoneNumber LIKE '001%');
COMMIT;

-- update the PhoneNumber for the first four rows
UPDATE Persons_table
SET PhoneNumber = '001123'
WHERE P_Id = 1;

UPDATE Persons_table
SET PhoneNumber = '001124'
WHERE P_Id = 2;

UPDATE Persons_table
SET PhoneNumber = '001125'
WHERE P_Id = 3;

UPDATE Persons_table
SET PhoneNumber = '001126'
WHERE P_Id = 4;

--c
INSERT INTO Persons_table (LastName, FirstName, Address, City)
VALUES ('Doe', 'Jane', 'Fifth Square 42 Plaque', 'London');
INSERT INTO Persons_table (LastName, FirstName, Address, City)
VALUES ('Lee', 'David', 'Main Plaque Square 1', 'Seoul');

SELECT LastName, FirstName, Address
FROM Persons_table
WHERE Address LIKE '%Square%' AND Address LIKE '%Plaque%'
  AND CASE WHEN CHARINDEX('Square', Address) < CHARINDEX('Plaque', Address) 
           THEN 1 
           ELSE 0 
      END = 1;


--d
BEGIN TRANSACTION;

-- Add new data to table
INSERT INTO Persons_table (LastName, FirstName, Address, City, PhoneNumber)
VALUES ('Tjessem', 'Jakob', 'Nissetien 67', 'Sandnes','001127');

-- Show first three fields of table sorted by FirstName
SELECT FirstName, LastName, Address
FROM Persons_table
ORDER BY FirstName ASC;

COMMIT;

--e
BEGIN TRANSACTION;
-- Wait for 10 seconds
WAITFOR DELAY '00:00:10';

-- Select people who live in a city starting with 'S'
SELECT FirstName, LastName, City
FROM Persons_table
WHERE City LIKE 'S%';

COMMIT;

--f
-- Retrieve the last P_Id value and store it in the 'temp' variable
DECLARE @temp int;
SELECT TOP 1 @temp = P_Id FROM Persons_table ORDER BY P_Id DESC;

-- Print 'okay' as last P_Id value times
DECLARE @counter int = 1;
WHILE @counter <= @temp
BEGIN
PRINT 'okay';
SET @counter = @counter + 1;
END;