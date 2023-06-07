CREATE PROCEDURE DeleteURL
    @shorten_url NVARCHAR(30)
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM URL_table
    WHERE shorten_url = @shorten_url;
    
    IF @@ROWCOUNT > 0
        PRINT 'URL deleted successfully';
    ELSE
        PRINT 'URL not found';
END;
