CREATE TRIGGER CustomerOrdersSoftDelete
ON CustomerOrders
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE CustomerOrders
    SET IsDeleted = 1,
        LastModifiedAt = GETDATE(),
        LastModifiedBy = dbo.GetCurrentEmployeeID()
    FROM CustomerOrders co
    INNER JOIN deleted d ON co.CustomerOrderID = d.CustomerOrderID;
END;