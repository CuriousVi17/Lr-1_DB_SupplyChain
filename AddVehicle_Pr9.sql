CREATE PROCEDURE AddVehicle
    @VehiclePlate VARCHAR(20),
    @VehicleType VARCHAR(50),
    @TransportCompanyID INT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Vehicles (VehiclePlate, VehicleType, TransportCompanyID, VehicleStatus)
    VALUES (@VehiclePlate, @VehicleType, @TransportCompanyID, 'Available')
END