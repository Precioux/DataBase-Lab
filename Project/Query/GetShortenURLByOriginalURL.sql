CREATE PROCEDURE GetShortenURLByOriginalURL
    @original_url NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT shorten_url
    FROM URL_table
    WHERE original_url = @original_url;
END
