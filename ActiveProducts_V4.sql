CREATE VIEW vw_ActiveProducts AS
SELECT * FROM Products WHERE IsDeleted = 0;