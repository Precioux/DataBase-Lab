CREATE PROCEDURE DropURLTable
AS
BEGIN
    SET NOCOUNT ON;

    IF OBJECT_ID('URL_table', 'U') IS NOT NULL
    BEGIN
        DROP TABLE URL_table;
        PRINT 'URL table dropped successfully';
    END
    ELSE
    BEGIN
        PRINT 'URL table does not exist';
    END
END;
