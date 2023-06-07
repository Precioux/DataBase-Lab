CREATE PROCEDURE GetShortenURLByOriginalURL
    @original_url VARCHAR(30)
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT shorten_url
    FROM URL_table
    WHERE original_url = @original_url;
END
