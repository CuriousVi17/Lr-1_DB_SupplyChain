CREATE VIEW vw_CustomerOrderDetails AS
SELECT 
    co.CustomerOrderID,
    c.CustomerName,
    c.CustomerPhone,
    p.ProductName,
    od.Quantity,
    od.UnitPrice,
    od.Quantity * od.UnitPrice AS TotalProductAmount,
    co.OrderDate,
    co.OrderStatus,
    s.ShippingDate,
    s.DeliveryDate,
    s.ShippingStatus
FROM CustomerOrders co
JOIN Customers c ON co.CustomerID = c.CustomerID
JOIN OrderDetails od ON co.CustomerOrderID = od.CustomerOrderID
JOIN Products p ON od.ProductID = p.ProductID
LEFT JOIN Shipping s ON co.CustomerOrderID = s.CustomerOrderID;
