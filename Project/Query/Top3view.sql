CREATE VIEW dbo.Top3ViewedLinks
AS
SELECT original_url, shorten_url, views
FROM URL
ORDER BY views DESC
OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY;
