CREATE PROCEDURE CreateProductionLine
    @ProductionLineName VARCHAR(100),
    @ProductID INT,
    @Capacity INT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO ProductionLines (ProductionLineName, ProductID, Capacity)
    VALUES (@ProductionLineName, @ProductID, @Capacity)
END