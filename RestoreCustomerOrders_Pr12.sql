CREATE PROCEDURE RestoreCustomerOrders
    @CustomerOrdersID INT
AS
BEGIN
    UPDATE CustomerOrders
    SET IsDeleted = 0,
        LastModifiedAt = GETDATE(),
        LastModifiedBy = dbo.GetCurrentEmployeeID()
    WHERE CustomerOrderID = @CustomerOrdersID;
END;