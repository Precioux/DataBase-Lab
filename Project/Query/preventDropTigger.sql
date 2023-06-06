-- Create a DDL trigger to prevent dropping the URL table
CREATE TRIGGER PreventDropURLTable
ON DATABASE
FOR DROP_TABLE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @TableName NVARCHAR(128);
    SET @TableName = EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]', 'NVARCHAR(128)');

    IF @TableName = 'URL_table'
    BEGIN
        RAISERROR('Dropping the URL table is not allowed.', 16, 1);
        ROLLBACK;
    END;
END;
