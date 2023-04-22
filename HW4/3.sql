CREATE PROCEDURE swapingNumbers
    @num1 int,
    @num2 int
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @temp int;
    SET @temp = @num1;
    SET @num1 = @num2;
    SET @num2 = @temp;
    SELECT @num1 AS 'Swapped Num1', @num2 AS 'Swapped Num2';
END

EXEC swapingNumbers @num1 = 123, @num2 = 24;
