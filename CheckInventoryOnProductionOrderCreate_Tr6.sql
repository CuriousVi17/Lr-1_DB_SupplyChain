CREATE TRIGGER CheckInventoryOnProductionOrderCreate
ON ProductionOrders
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ProductID INT, @Quantity INT
    SELECT @ProductID = ProductID, @Quantity = Quantity FROM inserted

    IF EXISTS (
        SELECT 1 
        FROM Inventory i
        JOIN Materials m ON i.MaterialID = m.MaterialID
        WHERE m.MaterialID = @ProductID
        GROUP BY i.MaterialID
        HAVING SUM(i.Quantity) >= @Quantity
    )
    BEGIN
        INSERT INTO ProductionOrders (ProductID, Quantity, OrderDate, CompletionDate)
        SELECT ProductID, Quantity, OrderDate, CompletionDate FROM inserted
    END
    ELSE
    BEGIN
        RAISERROR('Insufficient inventory to create production order.', 16, 1)
    END
END