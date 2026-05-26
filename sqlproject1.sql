USE superstore_db;
SHOW TABLES;
SHOW TABLES;
SELECT * FROM superstore_cleaned LIMIT 10;
DROP TABLE superstore_cleaned;
SHOW TABLES;
USE superstore_db;

CREATE TABLE superstore (
  `Row ID` INT,
  `Order ID` VARCHAR(50),
  `Order Date` VARCHAR(20),
  `Ship Date` VARCHAR(20),
  `Ship Mode` VARCHAR(50),
  `Customer ID` VARCHAR(50),
  `Customer Name` VARCHAR(100),
  `Segment` VARCHAR(50),
  `Country` VARCHAR(50),
  `City` VARCHAR(100),
  `State` VARCHAR(100),
  `Postal Code` VARCHAR(20),
  `Region` VARCHAR(50),
  `Product ID` VARCHAR(50),
  `Category` VARCHAR(50),
  `Sub-Category` VARCHAR(50),
  `Product Name` VARCHAR(200),
  `Sales` DOUBLE,
  `Quantity` INT,
  `Discount` DOUBLE,
  `Profit` DOUBLE
);
SHOW VARIABLES LIKE 'secure_file_priv';
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Sample - Superstore.csv'
INTO TABLE superstore
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Sample - Superstore.csv'
INTO TABLE superstore
CHARACTER SET latin1
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SELECT * FROM superstore LIMIT 10;
SELECT 
  Region,
  ROUND(SUM(Sales), 2) AS Total_Sales,
  ROUND(SUM(Profit), 2) AS Total_Profit
FROM superstore
GROUP BY Region
ORDER BY Total_Sales DESC;
SELECT 
  `Product Name`,
  ROUND(SUM(Sales), 2) AS Total_Sales
FROM superstore
GROUP BY `Product Name`
ORDER BY Total_Sales DESC
LIMIT 5;
SELECT 
  YEAR(`Order Date`) AS Year,
  MONTH(`Order Date`) AS Month,
  ROUND(SUM(Sales), 2) AS Monthly_Sales
FROM superstore
GROUP BY Year, Month
ORDER BY Year, Month;
SELECT `Order Date` FROM superstore LIMIT 5;
ALTER TABLE superstore ADD COLUMN Order_Date_Fixed DATE;
SET SQL_SAFE_UPDATES = 0;
UPDATE superstore 
SET Order_Date_Fixed = STR_TO_DATE(`Order Date`, '%m/%d/%Y');
SELECT 
  YEAR(Order_Date_Fixed) AS Year,
  MONTH(Order_Date_Fixed) AS Month,
  ROUND(SUM(Sales), 2) AS Monthly_Sales
FROM superstore
GROUP BY Year, Month
ORDER BY Year, Month;
SELECT 
  Category,
  ROUND(SUM(Profit), 2) AS Total_Profit,
  ROUND(AVG(Profit), 2) AS Avg_Profit
FROM superstore
GROUP BY Category
ORDER BY Total_Profit DESC;
SELECT 
  `Customer Name`,
  COUNT(`Order ID`) AS Total_Orders,
  ROUND(SUM(Sales), 2) AS Total_Spent
FROM superstore
GROUP BY `Customer Name`
ORDER BY Total_Spent DESC
LIMIT 10;