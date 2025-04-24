 
CREATE TABLE Customers1(
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(50)
);

INSERT INTO Customers1 (CustomerID, CustomerName, City, State) VALUES
(1, 'Aman Sharma', 'Delhi', 'Delhi'),
(2, 'Priya Mehta', 'Mumbai', 'Maharashtra'),
(3, 'Ravi Kumar', 'Chennai', 'Tamil Nadu'),
(4, 'Sneha Roy', 'Kolkata', 'West Bengal'),
(5, 'Karan Yadav', 'Lucknow', 'Uttar Pradesh'),
(6, 'Megha Das', 'Pune', 'Maharashtra'),
(7, 'Nikhil Singh', 'Bangalore', 'Karnataka'),
(8, 'Isha Kapoor', 'Jaipur', 'Rajasthan'),
(9, 'Harsh Verma', 'Bhopal', 'Madhya Pradesh'),
(10, 'Divya Nair', 'Hyderabad', 'Telangana'),
(11, 'Suresh Raina', 'Ahmedabad', 'Gujarat'),
(12, 'Tanvi Rana', 'Chandigarh', 'Punjab'),
(13, 'Arjun Joshi', 'Patna', 'Bihar'),
(14, 'Preeti Sinha', 'Nagpur', 'Maharashtra'),
(15, 'Rajeev Tiwari', 'Kanpur', 'Uttar Pradesh'),
(16, 'Shikha Aggarwal', 'Indore', 'Madhya Pradesh'),
(17, 'Tarun Saxena', 'Thane', 'Maharashtra'),
(18, 'Ritu Mishra', 'Noida', 'Uttar Pradesh'),
(19, 'Ankit Goyal', 'Dehradun', 'Uttarakhand'),
(20, 'Neha Khandelwal', 'Surat', 'Gujarat');


CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10, 2)
);



CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    Quantity INT,
    SaleDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers1(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);





-- total sales per product---

SELECT 
    p.ProductID,
    p.ProductName,
    SUM(s.Quantity) AS TotalQuantitySold,
    SUM(s.Quantity * p.Price) AS TotalRevenue
FROM 
    Sales s
JOIN 
    Products p ON s.ProductID = p.ProductID
GROUP BY 
    p.ProductID, p.ProductName
ORDER BY 
    TotalRevenue DESC;

	---- top 5 customers by purchase amount---

	SELECT TOP 5
    c.CustomerID,
    c.CustomerName,
    c.City,
    c.State,
    SUM(s.Quantity * p.Price) AS TotalPurchaseAmount
FROM 
    Sales s
JOIN 
    Customers1 c ON s.CustomerID = c.CustomerID
JOIN 
    Products p ON s.ProductID = p.ProductID
GROUP BY 
    c.CustomerID, c.CustomerName, c.City, c.State
ORDER BY 
    TotalPurchaseAmount DESC;
	
	
	---Monthly revenue using GROUP BY MONTH(SaleDate)---
SELECT 
    YEAR(s.SaleDate) AS SaleYear,
    MONTH(s.SaleDate) AS SaleMonth,
    SUM(s.Quantity * p.Price) AS MonthlyRevenue
FROM 
    Sales s
JOIN 
    Products p ON s.ProductID = p.ProductID
GROUP BY 
    YEAR(s.SaleDate), MONTH(s.SaleDate)
ORDER BY 
    SaleYear DESC, SaleMonth DESC;


	---Join Sales, Customers, Products

	SELECT 
    s.SaleID,
    c.CustomerID,
    c.CustomerName,
    c.City,
    c.State,
    p.ProductID,
    p.ProductName,
    p.Category,
    p.Price,
    s.Quantity,
    s.Quantity * p.Price AS TotalSaleAmount,
    s.SaleDate
FROM 
    Sales s
JOIN 
    Customers1 c ON s.CustomerID = c.CustomerID
JOIN 
    Products p ON s.ProductID = p.ProductID
ORDER BY 
    s.SaleDate DESC;

---Most sold product, least sold product

SELECT TOP 1
    p.ProductID,
    p.ProductName,
    SUM(s.Quantity) AS TotalQuantitySold
FROM 
    Sales s
JOIN 
    Products p ON s.ProductID = p.ProductID
GROUP BY 
    p.ProductID, p.ProductName
ORDER BY 
    TotalQuantitySold DESC;

-- Least Sold Product
SELECT TOP 1
    p.ProductID,
    p.ProductName,
    SUM(s.Quantity) AS TotalQuantitySold
FROM 
    Sales s
JOIN 
    Products p ON s.ProductID = p.ProductID
GROUP BY 
    p.ProductID, p.ProductName
ORDER BY 
    TotalQuantitySold ASC;

-----Customers from Maharashtra who purchased electronics

SELECT 
    c.CustomerID,
    c.CustomerName,
    c.City,
    c.State,
    p.ProductID,
    p.ProductName,
    p.Category,
    s.Quantity,
    s.Quantity * p.Price AS TotalPurchaseAmount,
    s.SaleDate
FROM 
    Sales s
JOIN 
    Customers1 c ON s.CustomerID = c.CustomerID
JOIN 
    Products p ON s.ProductID = p.ProductID
WHERE 
    c.State = 'Maharashtra' 
    AND p.Category = 'Electronics'
ORDER BY 
    s.SaleDate DESC;

	---customers and the products they purchased


	SELECT 
    c.CustomerID,
    c.CustomerName,
    p.ProductID,
    p.ProductName,
    s.Quantity,
    s.Quantity * p.Price AS TotalSaleAmount
FROM 
    Sales s
INNER JOIN 
    Customers1 c ON s.CustomerID = c.CustomerID
INNER JOIN 
    Products p ON s.ProductID = p.ProductID;



	--View for Monthly Revenue Analysis


SELECT 
    YEAR(s.SaleDate) AS SaleYear,
    MONTH(s.SaleDate) AS SaleMonth,
    SUM(s.Quantity * p.Price) AS MonthlyRevenue
FROM 
    Sales s
JOIN 
    Products p ON s.ProductID = p.ProductID
GROUP BY 
    YEAR(s.SaleDate), MONTH(s.SaleDate)
ORDER BY 
    SaleYear DESC, SaleMonth DESC;


