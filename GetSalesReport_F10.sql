CREATE FUNCTION GetSalesReport(@FromDate DATE, @ToDate DATE)
RETURNS TABLE
AS
RETURN
(
    SELECT co.CustomerOrderID, c.CustomerName, p.ProductName, od.Quantity, od.UnitPrice,
           (od.Quantity * od.UnitPrice) AS TotalRevenue,
           dbo.CalculateOrderMargin(co.CustomerOrderID) AS Margin
    FROM CustomerOrders co
    JOIN OrderDetails od ON co.CustomerOrderID = od.CustomerOrderID
    JOIN Products p ON od.ProductID = p.ProductID
    JOIN Customers c ON co.CustomerID = c.CustomerID
    WHERE co.OrderDate BETWEEN @FromDate AND @ToDate
)