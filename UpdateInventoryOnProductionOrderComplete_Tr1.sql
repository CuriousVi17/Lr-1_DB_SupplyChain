CREATE TRIGGER UpdateInventoryOnProductionOrderComplete
ON ProductionOrders
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF UPDATE(CompletionDate)
    BEGIN
        DECLARE @ProductID INT, @Quantity INT;

        SELECT @ProductID = ProductID, @Quantity = Quantity 
        FROM inserted;

        DECLARE @WarehouseID INT = (SELECT TOP 1 WarehouseID FROM Warehouses);
        DECLARE @MaterialID INT = (SELECT MaterialID FROM Materials WHERE MaterialID = @ProductID);

        EXEC AddInventory @WarehouseID, @MaterialID, @Quantity;
    END
END;
