CREATE FUNCTION dbo.GetOriginalURL
(
    @shorten_url VARCHAR(30)
)
RETURNS VARCHAR(30)
AS
BEGIN
    DECLARE @original_url VARCHAR(30);

    -- Retrieve the original URL based on the shortened URL
    SELECT @original_url = original_url
    FROM URL
    WHERE shorten_url = @shorten_url;

    RETURN @original_url;
END
