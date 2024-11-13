CREATE FUNCTION GetTopSalesperson()
RETURNS TABLE
AS
RETURN
(
    SELECT TOP 1 e.FirstName, e.LastName, SUM(od.Quantity * od.UnitPrice) AS TotalSales
    FROM Employees e
    JOIN CustomerOrders co ON e.EmployeeID = co.CustomerID
    JOIN OrderDetails od ON co.CustomerOrderID = od.CustomerOrderID
    GROUP BY e.FirstName, e.LastName
    ORDER BY TotalSales DESC
)