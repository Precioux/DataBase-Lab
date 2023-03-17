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


