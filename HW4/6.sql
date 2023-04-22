CREATE FUNCTION GetDateAfterFourDays(@currentDate DATETIME)
RETURNS VARCHAR(10)
AS
BEGIN
    DECLARE @result VARCHAR(10)
    SET @result = DATENAME(weekday, DATEADD(day, 4, @currentDate))
    RETURN @result
END
