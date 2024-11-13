CREATE PROCEDURE AddPayment
    @CustomerID INT,
    @PaymentAmount DECIMAL(10,2),
    @PaymentDate DATE,
    @PaymentMethod VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Payments (CustomerID, PaymentAmount, PaymentDate, PaymentMethod, PaymentStatus)
    VALUES (@CustomerID, @PaymentAmount, @PaymentDate, @PaymentMethod, 'Pending');
END