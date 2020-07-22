PRAGMA foreign_keys = ON;

CREATE TABLE Company (
Id INTEGER PRIMARY KEY AUTOINCREMENT,
Name VARCHAR(255) NOT NULL,
CountryOfOrigin VARCHAR(255),
CONSTRAINT UK_Name UNIQUE(Name)
);

CREATE TABLE Warehouse (
Id INTEGER PRIMARY KEY AUTOINCREMENT,
Name VARCHAR(255) NOT NULL,
Location VARCHAR(255) NOT NULL,
Owner VARCHAR(255) NOT NULL,
Size INTEGER,
CONSTRAINT UK_Name_Location UNIQUE(Name, Location),
CONSTRAINT FK_Warehouse_Owner_2_Company_Name FOREIGN KEY (Owner) REFERENCES Company(Name)
);

CREATE TABLE ShippingLocation (
Id INTEGER PRIMARY KEY AUTOINCREMENT,
Name VARCHAR(255) NOT NULL,
CONSTRAINT UK_Location UNIQUE(Name)
);

CREATE TABLE WarehouseShippingLocation(
Id INTEGER PRIMARY KEY AUTOINCREMENT,
WarehouseId INTEGER NOT NULL,
ShippingLocationId INTEGER NOT NULL,
CONSTRAINT FK_WarehouseShippingLocation_WarehouseId_2_Warehouse_Id FOREIGN KEY (WarehouseId) REFERENCES Warehouse(Id),
CONSTRAINT FK_WarehouseShippingLocation_ShippingLocationId_2_ShippingLocation_Id FOREIGN KEY (ShippingLocationId) REFERENCES ShippingLocation(Id)
);

CREATE TABLE Item (
Id INTEGER PRIMARY KEY AUTOINCREMENT,
Name VARCHAR(255) NOT NULL,
Msrp DECIMAL(8,2) NULL,
ExpiryDate DATE NULL,
CONSTRAINT UK_Name UNIQUE(Name)
);

CREATE TABLE Type(
Id INTEGER PRIMARY KEY AUTOINCREMENT,
Name VARCHAR(255) NOT NULL,
CONSTRAINT UK_Type UNIQUE(Name)
);

CREATE TABLE ItemType(
Id INTEGER PRIMARY KEY AUTOINCREMENT,
ItemId INTEGER NOT NULL,
TypeId INTEGER NOT NULL,
CONSTRAINT FK_ItemType_ItemId_2_Item_Id FOREIGN KEY (ItemId) REFERENCES Item(Id),
CONSTRAINT FK_ItemType_TypeId_2_Type_Id FOREIGN KEY (TypeId) REFERENCES Type(Id)
);

CREATE TABLE WarehouseItem(
Id INTEGER PRIMARY KEY AUTOINCREMENT,
WarehouseId INTEGER NOT NULL,
ItemId INTEGER NOT NULL,
Quantity INTEGER NOT NULL,
CONSTRAINT FK_WarehouseItem_WarehouseId_2_Warehouse_Id  FOREIGN KEY (WarehouseId) REFERENCES Warehouse(Id),
CONSTRAINT FK_WarehouseItem_ItemId_2_Item_Id FOREIGN KEY (ItemId) REFERENCES Item(Id)
);

CREATE TABLE Vehicle(
Id INTEGER PRIMARY KEY AUTOINCREMENT,
PlateNumber CHAR(8) NOT NULL,
Owner VARCHAR(255) NOT NULL,
ActiveServiceLife INTEGER,
VehicleType VARCHAR(255),
Capacity INTEGER,
Manufacturer VARCHAR(255),
Model VARCHAR(255),

CONSTRAINT UK_PlateNumber UNIQUE(PlateNUmber),
CONSTRAINT FK_Vehicle_Owner_2_Company_Name FOREIGN KEY (Owner) REFERENCES Company(Name)
);

CREATE TABLE Store(
Id INTEGER PRIMARY KEY AUTOINCREMENT,
Owner VARCHAR(255),
Name VARCHAR(255) NOT NULL,
Location VARCHAR(255) NOT NULL,
CONSTRAINT UK_Name_Location UNIQUE(Name, Location),
CONSTRAINT FK_Store_Owner_2_Company_Name FOREIGN KEY (Owner) REFERENCES Company(Name)
);

CREATE TABLE StoreItem(
Id INTEGER PRIMARY KEY AUTOINCREMENT,
StoreId INTEGER NOT NULL,
ItemId INTEGER NOT NULL,
Quantity INTEGER NOT NULL,
CONSTRAINT FK_StoreItem_StoreId_2_Store_Id FOREIGN KEY (StoreId) REFERENCES Store(Id),
CONSTRAINT FK_StoreItem_ItemId_2_Item_Id FOREIGN KEY (ItemId) REFERENCES Item(Id)
);


INSERT INTO Company(Name, CountryOfOrigin) VALUES ('Tru Kids, Inc', 'US');
INSERT INTO Company(Name, CountryOfOrigin) VALUES ('Food Company', 'US');
INSERT INTO Company(Name, CountryOfOrigin) VALUES ('Automobile Company', 'US');
INSERT INTO Company(Name, CountryOfOrigin) VALUES ('Walmart', 'US');
INSERT INTO Company(Name, CountryOfOrigin) VALUES ('Hudsons Bay', 'CAN');
INSERT INTO Company(Name, CountryOfOrigin) VALUES ('Lowes', 'US');
INSERT INTO Company(Name, CountryOfOrigin) VALUES ('McDonalds Co', 'US');
INSERT INTO Company(Name, CountryOfOrigin) VALUES ('Jeans Company', 'ENG');
INSERT INTO Company(Name, CountryOfOrigin) VALUES ('Indigo Books & Music Inc', 'CAN');
INSERT INTO Company(Name, CountryOfOrigin) VALUES ('Storage Company', 'AUS');

INSERT INTO Store(Owner, Name, Location) VALUES ('Tru Kids, Inc', 'Toys R Us', 'New York');
INSERT INTO Store(Owner, Name, Location) VALUES ('Walmart', 'Walmart', 'Toronto');
INSERT INTO Store(Owner, Name, Location) VALUES ('Zellers', 'Hudsons Bay', 'Toronto');
INSERT INTO Store(Owner, Name, Location) VALUES ('Rona', 'Lowes', 'Mississauga');
INSERT INTO Store(Owner, Name, Location) VALUES ('McDonalds', 'McDonalds Co', 'Toronto');
INSERT INTO Store(Owner, Name, Location) VALUES ('McDonalds', 'McDonalds Co', 'New York');
INSERT INTO Store(Owner, Name, Location) VALUES ('McDonalds', 'McDonalds Co', 'Ottawa');
INSERT INTO Store(Owner, Name, Location) VALUES ('CarPlace', 'Automobile Company', 'Toronto');
INSERT INTO Store(Owner, Name, Location) VALUES ('Walmart', 'Walmart', 'Ottawa');
INSERT INTO Store(Owner, Name, Location) VALUES ('Indigo Books & Music Inc', 'Indigos', 'Mississauga');

INSERT INTO ShippingLocation(Name) VALUES ('Toronto'); 
INSERT INTO ShippingLocation(Name) VALUES ('Mississauga');
INSERT INTO ShippingLocation(Name) VALUES ('New York City');
INSERT INTO ShippingLocation(Name) VALUES ('Montreal');
INSERT INTO ShippingLocation(Name) VALUES ('Kitchener');
INSERT INTO ShippingLocation(Name) VALUES ('Malton');
INSERT INTO ShippingLocation(Name) VALUES ('York');
INSERT INTO ShippingLocation(Name) VALUES ('Trent');
INSERT INTO ShippingLocation(Name) VALUES ('Vaughn');
INSERT INTO ShippingLocation(Name) VALUES ('Caledon');

INSERT INTO Warehouse(Name, Location, Owner, Size) VALUES ('warehouse1','New York City', 'Tru Kids, Inc', 200000);
INSERT INTO Warehouse(Name, Location, Owner, Size) VALUES ('warehouse2', 'Toronto', 'Storage Company', 11000);
INSERT INTO Warehouse(Name, Location, Owner, Size) VALUES ('warehouse3', 'Mississauga', 'Storage Company', 10000);
INSERT INTO Warehouse(Name, Location, Owner, Size) VALUES ('warehouse4', 'Montreal', 'Storage Company', 8000);
INSERT INTO Warehouse(Name, Location, Owner, Size) VALUES ('warehouse5', 'Kitchener', 'Storage Company', 250000);
INSERT INTO Warehouse(Name, Location, Owner, Size) VALUES ('warehouse6', 'Malton', 'Storage Company', 10000);
INSERT INTO Warehouse(Name, Location, Owner, Size) VALUES ('warehouse7', 'Toronto', 'Storage Company', 12000);
INSERT INTO Warehouse(Name, Location, Owner, Size) VALUES ('warehouse8', 'Vaughn', 'Storage Company', 10000);
INSERT INTO Warehouse(Name, Location, Owner, Size) VALUES ('warehouse9', 'New York City', 'Storage Company', 10000);
INSERT INTO Warehouse(Name, Location, Owner, Size) VALUES ('warehouse10', 'Caledon', 'Storage Company', 10000);

INSERT INTO WarehouseShippingLocation(WarehouseId, ShippingLocationId) VALUES ((SELECT Id FROM Warehouse WHERE Name='warehouse1'),(SELECT Id FROM  ShippingLocation WHERE Name='Toronto'));
INSERT INTO WarehouseShippingLocation(WarehouseId, ShippingLocationId) VALUES ((SELECT Id FROM  Warehouse WHERE Name='warehouse2'),(SELECT Id FROM  ShippingLocation WHERE Name='New York City'));
INSERT INTO WarehouseShippingLocation(WarehouseId, ShippingLocationId) VALUES ((SELECT Id FROM  Warehouse WHERE Name='warehouse3'),(SELECT Id FROM  ShippingLocation WHERE Name='Mississauga'));
INSERT INTO WarehouseShippingLocation(WarehouseId, ShippingLocationId) VALUES ((SELECT Id FROM  Warehouse WHERE Name='warehouse4'),(SELECT Id FROM  ShippingLocation WHERE Name='Toronto'));
INSERT INTO WarehouseShippingLocation(WarehouseId, ShippingLocationId) VALUES ((SELECT Id FROM  Warehouse WHERE Name='warehouse5'),(SELECT Id FROM  ShippingLocation WHERE Name='Montreal'));
INSERT INTO WarehouseShippingLocation(WarehouseId, ShippingLocationId) VALUES ((SELECT Id FROM  Warehouse WHERE Name='warehouse6'),(SELECT Id FROM  ShippingLocation WHERE Name='Kitchener'));
INSERT INTO WarehouseShippingLocation(WarehouseId, ShippingLocationId) VALUES ((SELECT Id FROM  Warehouse WHERE Name='warehouse7'),(SELECT Id FROM  ShippingLocation WHERE Name='Caledon'));
INSERT INTO WarehouseShippingLocation(WarehouseId, ShippingLocationId) VALUES ((SELECT Id FROM  Warehouse WHERE Name='warehouse8'),(SELECT Id FROM  ShippingLocation WHERE Name='Toronto'));
INSERT INTO WarehouseShippingLocation(WarehouseId, ShippingLocationId) VALUES ((SELECT Id FROM  Warehouse WHERE Name='warehouse8'),(SELECT Id FROM  ShippingLocation WHERE Name='New York City'));
INSERT INTO WarehouseShippingLocation(WarehouseId, ShippingLocationId) VALUES ((SELECT Id FROM  Warehouse WHERE Name='warehouse9'),(SELECT Id FROM  ShippingLocation WHERE Name='New York City'));

INSERT INTO Item(Name, MSRP, ExpiryDate) VALUES ('bicycle', 200.00, NULL);
INSERT INTO Item(Name, MSRP, ExpiryDate) VALUES ('jeans', 40.00, NULL);
INSERT INTO Item(Name, MSRP, ExpiryDate) VALUES ('Intro to Data Engineering', 210.00, NULL);
INSERT INTO Item(Name, MSRP, ExpiryDate) VALUES ('lego', 15.50, NULL);
INSERT INTO Item(Name, MSRP, ExpiryDate) VALUES ('chair', 35.00, NULL);
INSERT INTO Item(Name, MSRP, ExpiryDate) VALUES ('lettuce', 2.00, '2020-03-22');
INSERT INTO Item(Name, MSRP, ExpiryDate) VALUES ('pen',0.50, NULL);
INSERT INTO Item(Name, MSRP, ExpiryDate) VALUES ('laptop', 2000.00, NULL);
INSERT INTO Item(Name, MSRP, ExpiryDate) VALUES ('screwdriver', 6.00, NULL);
INSERT INTO Item(Name, MSRP, ExpiryDate) VALUES ('dictionary', 10.00, NULL);

INSERT INTO Type(Name) VALUES ('Children');
INSERT INTO Type(Name) VALUES ('Sports');
INSERT INTO Type(Name) VALUES ('Furniture');
INSERT INTO Type(Name) VALUES ('Food');
INSERT INTO Type(Name) VALUES ('Education');
INSERT INTO Type(Name) VALUES ('Entertainment');
INSERT INTO Type(Name) VALUES ('Books');
INSERT INTO Type(Name) VALUES ('Electronics');
INSERT INTO Type(Name) VALUES ('Clothing');
INSERT INTO Type(Name) VALUES ('Tools');

INSERT INTO ItemType(ItemId, TypeId) VALUES ((SELECT Id FROM Item Where Name = 'bicycle'),(SELECT Id FROM Type WHERE Name = 'Children'));
INSERT INTO ItemType(ItemId, TypeId) VALUES ((SELECT Id FROM Item Where Name = 'bicycle'), (SELECT Id FROM Type WHERE Name = 'Sports'));
INSERT INTO ItemType(ItemId, TypeId) VALUES ((SELECT Id FROM Item Where Name = 'bicycle'), (SELECT Id FROM Type WHERE Name = 'Entertainment'));
INSERT INTO ItemType(ItemId, TypeId) VALUES ((SELECT Id FROM Item Where Name = 'chair'), (SELECT Id FROM Type WHERE Name = 'Furniture'));
INSERT INTO ItemType(ItemId, TypeId) VALUES ((SELECT Id FROM Item Where Name = 'jeans'), (SELECT Id FROM Type WHERE Name = 'Clothing'));
INSERT INTO ItemType(ItemId, TypeId) VALUES ((SELECT Id FROM Item Where Name = 'Intro to Data Engineering'), (SELECT Id FROM Type WHERE Name = 'Books'));
INSERT INTO ItemType(ItemId, TypeId) VALUES ((SELECT Id FROM Item Where Name = 'Intro to Data Engineering'), (SELECT Id FROM Type WHERE Name = 'Education'));
INSERT INTO ItemType(ItemId, TypeId) VALUES ((SELECT Id FROM Item Where Name = 'lettuce'), (SELECT Id FROM Type WHERE Name = 'Food'));
INSERT INTO ItemType(ItemId, TypeId) VALUES ((SELECT Id FROM Item Where Name = 'pen'), (SELECT Id FROM Type WHERE Name = 'Education'));
INSERT INTO ItemType(ItemId, TypeId) VALUES ((SELECT Id FROM Item Where Name = 'laptop'), (SELECT Id FROM Type WHERE Name = 'Electronics'));
INSERT INTO ItemType(ItemId, TypeId) VALUES ((SELECT Id FROM Item Where Name = 'screwdriver'), (SELECT Id FROM Type WHERE Name = 'Tools'));
INSERT INTO ItemType(ItemId, TypeId) VALUES ((SELECT Id FROM Item Where Name = 'dictionary'), (SELECT Id FROM Type WHERE Name = 'Books'));
INSERT INTO ItemType(ItemId, TypeId) VALUES ((SELECT Id FROM Item Where Name = 'dictionary'), (SELECT Id FROM Type WHERE Name = 'Education'));

INSERT INTO StoreItem(StoreId, ItemId, Quantity) VALUES (1,  (SELECT Id FROM Item WHERE name = 'bicycle'), 200);
INSERT INTO StoreItem(StoreId, ItemId, Quantity) VALUES (2, (SELECT Id FROM Item WHERE name = 'Intro to Data Engineering'), 30);
INSERT INTO StoreItem(StoreId, ItemId, Quantity) VALUES (3,(SELECT Id FROM Item WHERE name = 'dictionary'), 50);
INSERT INTO StoreItem(StoreId, ItemId, Quantity) VALUES (4, (SELECT Id FROM Item WHERE name = 'chair'), 55);
INSERT INTO StoreItem(StoreId, ItemId, Quantity) VALUES (5, (SELECT Id FROM Item WHERE name = 'pen'), 5000);
INSERT INTO StoreItem(StoreId, ItemId, Quantity) VALUES (6, (SELECT Id FROM Item WHERE name = 'laptop'), 35);
INSERT INTO StoreItem(StoreId, ItemId, Quantity) VALUES (7, (SELECT Id FROM Item WHERE name = 'lettuce'), 100);
INSERT INTO StoreItem(StoreId, ItemId, Quantity) VALUES (8, (SELECT Id FROM Item WHERE name = 'lego'), 300);
INSERT INTO StoreItem(StoreId, ItemId, Quantity) VALUES (9, (SELECT Id FROM Item WHERE name = 'jeans'), 10000);
INSERT INTO StoreItem(StoreId, ItemId, Quantity) VALUES (10, (SELECT Id FROM Item WHERE name = 'screwdriver'), 300);

INSERT INTO WarehouseItem(WarehouseId, ItemId, Quantity) VALUES ((SELECT Id FROM Warehouse WHERE name = 'warehouse1'), (SELECT Id FROM Item WHERE name = 'jeans'), 40000);
INSERT INTO WarehouseItem(WarehouseId, ItemId, Quantity) VALUES ((SELECT Id FROM Warehouse WHERE name = 'warehouse2'), (SELECT Id FROM Item WHERE name = 'pens'), 1000000);
INSERT INTO WarehouseItem(WarehouseId, ItemId, Quantity) VALUES ((SELECT Id FROM Warehouse WHERE name = 'warehouse3'), (SELECT Id FROM Item WHERE name = 'bicycles'), 500);
INSERT INTO WarehouseItem(WarehouseId, ItemId, Quantity) VALUES ((SELECT Id FROM Warehouse WHERE name = 'warehouse4'), (SELECT Id FROM Item WHERE name = 'laptops'), 2500);
INSERT INTO WarehouseItem(WarehouseId, ItemId, Quantity) VALUES ((SELECT Id FROM Warehouse WHERE name = 'warehouse5'), (SELECT Id FROM Item WHERE name = 'jeans'), 50000);
INSERT INTO WarehouseItem(WarehouseId, ItemId, Quantity) VALUES ((SELECT Id FROM Warehouse WHERE name = 'warehouse6'), (SELECT Id FROM Item WHERE name = 'lettuce'), 40000);
INSERT INTO WarehouseItem(WarehouseId, ItemId, Quantity) VALUES ((SELECT Id FROM Warehouse WHERE name = 'warehouse7'), (SELECT Id FROM Item WHERE name = 'screwdriver'), 1000000);
INSERT INTO WarehouseItem(WarehouseId, ItemId, Quantity) VALUES ((SELECT Id FROM Warehouse WHERE name = 'warehouse8'), (SELECT Id FROM Item WHERE name = 'chair'), 400);
INSERT INTO WarehouseItem(WarehouseId, ItemId, Quantity) VALUES ((SELECT Id FROM Warehouse WHERE name = 'warehouse9'), (SELECT Id FROM Item WHERE name = 'dictionary'), 500);
INSERT INTO WarehouseItem(WarehouseId, ItemId, Quantity) VALUES ((SELECT Id FROM Warehouse WHERE name = 'warehouse10'), (SELECT Id FROM Item WHERE name = 'Intro to Data Engineering'), 100);

INSERT INTO Vehicle(PlateNumber, Owner, ActiveServiceLife, VehicleType, Capacity, Manufacturer, Model) VALUES ('5TGY606', 'Walmart', 3, 'Truck', 1000, 'Mack', 'Pinnacle CHU613');
INSERT INTO Vehicle(PlateNumber, Owner, ActiveServiceLife, VehicleType, Capacity, Manufacturer, Model) VALUES ('3SKN889', 'Tru Kids, Inc', 4, 'Truck', 1000, 'Mack', 'Pinnacle CHU613');
INSERT INTO Vehicle(PlateNumber, Owner, ActiveServiceLife, VehicleType, Capacity, Manufacturer, Model) VALUES ('DAN6346', 'Food Company', 1, 'Plane', 1000, 'Boeing', '757');
INSERT INTO Vehicle(PlateNumber, Owner, ActiveServiceLife, VehicleType, Capacity, Manufacturer, Model) VALUES ('149BVW', 'Automobile Company', 14, 'Truck', 1000, 'Mack', 'Pinnacle CHU613');
INSERT INTO Vehicle(PlateNumber, Owner, ActiveServiceLife, VehicleType, Capacity, Manufacturer, Model) VALUES ('T674863C', 'Walmart', 1, 'Truck', 1000, 'Mack', 'Pinnacle CHU613');
INSERT INTO Vehicle(PlateNumber, Owner, ActiveServiceLife, VehicleType, Capacity, Manufacturer, Model) VALUES ('AGE5055', 'McDonalds Co', 5, 'Truck', 1000, 'Mack', 'Pinnacle CHU613');
INSERT INTO Vehicle(PlateNumber, Owner, ActiveServiceLife, VehicleType, Capacity, Manufacturer, Model) VALUES ('HRX7050', 'Walmart', 3, 'Truck', 1000, 'Mack', 'Pinnacle CHU613');
INSERT INTO Vehicle(PlateNumber, Owner, ActiveServiceLife, VehicleType, Capacity, Manufacturer, Model) VALUES ('996KRW', 'McDonalds Co', 8, 'Truck', 1000, 'Mack', 'Pinnacle CHU613');
INSERT INTO Vehicle(PlateNumber, Owner, ActiveServiceLife, VehicleType, Capacity, Manufacturer, Model) VALUES ('JPB5563', 'Walmart', 1, 'Truck', 1000, 'Mack', 'Pinnacle CHU613');
INSERT INTO Vehicle(PlateNumber, Owner, ActiveServiceLife, VehicleType, Capacity, Manufacturer, Model) VALUES ('DP3ZD7', 'McDonalds Co', 4, 'Truck', 1000, 'Mack', 'Pinnacle CHU613');

