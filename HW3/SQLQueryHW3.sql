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
UPDATE Persons_table
SET Address = CASE
    WHEN P_Id = 1 THEN 'Tim Square Plaque 10'
    WHEN P_Id = 2 THEN 'Borg Square Plaque 23'
	WHEN P_Id = 3 THEN 'Stor Square Plaque 20'
	WHEN P_Id = 4 THEN 'Ving Square Plaque 23'
    ELSE Address -- if P_Id is not mentioned, keep the original Address
END;



--d
BEGIN TRANSACTION;

-- Add new data to table with P_Id = 7
-- Set identity insert to ON
SET IDENTITY_INSERT Persons_table ON

INSERT INTO Persons_table (P_Id, LastName,FirstName, Address, City, PhoneNumber)
VALUES (7,'Tjessem', 'Jakob', 'Nissetien 67', 'Sandnes','001127');

-- Show first three fields of table sorted by FirstName
SELECT FirstName, LastName, Address
FROM Persons_table
ORDER BY FirstName ASC;

COMMIT;

-- Set identity insert back to OFF
SET IDENTITY_INSERT Persons_table OFF

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

--g
-- Set identity insert to ON
SET IDENTITY_INSERT Persons_table ON

-- Check if the new phone number is lesser than Tjessem's
DECLARE @newPhoneNumber nvarchar(6) = '001567';
DECLARE @tjessemPhoneNumber nvarchar(6) = (
    SELECT PhoneNumber
    FROM Persons_table
    WHERE LastName = 'Tjessem'
);

IF @newPhoneNumber < @tjessemPhoneNumber
BEGIN
    -- Check if a data with P_Id=6 exists
    IF EXISTS (SELECT * FROM Persons_table WHERE P_Id = 6)
    BEGIN
        -- Replace the data with lesser phone number than Tjessem's
        UPDATE Persons_table
        SET LastName = 'Taylor',
            FirstName = 'Jackson',
            Address = 'Nisseisten87',
            City = 'Sandnes',
            PhoneNumber = @newPhoneNumber
        WHERE P_Id = 6 AND PhoneNumber < @tjessemPhoneNumber;
    END
    ELSE
    BEGIN
        -- Add the new data with P_Id=6
        INSERT INTO Persons_table (P_Id,LastName, FirstName, Address, City, PhoneNumber)
        VALUES (6, 'Taylor', 'Jackson', 'Nisseisten87', 'Sandnes', @newPhoneNumber);
    END
END
ELSE
BEGIN
    -- Add the new data with P_Id=8
    INSERT INTO Persons_table (P_Id, LastName,FirstName, Address, City, PhoneNumber)
    VALUES (8,'Taylor', 'Jackson', 'Nisseisten87', 'Sandnes', @newPhoneNumber);
END
-- Set identity insert back to OFF
SET IDENTITY_INSERT Persons_table OFF


--Question 2
CREATE TABLE Students(
    name varchar(255) NOT NULL,
    student_id int NOT NULL,
    grade int NOT NULL,
    CONSTRAINT PK_student_grades PRIMARY KEY (student_id)
);

INSERT INTO Students (name, student_id, grade)
VALUES ('R1', '8831047', 12);

INSERT INTO Students (name, student_id, grade)
VALUES ('R2', '8831043', 10);

INSERT INTO Students (name, student_id, grade)
VALUES ('R3', '8831031', 15);

INSERT INTO Students (name, student_id, grade)
VALUES ('R4', '8831051', 16);

INSERT INTO Students (name, student_id, grade)
VALUES ('R1', '8831012', 11);

-- Update the grades and return old and new grades using OUTPUT command
UPDATE Students
SET grade = grade + 2
OUTPUT inserted.name, deleted.grade AS old_grade, inserted.grade AS new_grade
WHERE grade < 15;

