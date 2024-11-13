CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY,
    SupplierName VARCHAR(100) NOT NULL,
    SupplierAddress VARCHAR(200) NOT NULL,
    SupplierPhone VARCHAR(20) NOT NULL,
    SupplierContact VARCHAR(100) NOT NULL
);

CREATE TABLE Materials (
    MaterialID INT PRIMARY KEY,
    MaterialName VARCHAR(100) NOT NULL,
    Unit VARCHAR(50) NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL
);

CREATE TABLE Warehouses (
    WarehouseID INT PRIMARY KEY,
    WarehouseName VARCHAR(100) NOT NULL,
    WarehouseAddress VARCHAR(200) NOT NULL,
    Capacity INT NOT NULL
);

CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY,
    MaterialID INT FOREIGN KEY REFERENCES Materials(MaterialID),
    WarehouseID INT FOREIGN KEY REFERENCES Warehouses(WarehouseID),
    Quantity DECIMAL(10,2) NOT NULL
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Category VARCHAR(50) NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    Unit VARCHAR(50) NOT NULL
);

CREATE TABLE ProductionOrders (
    ProductionOrderID INT PRIMARY KEY,
    OrderDate DATE NOT NULL,
    CompletionDate DATE NOT NULL,
    Quantity INT NOT NULL,
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID)
);

CREATE TABLE ProductionLines (
    ProductionLineID INT PRIMARY KEY,
    ProductionLineName VARCHAR(100) NOT NULL,
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
    Capacity INT NOT NULL
);

CREATE TABLE ProductionSchedules (
    ProductionScheduleID INT PRIMARY KEY,
    ProductionLineID INT FOREIGN KEY REFERENCES ProductionLines(ProductionLineID),
    ProductionOrderID INT FOREIGN KEY REFERENCES ProductionOrders(ProductionOrderID),
    StartDate DATETIME NOT NULL,
    EndDate DATETIME NOT NULL
);

CREATE TABLE Machines (
    MachineID INT PRIMARY KEY,
    MachineName VARCHAR(100) NOT NULL,
    MachineType VARCHAR(50) NOT NULL,
    MachineStatus VARCHAR(20) NOT NULL,
    ProductionLineID INT FOREIGN KEY REFERENCES ProductionLines(ProductionLineID)
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Position VARCHAR(50) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    WarehouseID INT FOREIGN KEY REFERENCES Warehouses(WarehouseID),
    ProductionLineID INT FOREIGN KEY REFERENCES ProductionLines(ProductionLineID)
);

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    CustomerAddress VARCHAR(200) NOT NULL,
    CustomerPhone VARCHAR(20) NOT NULL,
    CustomerContact VARCHAR(100) NOT NULL
);

CREATE TABLE CustomerOrders (
    CustomerOrderID INT PRIMARY KEY,
    CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID),
    OrderDate DATE NOT NULL,
    OrderStatus VARCHAR(20) NOT NULL,
    TotalAmount DECIMAL(10,2) NOT NULL
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    CustomerOrderID INT FOREIGN KEY REFERENCES CustomerOrders(CustomerOrderID),
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL
);

CREATE TABLE Shipping (
    ShippingID INT PRIMARY KEY,
    CustomerOrderID INT FOREIGN KEY REFERENCES CustomerOrders(CustomerOrderID),
    ShippingDate DATE NOT NULL,
    DeliveryDate DATE NOT NULL,
    ShippingStatus VARCHAR(20) NOT NULL
);

CREATE TABLE TransportCompanies (
    TransportCompanyID INT PRIMARY KEY,
    CompanyName VARCHAR(100) NOT NULL,
    CompanyAddress VARCHAR(200) NOT NULL,
    CompanyPhone VARCHAR(20) NOT NULL,
    TransportType VARCHAR(50) NOT NULL
);

CREATE TABLE Vehicles (
    VehicleID INT PRIMARY KEY,
    VehiclePlate VARCHAR(20) NOT NULL,
    VehicleType VARCHAR(50) NOT NULL,
    TransportCompanyID INT FOREIGN KEY REFERENCES TransportCompanies(TransportCompanyID)
);

CREATE TABLE ShipmentTracking (
    ShipmentTrackingID INT PRIMARY KEY,
    ShippingID INT FOREIGN KEY REFERENCES Shipping(ShippingID),
    TrackingDate DATETIME NOT NULL,
    Location VARCHAR(100) NOT NULL,
    Status VARCHAR(20) NOT NULL
);

CREATE TABLE Invoices (
    InvoiceID INT PRIMARY KEY,
    CustomerOrderID INT FOREIGN KEY REFERENCES CustomerOrders(CustomerOrderID),
    InvoiceDate DATE NOT NULL,
    InvoiceAmount DECIMAL(10,2) NOT NULL,
    PaymentStatus VARCHAR(20) NOT NULL
);

CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID),
    PaymentAmount DECIMAL(10,2) NOT NULL,
    PaymentDate DATE NOT NULL,
    PaymentMethod VARCHAR(50) NOT NULL,
    PaymentStatus VARCHAR(20) NOT NULL
);

CREATE TABLE Returns (
    ReturnID INT PRIMARY KEY,
    CustomerOrderID INT FOREIGN KEY REFERENCES CustomerOrders(CustomerOrderID),
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
    Quantity INT NOT NULL,
    ReturnReason VARCHAR(200) NOT NULL,
    ReturnDate DATE NOT NULL
);