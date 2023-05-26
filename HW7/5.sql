-- Start an explicit transaction
BEGIN TRANSACTION;

-- UPDATE query on the Person table
UPDATE Person
SET FirstName = 'UpdatedFirstName'
WHERE PersonID = 1;

-- Commit the explicit transaction
COMMIT;

-- Start a new explicit transaction
BEGIN TRANSACTION;

-- SELECT query to retrieve the count of active transactions
DECLARE @TransactionCount INT;
SET @TransactionCount = @@TRANCOUNT;

-- Display the output in the desired format
SELECT CAST(@TransactionCount AS NVARCHAR(10)) AS TransactionCount;

-- Commit the second explicit transaction
COMMIT;
