CREATE TRIGGER CreateShipmentTrackingOnShipment
ON Shipping
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ShippingID INT
    SELECT @ShippingID = ShippingID FROM inserted

    INSERT INTO ShipmentTracking (ShippingID, TrackingDate, Location, Status)
    VALUES (@ShippingID, (SELECT ShippingDate FROM inserted), 'Warehouse', 'Picked up')
END