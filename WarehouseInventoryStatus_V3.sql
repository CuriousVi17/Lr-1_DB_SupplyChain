CREATE VIEW vw_WarehouseInventoryStatus AS
SELECT 
    w.WarehouseID,
    w.WarehouseName,
    m.MaterialName,
    i.Quantity,
    m.Unit,
    m.UnitPrice,
    i.Quantity * m.UnitPrice AS TotalValue,
    w.Capacity,
    COUNT(DISTINCT e.EmployeeID) AS EmployeesCount
FROM Warehouses w
LEFT JOIN Inventory i ON w.WarehouseID = i.WarehouseID
LEFT JOIN Materials m ON i.MaterialID = m.MaterialID
LEFT JOIN Employees e ON w.WarehouseID = e.WarehouseID
GROUP BY 
    w.WarehouseID,
    w.WarehouseName,
    m.MaterialName,
    i.Quantity,
    m.Unit,
    m.UnitPrice,
    w.Capacity;