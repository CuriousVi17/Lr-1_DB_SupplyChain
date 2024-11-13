CREATE TRIGGER ProductsSoftDelete
ON Products
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE Products
    SET IsDeleted = 1,
        LastModifiedAt = GETDATE(),
        LastModifiedBy = dbo.GetCurrentEmployeeID()
    FROM Products p
    INNER JOIN deleted d ON p.ProductID = d.ProductID;
END;