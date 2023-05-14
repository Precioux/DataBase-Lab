CREATE TRIGGER dropPreventTrigger 
ON DATABASE 
FOR DROP_TABLE 
AS 
BEGIN
   IF EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Book') AND type = 'U')
   BEGIN
      PRINT 'You must disable Trigger "drop_safe" to drop table!'
      ROLLBACK
   END
END;

DROP TABLE Book;
