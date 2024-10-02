-- USO DE LIKE -> COMODINES
-- -- LINK: https://en.wikibooks.org/wiki/SQL_Exercises/The_computer_store

DROP DATABASE IF EXISTS afterclass;
CREATE DATABASE afterclass;
USE afterclass;

CREATE TABLE Manufacturers (
    Code INTEGER PRIMARY KEY NOT NULL,
    Name CHAR(50) NOT NULL
);

CREATE TABLE Products (
    Code INTEGER PRIMARY KEY NOT NULL,
    Name CHAR(50) NOT NULL, -- >nombre
    Price REAL NOT NULL,
    Manufacturer INTEGER NOT NULL,
    FOREIGN KEY (Manufacturer)
        REFERENCES Manufacturers (Code)
);

INSERT INTO Manufacturers(Code,Name) VALUES (1,'Sony'),(2,'Creative Labs'),(3,'Hewlett-Packard'),(4,'Iomega'),(5,'Fujitsu'),(6,'Winchester');

INSERT INTO Products(Code,Name,Price,Manufacturer) 
VALUES(1,'Hard drive',240,5),(2,'Memory',120,6),(3,'ZIP drive',150,4),(4,'Floppy disk',5,6),(5,'Monitor',240,1),
(6,'DVD drive',180,2),(7,'CD drive',90,2),(8,'Printer',270,3),(9,'Toner cartridge',66,3),(10,'DVD burner',180,2);

-- <SQL> --
-- 1.1 Select the names of all the products in the store.
SELECT 
	-- cols
    Name
FROM afterclass.Products;

-- 1.2 Select the names and the prices of all the products in the store, 

SELECT
	Name AS Nombre,
    Price AS 'Lo que nos va a doler'
FROM afterclass.Products
WHERE 
	Name LIKE '%o_' -- monitor
;


SELECT
	Name AS Nombre,
    Price AS 'Lo que nos va a doler'
FROM afterclass.Products
WHERE 
	Name LIKE '%v_' -- monitor
;

-- 1.3 Select the name of the products with a price less than or equal to $200.

SELECT
	Name AS nombre
FROM afterclass.Products
WHERE 
	Price <= 200;

SELECT 
	COLUMN_NAME
 FROM information_schema.COLUMNS
WHERE 
	TABLE_SCHEMA = 'afterclass'
AND TABLE_NAME = 'Products';

-- 1.4 Select all the products with a price between $60 and $120.

/*	
	SELECT column_name(s)
	FROM table_name
	WHERE column_name BETWEEN value1 AND value2;
*/

SELECT * FROM afterclass.Products 
WHERE Price BETWEEN 60 AND 120
ORDER BY Price 
;

-- 1.5 Select the name and price in cents (i.e., the price must be multiplied by 100).
-- 1.6 Compute the average price of all the products.
-- 1.7 Compute the average price of all products with manufacturer code equal to 2.
-- 1.8 Compute the number of products with a price larger than or equal to $180.
-- 1.9 Select the name and price of all products with a price larger than or equal to $180, and sort first by price (in descending order), and then by name (in ascending order).
-- 1.10 Select all the data from the products, including all the data for each product's manufacturer.
-- 1.11 Select the product name, price, and manufacturer name of all the products.
-- 1.12 Select the average price of each manufacturer's products, showing only the manufacturer's code.
-- 1.13 Select the average price of each manufacturer's products, showing the manufacturer's name.
-- 1.14 Select the names of manufacturer whose products have an average price larger than or equal to $150.
-- 1.15 Select the name and price of the cheapest product.






