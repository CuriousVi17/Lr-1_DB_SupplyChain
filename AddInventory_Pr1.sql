CREATE PROCEDURE AddInventory
    @WarehouseID INT,
    @MaterialID INT,
    @Quantity DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (SELECT 1 FROM Inventory WHERE WarehouseID = @WarehouseID AND MaterialID = @MaterialID)
    BEGIN
        UPDATE Inventory
        SET Quantity = Quantity + @Quantity
        WHERE WarehouseID = @WarehouseID AND MaterialID = @MaterialID;
    END
    ELSE
    BEGIN
        INSERT INTO Inventory (WarehouseID, MaterialID, Quantity)
        VALUES (@WarehouseID, @MaterialID, @Quantity);
    END
END