CREATE FUNCTION dbo.GetRowsAddedToday()
RETURNS INT
AS
BEGIN
    DECLARE @RowsAddedToday INT;
    SET @RowsAddedToday = 0;

    SELECT @RowsAddedToday = COUNT(*)
    FROM view_table
    WHERE CAST(Increasing_date AS DATE) = CAST(GETDATE() AS DATE);

    RETURN @RowsAddedToday;
END;
