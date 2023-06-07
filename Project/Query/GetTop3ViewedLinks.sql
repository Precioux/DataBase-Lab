CREATE PROCEDURE GetTop3ViewedLinks
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT TOP 3 original_url, shorten_url, url_view
    FROM dbo.Top3ViewedLinks;
END;
