CREATE TABLE ExampleTable (
    ID INT,
    Name VARCHAR(50)
);

SELECT * FROM AuditTable;


-- Sample table before alteration
CREATE TABLE Example2Table (
    ID INT,
    Name VARCHAR(50)
);

-- Perform ALTER TABLE operation
ALTER TABLE Example2Table
ADD Age INT;

-- The DDL trigger will log the alteration in the AuditTable

-- Retrieve the logs from the AuditTable
SELECT * FROM AuditTable;

-- Assuming the AuditTable and AuditTrigger are already created as mentioned before

-- Sample table before deletion
CREATE TABLE Example3Table (
    ID INT,
    Name VARCHAR(50)
);

-- Perform DROP TABLE operation
DROP TABLE Example3Table;

-- The DDL trigger will log the deletion in the AuditTable

-- Retrieve the logs from the AuditTable
SELECT * FROM AuditTable;
