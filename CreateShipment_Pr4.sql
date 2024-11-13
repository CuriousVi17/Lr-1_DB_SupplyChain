CREATE PROCEDURE CreateShipment
    @CustomerOrderID INT,
    @ShippingDate DATE,
    @DeliveryDate DATE,
    @TransportCompanyID INT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Shipping (CustomerOrderID, ShippingDate, DeliveryDate, ShippingStatus)
    VALUES (@CustomerOrderID, @ShippingDate, @DeliveryDate, 'In Transit');

    DECLARE @ShippingID INT = SCOPE_IDENTITY();

    INSERT INTO ShipmentTracking (ShippingID, TrackingDate, Location, Status)
    VALUES (@ShippingID, @ShippingDate, 'Warehouse', 'Picked up');

    UPDATE Vehicles
    SET VehicleStatus = 'Assigned'
    WHERE TransportCompanyID = @TransportCompanyID;
END