CREATE FUNCTION GetTopProduct()
RETURNS TABLE
AS
RETURN
(
    SELECT TOP 1 p.ProductName, SUM(od.Quantity) AS TotalSold
    FROM Products p
    JOIN OrderDetails od ON p.ProductID = od.ProductID
    GROUP BY p.ProductName
    ORDER BY TotalSold DESC
)