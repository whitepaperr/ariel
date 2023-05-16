USE haeun
GO

-- Type Tables:
CREATE TABLE CreatorLevel (
   CreatorLevel VARCHAR(1) PRIMARY KEY,
   NumOfCreator INT
)

CREATE TABLE Genre (
   GenreName VARCHAR(30) PRIMARY KEY,
   GenreType VARCHAR(30)
)

CREATE TABLE LocationCategory (
   LocationCategoryID INT PRIMARY KEY,
   LocationCategory VARCHAR(30)
)

CREATE TABLE TagType (
   TagType VARCHAR(10) PRIMARY KEY,
   NumOfTag INT
)

CREATE TABLE EquipmentCategory (
   EquipmentCategory VARCHAR(20) PRIMARY KEY,
   NumOfEquipment INT
)

CREATE TABLE CustomerLevel (
   CustomerLevel VARCHAR(1) PRIMARY KEY,
   NumOfCustomer INT
)

-- Entity Tables:
CREATE TABLE Creator (
   CreatorID INT PRIMARY KEY,
   FirstName VARCHAR(20),
   LastName VARCHAR(20),
   CreatorLevel VARCHAR(1) FOREIGN KEY REFERENCES CreatorLevel(CreatorLevel),
   City VARCHAR(10)
)

CREATE TABLE Image (
   ImageID INT PRIMARY KEY,
   ImageName VARCHAR(20),
   ImageType VARCHAR(20),
   GenreName VARCHAR(30) FOREIGN KEY REFERENCES Genre(GenreName),
   LocationID VARCHAR(3) FOREIGN KEY REFERENCES Location(LocationID)
)

CREATE TABLE Location (
   LocationID VARCHAR(3) PRIMARY KEY,
   Address VARCHAR(20),
   City VARCHAR(20),
   State VARCHAR(20),
   Zip INT,
   LocationCategoryID INT FOREIGN KEY REFERENCES LocationCategory(LocationCategoryID)
)

CREATE TABLE Tag (
   TagID INT PRIMARY KEY,
   TagName VARCHAR(20),
   TagType VARCHAR(10) FOREIGN KEY REFERENCES TagType(TagType)
)

CREATE TABLE Equipment (
   EquipmentID INT PRIMARY KEY,
   EquipmentName VARCHAR(20),
   EquipmentCategory VARCHAR(20) FOREIGN KEY REFERENCES EquipmentCategory(EquipmentCategory)
)

CREATE TABLE tblOrder (
   OrderID VARCHAR(5) PRIMARY KEY,
   CustomerID INT FOREIGN KEY REFERENCES Customer(CustomerID),
   OrderType VARCHAR(20),
   OrderDate DATE
)

CREATE TABLE Customer (
   CustomerID INT PRIMARY KEY,
   FirstName VARCHAR(20),
   LastName VARCHAR(20),
   CustomerLevel VARCHAR(1) FOREIGN KEY REFERENCES CustomerLevel(CustomerLevel),
   City VARCHAR(10)
)

CREATE TABLE Review (
   ReviewID VARCHAR(4) PRIMARY KEY,
   PostDate DATE,
   Review VARCHAR(200)
)

-- Transactional Tables:
CREATE TABLE CreatorImage (
   CreatorImageID VARCHAR(5) PRIMARY KEY,
   CreatorID INT FOREIGN KEY REFERENCES Creator(CreatorID),
   ImageID INT FOREIGN KEY REFERENCES Image(ImageID),
   Date DATE,
)

CREATE TABLE ImageOrder (
   ImageOrderID VARCHAR(5) PRIMARY KEY,
   OrderID VARCHAR(5) FOREIGN KEY REFERENCES tblOrder(OrderID),
   ImageID INT FOREIGN KEY REFERENCES Image(ImageID),
   Quantity INT
)

CREATE TABLE ImageTag (
   ImageTagID VARCHAR(4) PRIMARY KEY,
   ImageID INT FOREIGN KEY REFERENCES Image(ImageID),
   TagID INT FOREIGN KEY REFERENCES Tag(TagID)
)

CREATE TABLE ImageEquip (
   ImageEquipmentID VARCHAR(4) PRIMARY KEY,
   ImageID INT FOREIGN KEY REFERENCES Image(ImageID),
   EquipmentID INT FOREIGN KEY REFERENCES Equipment(EquipmentID)
)

CREATE TABLE ImageRate (
   ImageRateID VARCHAR(3) PRIMARY KEY,
   ImageOrderID VARCHAR(5) FOREIGN KEY REFERENCES ImageOrder(ImageOrderID),
   ReviewID VARCHAR(4) FOREIGN KEY REFERENCES Review(ReviewID),
   Rate INT
)

