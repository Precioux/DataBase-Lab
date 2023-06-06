-- Create a DML trigger to print "View updated" after each UPDATE operation
CREATE TRIGGER PrintViewUpdated
ON URL
AFTER UPDATE
AS
BEGIN
    PRINT 'View updated';
END;


DISABLE TRIGGER PrintViewUpdated ON URL;


SELECT name, object_name(parent_id) AS table_name
FROM sys.triggers;
