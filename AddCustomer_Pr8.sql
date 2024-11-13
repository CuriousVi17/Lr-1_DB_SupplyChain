CREATE PROCEDURE AddCustomer
    @CustomerName VARCHAR(100),
    @CustomerAddress VARCHAR(200),
    @CustomerPhone VARCHAR(20),
    @CustomerContact VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Customers (CustomerName, CustomerAddress, CustomerPhone, CustomerContact)
    VALUES (@CustomerName, @CustomerAddress, @CustomerPhone, @CustomerContact)
END