CREATE TRIGGER ProductsModified
ON Products
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE Products
    SET LastModifiedAt = GETDATE(),
        LastModifiedBy = dbo.GetCurrentEmployeeID()
    FROM Products p
    INNER JOIN inserted i ON p.ProductID = i.ProductID
    WHERE NOT (UPDATE(LastModifiedAt) OR UPDATE(LastModifiedBy))
          AND NOT (UPDATE(IsDeleted));
END;