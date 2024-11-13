CREATE TRIGGER CustomerOrdersModified
ON CustomerOrders
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE CustomerOrders
    SET LastModifiedAt = GETDATE(),
        LastModifiedBy = dbo.GetCurrentEmployeeID()
    FROM CustomerOrders co
    INNER JOIN inserted i ON co.CustomerOrderID = i.CustomerOrderID
    WHERE NOT (UPDATE(LastModifiedAt) OR UPDATE(LastModifiedBy))
          AND NOT (UPDATE(IsDeleted));
END;