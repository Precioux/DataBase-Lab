CREATE FUNCTION getGradeByName
    (@name varchar(10))
RETURNS real
AS
BEGIN
    DECLARE @grade real;
    SELECT @grade = stuGrade FROM tblstudent WHERE stuName = @name;
    RETURN @grade;
END

