CREATE PROCEDURE RestoreProduct
    @ProductID INT
AS
BEGIN
    UPDATE Products
    SET IsDeleted = 0,
        LastModifiedAt = GETDATE(),
        LastModifiedBy = dbo.GetCurrentEmployeeID()
    WHERE ProductID = @ProductID;
END;