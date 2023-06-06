CREATE VIEW dbo.Top3ViewedLinks
AS
SELECT original_url, shorten_url, url_view
FROM URL_table
ORDER BY url_view DESC
OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY;
