CREATE VIEW vw_ProductionLineStatus AS
SELECT 
    pl.ProductionLineID,
    pl.ProductionLineName,
    p.ProductName,
    pl.Capacity AS LineCapacity,
    COUNT(DISTINCT m.MachineID) AS MachinesCount,
    COUNT(DISTINCT e.EmployeeID) AS EmployeesCount,
    COUNT(DISTINCT ps.ProductionScheduleID) AS ActiveSchedules
FROM ProductionLines pl
LEFT JOIN Products p ON pl.ProductID = p.ProductID
LEFT JOIN Machines m ON pl.ProductionLineID = m.ProductionLineID
LEFT JOIN Employees e ON pl.ProductionLineID = e.ProductionLineID
LEFT JOIN ProductionSchedules ps ON pl.ProductionLineID = ps.ProductionLineID
    AND ps.EndDate >= GETDATE()
GROUP BY 
    pl.ProductionLineID,
    pl.ProductionLineName,
    p.ProductName,
    pl.Capacity;
