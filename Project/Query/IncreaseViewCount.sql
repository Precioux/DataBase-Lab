-- Creating a stored procedure to increase the view count
CREATE PROCEDURE IncreaseViewCount
    @shorten_url VARCHAR(30)
AS
BEGIN
    UPDATE URL
    SET views = views + 1
    WHERE shorten_url = @shorten_url;
END
