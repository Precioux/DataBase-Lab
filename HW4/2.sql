CREATE PROCEDURE spUpdateGrades
  @num INT
AS
BEGIN
  DECLARE @count INT;
  SELECT @count = COUNT(*) FROM tblStudent WHERE stuGrade < 10;

  IF @count < @num
  BEGIN
    UPDATE tblStudent SET stuGrade = stuGrade + 1 WHERE stuGrade >= 9 AND stuGrade <= 10;
  END
  ELSE
  BEGIN
    UPDATE tblStudent SET stuGrade = stuGrade + 0.5 WHERE stuGrade >= 9.5 AND stuGrade <= 10;
  END

  SELECT * FROM tblStudent;
END

