CREATE PROCEDURE UpdateProductInfo
    @ProductID INT,
    @ProductName VARCHAR(100) = NULL,
    @Category VARCHAR(50) = NULL,
    @UnitPrice DECIMAL(10,2) = NULL,
    @Unit VARCHAR(50) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Products
    SET ProductName = COALESCE(@ProductName, ProductName),
        Category = COALESCE(@Category, Category),
        UnitPrice = COALESCE(@UnitPrice, UnitPrice),
        Unit = COALESCE(@Unit, Unit)
    WHERE ProductID = @ProductID
END