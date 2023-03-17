CREATE TABLE Persons (
    P_Id int IDENTITY(1,1),
    LastName varchar(255) NOT NULL,
    FirstName varchar(255) NOT NULL,
    Address varchar(255),
    City varchar(255),
    CONSTRAINT PK_Persons PRIMARY KEY (LastName, FirstName)
);
INSERT INTO Persons (LastName, FirstName, Address, City)
VALUES ('Hansen', 'Ola', 'Timoteivn 10', 'Sandnes');
INSERT INTO Persons (LastName, FirstName, Address, City)
VALUES ('Svendson', 'Tove', 'Borgvn 23', 'Sandnes');
INSERT INTO Persons (LastName, FirstName, Address, City)
VALUES ('Pettersen', 'Kari', 'Storgt 20', 'Stavanger');
INSERT INTO Persons (LastName, FirstName, Address, City)
VALUES ('Nilsen', 'Tom', 'Vingvn 23', 'Stavanger');


