-- Start an implicit transaction
BEGIN TRANSACTION;

-- UPDATE query on the Person table
UPDATE Person
SET FirstName = 'UpdatedFirstName'
WHERE PersonID = 1;

-- SELECT query to retrieve the count of active transactions
DECLARE @TransactionCount INT;
SET @TransactionCount = @@TRANCOUNT;

-- Display the output in the desired format
SELECT CAST(@TransactionCount AS NVARCHAR(10)) AS TransactionCount;

-- Commit the transaction
COMMIT;
