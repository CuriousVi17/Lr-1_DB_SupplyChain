CREATE TRIGGER UpdateVehicleStatusOnDelivery
ON Shipping
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF UPDATE(DeliveryDate)
    BEGIN
        DECLARE @TransportCompanyID INT
        SELECT @TransportCompanyID = tc.TransportCompanyID
        FROM inserted i
        JOIN Shipping s ON i.ShippingID = s.ShippingID
        JOIN Vehicles v ON s.ShippingID = v.VehicleID
        JOIN TransportCompanies tc ON v.TransportCompanyID = tc.TransportCompanyID

        UPDATE Vehicles
        SET VehicleStatus = 'Available'
        WHERE TransportCompanyID = @TransportCompanyID
    END
END