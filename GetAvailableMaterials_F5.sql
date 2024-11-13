CREATE FUNCTION GetAvailableMaterials(@WarehouseID INT)
RETURNS TABLE
AS
RETURN
(
    SELECT m.MaterialID, m.MaterialName, m.Unit, m.UnitPrice, i.Quantity
    FROM Materials m
    LEFT JOIN Inventory i ON m.MaterialID = i.MaterialID AND i.WarehouseID = @WarehouseID
)