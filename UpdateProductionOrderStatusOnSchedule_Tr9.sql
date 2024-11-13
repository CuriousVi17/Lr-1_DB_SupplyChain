CREATE TRIGGER UpdateProductionOrderStatusOnSchedule
ON ProductionSchedules
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ProductionOrderID INT, @CompletionDate DATE
    SELECT @ProductionOrderID = po.ProductionOrderID, @CompletionDate = ps.EndDate
    FROM inserted ps
    JOIN ProductionOrders po ON ps.ProductionOrderID = po.ProductionOrderID

    UPDATE ProductionOrders
    SET CompletionDate = @CompletionDate,
        Status = 'Scheduled'
    WHERE ProductionOrderID = @ProductionOrderID
END
