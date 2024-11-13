CREATE PROCEDURE CreateCustomerOrder
    @CustomerID INT,
    @OrderDate DATE,
    @TotalAmount DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO CustomerOrders (CustomerID, OrderDate, OrderStatus, TotalAmount)
    VALUES (@CustomerID, @OrderDate, 'New', @TotalAmount);

    RETURN SCOPE_IDENTITY();
END