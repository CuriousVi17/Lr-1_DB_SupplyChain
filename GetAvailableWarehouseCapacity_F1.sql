CREATE FUNCTION GetAvailableWarehouseCapacity(@WarehouseID INT)
RETURNS INT
AS
BEGIN
    DECLARE @TotalCapacity INT = (SELECT Capacity FROM Warehouses WHERE WarehouseID = @WarehouseID)
    DECLARE @UsedCapacity INT = (SELECT SUM(Quantity) FROM Inventory WHERE WarehouseID = @WarehouseID)
    RETURN @TotalCapacity - @UsedCapacity
END