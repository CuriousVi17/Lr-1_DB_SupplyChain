CREATE TRIGGER UpdateInventoryOnMaterialAdd
ON Materials
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @MaterialID INT
    SELECT @MaterialID = MaterialID FROM inserted

    INSERT INTO Inventory (MaterialID, WarehouseID, Quantity)
    SELECT @MaterialID, w.WarehouseID, 0
    FROM Warehouses w
END