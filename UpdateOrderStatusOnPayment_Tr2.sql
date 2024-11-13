CREATE TRIGGER UpdateOrderStatusOnPayment
ON Payments
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @CustomerOrderID INT, @PaymentStatus VARCHAR(20)
    SELECT @CustomerOrderID = co.CustomerOrderID, @PaymentStatus = 'Paid'
    FROM inserted i
    JOIN Customers c ON i.CustomerID = c.CustomerID
    JOIN CustomerOrders co ON c.CustomerID = co.CustomerID

    UPDATE CustomerOrders
    SET OrderStatus = @PaymentStatus
    WHERE CustomerOrderID = @CustomerOrderID
END