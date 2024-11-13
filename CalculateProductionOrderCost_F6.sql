CREATE FUNCTION CalculateProductionOrderCost(@ProductionOrderID INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @TotalCost DECIMAL(10,2)
    SELECT @TotalCost = SUM(m.UnitPrice * i.Quantity)
    FROM ProductionOrders po
    JOIN Inventory i ON po.ProductID = i.MaterialID
    JOIN Materials m ON i.MaterialID = m.MaterialID
    WHERE po.ProductionOrderID = @ProductionOrderID
    GROUP BY po.ProductionOrderID
    RETURN @TotalCost
END