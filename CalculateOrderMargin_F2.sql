CREATE FUNCTION CalculateOrderMargin(@CustomerOrderID INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @TotalRevenue DECIMAL(10,2) = (
        SELECT SUM(od.Quantity * od.UnitPrice) AS TotalRevenue
        FROM OrderDetails od
        JOIN CustomerOrders co ON od.CustomerOrderID = co.CustomerOrderID
        WHERE co.CustomerOrderID = @CustomerOrderID
    )

    DECLARE @TotalCost DECIMAL(10,2) = (
        SELECT SUM(p.UnitPrice * od.Quantity) AS TotalCost
        FROM OrderDetails od
        JOIN Products p ON od.ProductID = p.ProductID
        JOIN CustomerOrders co ON od.CustomerOrderID = co.CustomerOrderID
        WHERE co.CustomerOrderID = @CustomerOrderID
    )

    RETURN @TotalRevenue - @TotalCost
END