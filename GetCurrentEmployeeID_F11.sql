CREATE FUNCTION GetCurrentEmployeeID()
RETURNS INT
AS
BEGIN
    DECLARE @EmployeeID INT;
    SELECT TOP 1 @EmployeeID = EmployeeID FROM Employees WHERE IsDeleted = 0;
    RETURN @EmployeeID;
END;