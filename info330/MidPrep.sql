-- Create the tables.
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(10),
    LastName VARCHAR(10)
);

INSERT INTO Employees (EmployeeID, FirstName, LastName)
VALUES
(1, 'Ray', 'Hwang'),
(2, 'Ariel', 'Lee'),
(3, 'Jiho', 'Shin'),
(4, 'Agnes', 'Kim');

SELECT *
FROM Employees;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(10),
    LastName VARCHAR(10),
    CustomerLevel Varchar(1),
    City VARCHAR(20)
);

INSERT INTO Customers (CustomerID, FirstName, LastName, CustomerLevel, City)
VALUES
(1, 'Jhon', 'Song', 'B', 'Seattle'),
(2, 'Somi', 'Park', 'A', 'Seattle'),
(3, 'Henry', 'Seo', 'A', 'Lynnwood'),
(4, 'Joy', 'Kim', 'C', 'Capital Hill'),
(5, 'Jeniffer', 'Jung', 'B', 'Tacoma');

SELECT *
FROM Customers;

CREATE TABLE CustomerType (
    CustomerLevel VARCHAR(1) PRIMARY KEY,
    CustomerType VARCHAR(20)
)

INSERT INTO CustomerType (CustomerLevel, CustomerType)
VALUES
('A', 'Green Thumb'),
('B', 'Yellow Thumb'),
('C', 'Red Thumb');

SELECT *
FROM CustomerType;

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    EmployeeID INT,
    CustomerID INT
);

INSERT INTO Orders (OrderID, EmployeeID, CustomerID)
VALUES
(111, 1, 4),
(222, 2, 2),
(333, 3, 5),
(444, 4, 3);

SELECT *
FROM Orders;

CREATE TABLE Plants (
    PlantID VARCHAR(3) PRIMARY KEY,
    PlantName VARCHAR(20),
    CategoryID INT,
    Cost INT
);

INSERT INTO Plants (PlantID, PlantName, CategoryID, Cost)
VALUES
('A03', 'Venus Fly Trap', 1, 46),
('A17', 'Bracken', 2, 27),
('A05', 'Jasmine', 1, 39),
('A11', 'Ginkgo', 3, 50),
('A19', 'Taiwania', 3, 14);

SELECT *
FROM Plants;

CREATE TABLE PlantCategory (
    CategoryID INT PRIMARY KEY,
    CategoryName Varchar(20)
);

INSERT INTO PlantCategory (CategoryID, CategoryName)
VALUES
(1, 'Orchid'),
(2, 'Rose'),
(3, 'Aquatic Plant');

SELECT *
FROM PlantCategory;

CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY,
    SupplierName VARCHAR(20),
    City VARCHAR(20),
    State VARCHAR (20)
);

INSERT INTO Suppliers (SupplierID, SupplierName, City, State)
VALUES
(1, 'Fancy Plants Seattle', 'Seattle', 'WA'),
(2, 'Rudy Plant', 'Los Angeles', 'CA'),
(3, 'Fresh Plants', 'Brooklyn', 'NY');

SELECT *
FROM Suppliers;

CREATE TABLE OrderPlants (
    OrderPlantID VARCHAR(3) PRIMARY KEY,
    OrderID INT,
    PlantID VARCHAR(3),
    Quantity INT
);

INSERT INTO OrderPlants (OrderPlantID, OrderID, PlantID, Quantity)
VALUES
('HQB', 111, 'A05', 3),
('ADG', 222, 'A11', 1),
('SYU', 222, 'A19', 2),
('NWL', 222, 'A17', 4),
('FBO', 333, 'A03', 5),
('KWI', 444, 'A11', 2);

SELECT *
FROM OrderPlants;

CREATE TABLE PlantSuppliers (
    PlantSupplierID INT PRIMARY KEY,
    PlantID VARCHAR(3),
    SupplierID INT
);

INSERT INTO PlantSuppliers (PlantSupplierID, PlantID, SupplierID)
VALUES
(11, 'A03', 2),
(22, 'A03', 3),
(33, 'A05', 2),
(44, 'A11', 1),
(55, 'A17', 3),
(66, 'A19', 1);

SELECT *
FROM PlantSuppliers;

CREATE TABLE Reviews (
    ReviewID VARCHAR(2) PRIMARY kEY,
    OrderPlantID VARCHAR(3),
    Difference INT,
    Rate INT,
    PostDate DATE
);

INSERT INTO Reviews (ReviewID, OrderPlantID, Difference, Rate, PostDate)
VALUES
('C1', 'SYU', 3, 5, '2023-02-18'),
('C2', 'KWI', 4, 4, '2023-03-06');

SELECT *
FROM Reviews;

-- Write queries.
-- 1. Write a query to find all customers who are in the ‘Green Thumb’ Loyalty Program.
SELECT *
FROM Customers
WHERE CustomerLevel = 'A';

-- 2. Write a query to find the number of orders that contain the plant category ‘Orchid’.
SELECT SUM(o.Quantity) AS NumOfOrders
FROM OrderPlants o
WHERE o.PlantID
    IN(SELECT p.PlantID
    FROM Plants p
    WHERE p.CategoryID
        IN(SELECT c.CategoryID
        FROM PlantCategory c
        WHERE c.CategoryName = 'Orchid'
    )
);

-- 3. Write a query to list all of the suppliers of ‘Venus Fly Trap’ Plants.
SELECT *
FROM Suppliers s
WHERE s.SupplierID
IN(SELECT p.SupplierID
    FROM PlantSuppliers p
    WHERE p.PlantID
    IN(SELECT P.PlantID
        FROM Plants s
        WHERE s.PlantName = 'Venus Fly Trap'
    )
);

-- 4. Write a query to list the total sum of money each customer has spent at the plant store.
SELECT c.CustomerID, c.FirstName, c.LastName, SUM(s.Cost * p.Quantity) AS expense
FROM Customers c
    JOIN Orders o ON c.CustomerID = o.CustomerID
    JOIN OrderPlants p ON o.OrderID = p.OrderID
    JOIN Plants s ON p.PlantID = s.PlantID
GROUP BY c.CustomerID, c.FirstName, c.LastName;

-- 5. Write a query listing all orders having a total cost over $100.
SELECT p.OrderPlantID, (s.Cost * p.Quantity) AS TotalCost
FROM OrderPlants p
    JOIN Plants s ON p.PlantID = s.PlantID
WHERE (s.Cost * p.Quantity) > 100;

-- 6. Write the nested query to list all customers who have made a purchase of plants in the category of ‘Rose’ and ‘Aquatic Plant’.
SELECT *
FROM Customers c
WHERE c.CustomerID
    IN(SELECT o.CustomerID
    FROM Orders o
    WHERE o.OrderID
        IN(SELECT p.OrderID
        FROM OrderPlants p
        WHERE p.PlantID
            IN(SELECT s.PlantID
            FROM Plants s
            WHERE s.CategoryID
                IN(SELECT c.CategoryID
                FROM PlantCategory c
                WHERE c.CategoryName IN ('Rose', 'Aquatic Plant')
            )
        )
    )
);

-- 7. Write a nested query that lists the total revenue generated for each plant that was sold in a purchase containing 3 or more plants to a customer who is in the ‘Green Thumb’ Loyalty program.
SELECT s.PlantID, s.PlantName, SUM(s.Cost * p.Quantity) AS TotalRevenue
FROM Plants s
    JOIN OrderPlants p ON s.PlantID = p.PlantID
WHERE p.Quantity > 3
AND p.OrderID
    IN(SELECT o.OrderID
    FROM Orders o
    WHERE o.CustomerID
        IN(SELECT c.CustomerID
        FROM Customers c
        WHERE c. CustomerLevel
            IN(SELECT t.CustomerLevel
            FROM CustomerType t
            WHERE t.CustomerType = 'Green Thumb'
        )
    )
)
GROUP BY s.PlantID, s.PlantName;
