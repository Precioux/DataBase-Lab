SELECT FirstName, LastName, PostalCode, RANK() OVER (PARTITION BY PostalCode ORDER BY LastName, FirstName) AS PostalCodeRank
FROM tblpost;
