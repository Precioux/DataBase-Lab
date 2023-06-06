CREATE FUNCTION GetUrlsAddedToday()
RETURNS INT
AS
BEGIN
    DECLARE @urlsAddedToday INT;
    
    SELECT @urlsAddedToday = COUNT(*) 
    FROM URL_table 
    WHERE CONVERT(DATE, submit_date) = CONVERT(DATE, GETDATE());
    
    RETURN @urlsAddedToday;
END;
