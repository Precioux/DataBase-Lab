CREATE TABLE LogTable (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    EventType VARCHAR(50),
    DateTime DATETIME,
    UserName VARCHAR(50),
    DatabaseName VARCHAR(50),
    SchemeName VARCHAR(50),
    TSQLCommand NVARCHAR(MAX)
);


