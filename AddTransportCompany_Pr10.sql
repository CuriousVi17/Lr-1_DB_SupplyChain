CREATE PROCEDURE AddTransportCompany
    @CompanyName VARCHAR(100),
    @CompanyAddress VARCHAR(200),
    @CompanyPhone VARCHAR(20),
    @TransportType VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO TransportCompanies (CompanyName, CompanyAddress, CompanyPhone, TransportType)
    VALUES (@CompanyName, @CompanyAddress, @CompanyPhone, @TransportType)
END