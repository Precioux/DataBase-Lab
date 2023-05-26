
BEGIN TRANSACTION;

-- Step 6: Start a transaction and save it with a custom name
INSERT INTO Person (PersonID, FirstName, LastName, Address, City, Age)
VALUES (1, 'John', 'Doe', '123 Main St', 'New York', 30);
SAVE TRANSACTION MySavepoint;

-- Step 7: Delete a record from the Person table within the ongoing transaction
DELETE FROM Person WHERE PersonID = 1;

-- Step 8
SELECT * FROM Person;

-- Step 9: Rollback the transaction to the savepoint
ROLLBACK TRANSACTION MySavepoint;

-- Step 10: Commit the current transaction and select all records from the Person table
COMMIT;

SELECT * FROM Person;