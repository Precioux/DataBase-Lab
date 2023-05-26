BEGIN TRANSACTION;

-- Query 1
INSERT INTO Person (PersonID, FirstName, LastName, Address, City, Age)
VALUES (1, 'John', 'Doe', '123 Main St', 'New York', 30);

-- Query 2
INSERT INTO Person (PersonID, FirstName, LastName, Address, City, Age)
VALUES (2, 'Jane', 'Smith', '456 Elm St', 'Los Angeles', 25);

-- Query 3
INSERT INTO Person (PersonID, FirstName, LastName, Address, City, Age)
VALUES (3, 'Michael', 'Johnson', '789 Oak St', 'Chicago', 35);

-- Query 4
INSERT INTO Person (PersonID, FirstName, LastName, Address, City, Age)
VALUES (4, 'Emily', 'Williams', '321 Pine St', 'Houston', 28);

-- Query 5
INSERT INTO Person (PersonID, FirstName, LastName, Address, City, Age)
VALUES (5, 'Daniel', 'Brown', '654 Cedar St', 'San Francisco', 32);

-- Query 6
INSERT INTO Person (PersonID, FirstName, LastName, Address, City, Age)
VALUES (6, 'Olivia', 'Jones', '987 Maple St', 'Boston', 27);

-- Query 7
INSERT INTO Person (PersonID, FirstName, LastName, Address, City, Age)
VALUES (7, 'David', 'Davis', '555 Oak St', 'Seattle', 40);

-- Query 8
INSERT INTO Person (PersonID, FirstName, LastName, Address, City, Age)
VALUES (8, 'Sophia', 'Wilson', '777 Elm St', 'Miami', 23);

-- Query 9
INSERT INTO Person (PersonID, FirstName, LastName, Address, City, Age)
VALUES (9, 'Ethan', 'Taylor', '999 Pine St', 'Denver', 33);

COMMIT;
