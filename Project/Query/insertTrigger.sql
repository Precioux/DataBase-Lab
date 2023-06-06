-- Create a DML trigger to print "URL added" after each INSERT operation
CREATE TRIGGER PrintURLAdded
ON URL
AFTER INSERT
AS
BEGIN
    PRINT 'URL added';
END;
