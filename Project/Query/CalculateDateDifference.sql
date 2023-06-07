CREATE PROCEDURE CalculateDateDifference
    @current_date DATE,
    @expire_date DATE
AS
BEGIN
    SET NOCOUNT ON;

    SELECT DATEDIFF(day, @current_date, @expire_date) AS date_difference;
END;
