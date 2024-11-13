CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY IDENTITY(1,1),
    SupplierName VARCHAR(100) NOT NULL,
    SupplierAddress VARCHAR(200) NOT NULL,
    SupplierPhone VARCHAR(20) NOT NULL,
    SupplierContact VARCHAR(100) NOT NULL,
    IsDeleted BIT NOT NULL DEFAULT 0,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    LastModifiedAt DATETIME NULL,
    LastModifiedBy INT NULL
);

CREATE TABLE Materials (
    MaterialID INT PRIMARY KEY IDENTITY(1,1),
    MaterialName VARCHAR(100) NOT NULL,
    Unit VARCHAR(50) NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    IsDeleted BIT NOT NULL DEFAULT 0,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    LastModifiedAt DATETIME NULL,
    LastModifiedBy INT NULL
);

CREATE TABLE Warehouses (
    WarehouseID INT PRIMARY KEY IDENTITY(1,1),
    WarehouseName VARCHAR(100) NOT NULL,
    WarehouseAddress VARCHAR(200) NOT NULL,
    Capacity INT NOT NULL,
    IsDeleted BIT NOT NULL DEFAULT 0,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    LastModifiedAt DATETIME NULL,
    LastModifiedBy INT NULL
);

CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY IDENTITY(1,1),
    MaterialID INT REFERENCES Materials(MaterialID),
    WarehouseID INT REFERENCES Warehouses(WarehouseID),
    Quantity DECIMAL(10,2) NOT NULL,
    IsDeleted BIT NOT NULL DEFAULT 0,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    LastModifiedAt DATETIME NULL,
    LastModifiedBy INT NULL
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName VARCHAR(100) NOT NULL,
    Category VARCHAR(50) NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    Unit VARCHAR(50) NOT NULL,
    IsDeleted BIT NOT NULL DEFAULT 0,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    LastModifiedAt DATETIME NULL,
    LastModifiedBy INT NULL
);

CREATE TABLE ProductionOrders (
    ProductionOrderID INT PRIMARY KEY IDENTITY(1,1),
    OrderDate DATE NOT NULL,
    CompletionDate DATE NOT NULL,
    Quantity INT NOT NULL,
    ProductID INT REFERENCES Products(ProductID),
	Status VARCHAR(20) DEFAULT 'New' NOT NULL, CHECK (Status IN ('New', 'Scheduled', 'In Progress', 'Completed', 'Cancelled')),
    IsDeleted BIT NOT NULL DEFAULT 0,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    LastModifiedAt DATETIME NULL,
    LastModifiedBy INT NULL
);

CREATE TABLE ProductionLines (
    ProductionLineID INT PRIMARY KEY IDENTITY(1,1),
    ProductionLineName VARCHAR(100) NOT NULL,
    ProductID INT REFERENCES Products(ProductID),
    Capacity INT NOT NULL,
    IsDeleted BIT NOT NULL DEFAULT 0,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    LastModifiedAt DATETIME NULL,
    LastModifiedBy INT NULL
);

CREATE TABLE ProductionSchedules (
    ProductionScheduleID INT PRIMARY KEY IDENTITY(1,1),
    ProductionLineID INT REFERENCES ProductionLines(ProductionLineID),
    ProductionOrderID INT REFERENCES ProductionOrders(ProductionOrderID),
    StartDate DATETIME NOT NULL,
    EndDate DATETIME NOT NULL,
    IsDeleted BIT NOT NULL DEFAULT 0,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    LastModifiedAt DATETIME NULL,
    LastModifiedBy INT NULL
);

CREATE TABLE Machines (
    MachineID INT PRIMARY KEY IDENTITY(1,1),
    MachineName VARCHAR(100) NOT NULL,
    MachineType VARCHAR(50) NOT NULL,
    MachineStatus VARCHAR(20) NOT NULL,
    ProductionLineID INT REFERENCES ProductionLines(ProductionLineID),
    IsDeleted BIT NOT NULL DEFAULT 0,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    LastModifiedAt DATETIME NULL,
    LastModifiedBy INT NULL
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Position VARCHAR(50) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    WarehouseID INT REFERENCES Warehouses(WarehouseID),
    ProductionLineID INT REFERENCES ProductionLines(ProductionLineID),
    IsDeleted BIT NOT NULL DEFAULT 0,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    LastModifiedAt DATETIME NULL,
    LastModifiedBy INT NULL
);

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    CustomerName VARCHAR(100) NOT NULL,
    CustomerAddress VARCHAR(200) NOT NULL,
    CustomerPhone VARCHAR(20) NOT NULL,
    CustomerContact VARCHAR(100) NOT NULL,
    IsDeleted BIT NOT NULL DEFAULT 0,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    LastModifiedAt DATETIME NULL,
    LastModifiedBy INT NULL
);

CREATE TABLE CustomerOrders (
    CustomerOrderID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT REFERENCES Customers(CustomerID),
    OrderDate DATE NOT NULL,
    OrderStatus VARCHAR(20) NOT NULL,
    TotalAmount DECIMAL(10,2) NOT NULL,
    IsDeleted BIT NOT NULL DEFAULT 0,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    LastModifiedAt DATETIME NULL,
    LastModifiedBy INT NULL
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY IDENTITY(1,1),
    CustomerOrderID INT REFERENCES CustomerOrders(CustomerOrderID),
    ProductID INT REFERENCES Products(ProductID),
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    IsDeleted BIT NOT NULL DEFAULT 0,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    LastModifiedAt DATETIME NULL,
    LastModifiedBy INT NULL
);

CREATE TABLE Shipping (
    ShippingID INT PRIMARY KEY IDENTITY(1,1),
    CustomerOrderID INT REFERENCES CustomerOrders(CustomerOrderID),
    ShippingDate DATE NOT NULL,
    DeliveryDate DATE NOT NULL,
    ShippingStatus VARCHAR(20) NOT NULL,
    IsDeleted BIT NOT NULL DEFAULT 0,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    LastModifiedAt DATETIME NULL,
    LastModifiedBy INT NULL
);

CREATE TABLE TransportCompanies (
    TransportCompanyID INT PRIMARY KEY IDENTITY(1,1),
    CompanyName VARCHAR(100) NOT NULL,
    CompanyAddress VARCHAR(200) NOT NULL,
    CompanyPhone VARCHAR(20) NOT NULL,
    TransportType VARCHAR(50) NOT NULL,
    IsDeleted BIT NOT NULL DEFAULT 0,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    LastModifiedAt DATETIME NULL,
    LastModifiedBy INT NULL
);

CREATE TABLE Vehicles (
    VehicleID INT PRIMARY KEY IDENTITY(1,1),
    VehiclePlate VARCHAR(20) NOT NULL,
    VehicleType VARCHAR(50) NOT NULL,
	VehicleStatus VARCHAR(20) DEFAULT 'Available' NOT NULL, CHECK (VehicleStatus IN ('Available', 'Unavailable')),
    TransportCompanyID INT REFERENCES TransportCompanies(TransportCompanyID),
    IsDeleted BIT NOT NULL DEFAULT 0,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    LastModifiedAt DATETIME NULL,
    LastModifiedBy INT NULL
);

CREATE TABLE ShipmentTracking (
    ShipmentTrackingID INT PRIMARY KEY IDENTITY(1,1),
    ShippingID INT REFERENCES Shipping(ShippingID),
    TrackingDate DATETIME NOT NULL,
    Location VARCHAR(100) NOT NULL,
    Status VARCHAR(20) NOT NULL,
    IsDeleted BIT NOT NULL DEFAULT 0,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    LastModifiedAt DATETIME NULL,
    LastModifiedBy INT NULL
);

CREATE TABLE Invoices (
    InvoiceID INT PRIMARY KEY IDENTITY(1,1),
    CustomerOrderID INT REFERENCES CustomerOrders(CustomerOrderID),
    InvoiceDate DATE NOT NULL,
    InvoiceAmount DECIMAL(10,2) NOT NULL,
    PaymentStatus VARCHAR(20) NOT NULL,
    IsDeleted BIT NOT NULL DEFAULT 0,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    LastModifiedAt DATETIME NULL,
    LastModifiedBy INT NULL
);

CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT REFERENCES Customers(CustomerID),
    PaymentAmount DECIMAL(10,2) NOT NULL,
    PaymentDate DATE NOT NULL,
    PaymentMethod VARCHAR(50) NOT NULL,
    PaymentStatus VARCHAR(20) NOT NULL,
    IsDeleted BIT NOT NULL DEFAULT 0,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    LastModifiedAt DATETIME NULL,
    LastModifiedBy INT NULL
);

CREATE TABLE Returns (
    ReturnID INT PRIMARY KEY IDENTITY(1,1),
    CustomerOrderID INT REFERENCES CustomerOrders(CustomerOrderID),
    ProductID INT REFERENCES Products(ProductID),
    Quantity INT NOT NULL,
    ReturnReason VARCHAR(200) NOT NULL,
    ReturnDate DATE NOT NULL,
    IsDeleted BIT NOT NULL DEFAULT 0,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    LastModifiedAt DATETIME NULL,
    LastModifiedBy INT NULL
);

ALTER TABLE Suppliers ADD FOREIGN KEY (LastModifiedBy) REFERENCES Employees(EmployeeID);
ALTER TABLE Materials ADD FOREIGN KEY (LastModifiedBy) REFERENCES Employees(EmployeeID);
ALTER TABLE Warehouses ADD FOREIGN KEY (LastModifiedBy) REFERENCES Employees(EmployeeID);
ALTER TABLE Inventory ADD FOREIGN KEY (LastModifiedBy) REFERENCES Employees(EmployeeID);
ALTER TABLE Products ADD FOREIGN KEY (LastModifiedBy) REFERENCES Employees(EmployeeID);
ALTER TABLE ProductionOrders ADD FOREIGN KEY (LastModifiedBy) REFERENCES Employees(EmployeeID);
ALTER TABLE ProductionLines ADD FOREIGN KEY (LastModifiedBy) REFERENCES Employees(EmployeeID);
ALTER TABLE ProductionSchedules ADD FOREIGN KEY (LastModifiedBy) REFERENCES Employees(EmployeeID);
ALTER TABLE Machines ADD FOREIGN KEY (LastModifiedBy) REFERENCES Employees(EmployeeID);
ALTER TABLE Employees ADD FOREIGN KEY (LastModifiedBy) REFERENCES Employees(EmployeeID);
ALTER TABLE Customers ADD FOREIGN KEY (LastModifiedBy) REFERENCES Employees(EmployeeID);
ALTER TABLE CustomerOrders ADD FOREIGN KEY (LastModifiedBy) REFERENCES Employees(EmployeeID);
ALTER TABLE OrderDetails ADD FOREIGN KEY (LastModifiedBy) REFERENCES Employees(EmployeeID);
ALTER TABLE Shipping ADD FOREIGN KEY (LastModifiedBy) REFERENCES Employees(EmployeeID);
ALTER TABLE TransportCompanies ADD FOREIGN KEY (LastModifiedBy) REFERENCES Employees(EmployeeID);
ALTER TABLE Vehicles ADD FOREIGN KEY (LastModifiedBy) REFERENCES Employees(EmployeeID);
ALTER TABLE ShipmentTracking ADD FOREIGN KEY (LastModifiedBy) REFERENCES Employees(EmployeeID);
ALTER TABLE Invoices ADD FOREIGN KEY (LastModifiedBy) REFERENCES Employees(EmployeeID);
ALTER TABLE Payments ADD FOREIGN KEY (LastModifiedBy) REFERENCES Employees(EmployeeID);
ALTER TABLE Returns ADD FOREIGN KEY (LastModifiedBy) REFERENCES Employees(EmployeeID);