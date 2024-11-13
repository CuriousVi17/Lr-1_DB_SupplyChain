CREATE FUNCTION GetProductInfo(@ProductID INT)
RETURNS TABLE
AS
RETURN
(
    SELECT p.ProductID, p.ProductName, p.Category, p.UnitPrice, p.Unit,
           pl.ProductionLineID, pl.ProductionLineName, pl.Capacity
    FROM Products p
    LEFT JOIN ProductionLines pl ON p.ProductID = pl.ProductID
    WHERE p.ProductID = @ProductID
)