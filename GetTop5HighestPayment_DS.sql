CREATE VIEW vw_GetTop5HighestPayment AS
SELECT TOP 5 
    CustomerName,
    CustomerOrderID,
    SUM(TotalProductAmount) as OrderTotal
FROM vw_CustomerOrderDetails
GROUP BY CustomerName, CustomerOrderID
ORDER BY OrderTotal DESC;