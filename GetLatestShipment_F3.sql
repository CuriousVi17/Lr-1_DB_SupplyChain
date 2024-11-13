CREATE FUNCTION GetLatestShipment(@CustomerOrderID INT)
RETURNS TABLE
AS
RETURN
(
    SELECT TOP 1 *
    FROM Shipping
    WHERE CustomerOrderID = @CustomerOrderID
    ORDER BY ShippingDate DESC
)