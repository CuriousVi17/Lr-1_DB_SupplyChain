CREATE FUNCTION GetShippingReport(@FromDate DATE, @ToDate DATE)
RETURNS TABLE
AS
RETURN
(
    SELECT s.ShippingID, s.CustomerOrderID, s.ShippingDate, s.DeliveryDate, s.ShippingStatus,
           c.CustomerName, p.ProductName, od.Quantity, od.UnitPrice
    FROM Shipping s
    JOIN CustomerOrders co ON s.CustomerOrderID = co.CustomerOrderID
    JOIN OrderDetails od ON co.CustomerOrderID = od.CustomerOrderID
    JOIN Products p ON od.ProductID = p.ProductID
    JOIN Customers c ON co.CustomerID = c.CustomerID
    WHERE s.ShippingDate BETWEEN @FromDate AND @ToDate
)