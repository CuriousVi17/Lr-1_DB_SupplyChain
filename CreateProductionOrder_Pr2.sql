CREATE PROCEDURE CreateProductionOrder
    @ProductID INT,
    @Quantity INT,
    @OrderDate DATE,
    @CompletionDate DATE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO ProductionOrders (ProductID, Quantity, OrderDate, CompletionDate)
    VALUES (@ProductID, @Quantity, @OrderDate, @CompletionDate);
END