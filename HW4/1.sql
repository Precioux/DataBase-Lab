CREATE PROCEDURE spCalculateClassStatus
AS
BEGIN
  SELECT 
    CASE 
      WHEN COUNT(CASE WHEN stuGrade < 10 THEN 1 END) <= 1 THEN 'GOOD'
      WHEN COUNT(CASE WHEN stuGrade < 10 THEN 1 END) BETWEEN 2 AND 3 THEN 'Normal'
      ELSE 'Bad'
    END AS ClassStatus
  FROM tblstudent;
END

EXEC spCalculateClassStatus;




