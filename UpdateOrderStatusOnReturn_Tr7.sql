CREATE TRIGGER UpdateOrderStatusOnReturn
ON Returns
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @CustomerOrderID INT, @ReturnStatus VARCHAR(20) = 'Returned'
    SELECT @CustomerOrderID = CustomerOrderID FROM inserted

    UPDATE CustomerOrders
    SET OrderStatus = @ReturnStatus
    WHERE CustomerOrderID = @CustomerOrderID
END