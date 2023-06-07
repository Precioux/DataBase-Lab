CREATE PROCEDURE GetURLDetails
AS
BEGIN
    SET NOCOUNT ON;

    SELECT shorten_url, submit_date, expire_date
    FROM URL_table;
END;
