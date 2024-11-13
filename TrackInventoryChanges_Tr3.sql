CREATE TRIGGER TrackInventoryChanges
ON Inventory
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @WarehouseID INT, @MaterialID INT, @Quantity DECIMAL(10,2), @ChangeType VARCHAR(10)
    IF EXISTS(SELECT 1 FROM inserted)
    BEGIN
        SELECT @WarehouseID = WarehouseID, @MaterialID = MaterialID, @Quantity = Quantity, @ChangeType = 'Added'
        FROM inserted
    END
    ELSE
    BEGIN
        SELECT @WarehouseID = WarehouseID, @MaterialID = MaterialID, @Quantity = Quantity, @ChangeType = 'Removed' 
        FROM deleted
    END

    INSERT INTO InventoryChanges (WarehouseID, MaterialID, Quantity, ChangeType, ChangeDate)
    VALUES (@WarehouseID, @MaterialID, @Quantity, @ChangeType, GETDATE())
END