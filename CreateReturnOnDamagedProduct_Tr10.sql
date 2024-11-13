CREATE TRIGGER CreateReturnOnDamagedProduct
ON Inventory
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @WarehouseID INT, @MaterialID INT, @Quantity DECIMAL(10,2)
    SELECT @WarehouseID = WarehouseID, @MaterialID = MaterialID, @Quantity = Quantity 
    FROM deleted
    WHERE Quantity < 0

    IF @Quantity < 0
    BEGIN
        DECLARE @CustomerOrderID INT = (
            SELECT TOP 1 CustomerOrderID
            FROM OrderDetails od
            JOIN Products p ON od.ProductID = p.ProductID
            WHERE p.ProductID = @MaterialID
            ORDER BY od.CustomerOrderID DESC
        )

        INSERT INTO Returns (CustomerOrderID, ProductID, Quantity, ReturnReason, ReturnDate)
        VALUES (@CustomerOrderID, @MaterialID, ABS(@Quantity), 'Damaged Product', GETDATE())
    END
END