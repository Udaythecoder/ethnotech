create database training_sql;
use training_sql;
select* from sales_data;
select* from sales_data1;

SELECT Product_ID,
       YEAR(Sale_Date) AS Sales_Year
FROM Sales_Data1;

SELECT Product_ID,
       MONTH(Sale_Date) AS Sales_Month
FROM Sales_Data1;

SELECT YEAR(Sale_Date) AS Year,
       COUNT(*) AS Total_Sales
FROM Sales_Data1
GROUP BY YEAR(Sale_Date);

SELECT MONTH(Sale_Date) AS Month,
       COUNT(*) AS Total_Sales
FROM Sales_Data1
GROUP BY MONTH(Sale_Date);

SET SQL_SAFE_UPDATES =0;
UPDATE Sales_Data1
SET Sale_Date = '2025-01-01';

UPDATE Sales_Data1
SET Sale_Date = '2025-06-01'
WHERE Region = 'North';

UPDATE Sales_Data1
SET Sale_Date = '2025-03-16'
WHERE Region = 'South';

UPDATE Sales_Data1
SET Sale_Date = '2025-08-03'
WHERE Region = 'East';

UPDATE Sales_Data1
SET Sale_Date = '2025-12-07'
WHERE Region = 'West';

select* from sales_data1;
SELECT NOW();
SELECT CURDATE();
select quarter('2026-11-12');
SELECT CURTIME();
SELECT DAY(2025-03-16);
SELECT MONTH(2025-03-16);
SELECT YEAR(2025-03-16);
SELECT DATEDIFF(2025-08-16, 2025-06-03);
SELECT DATE_ADD(2025-03-16, INTERVAL 10 DAY);
SELECT DATE_SUB(2025-03-16, INTERVAL 5 DAY);

#reg expression
SELECT *
FROM Sales_Data1
WHERE Sales_Rep REGEXP 'D';

SELECT *
FROM Sales_Data1
WHERE Payment_Method REGEXP 'Credit Card';

SELECT *
FROM Sales_Data1
WHERE Region REGEXP '(North|South)' ;

SELECT *
FROM Sales_Data1
WHERE Region LIKE 'N%'
   OR Region LIKE 'S%'
   OR Region LIKE 'W%';
   
SELECT *
FROM Sales_Data1
WHERE Sales_Rep LIKE 'B%'
  AND Sales_Rep LIKE '%o%';

SELECT *
FROM Sales_Data1
WHERE Region LIKE 's%'
  AND Payment_Method LIKE '%Card%';
  
SELECT *
FROM Sales_Data1
WHERE Product_Category LIKE '%Electronics%'
   OR Product_Category LIKE '%Furniture%'
   OR Product_Category LIKE '%Clothing%';

SELECT *
FROM Sales_Data1
WHERE Region IN ('North', 'South', 'West');

select* from sales_data1;
SELECT * FROM Sales_Data1 WHERE Sales_Amount =(SELECT MAX(Sales_Amount) FROM Sales_Data1);
SELECT * FROM Sales_Data1 WHERE Sales_Amount =(SELECT min(Sales_Amount) FROM Sales_Data1);

CREATE VIEW Sales_View AS
SELECT *
FROM Sales_Data1;

SELECT * FROM Sales_View;

CREATE VIEW Online_Sales AS
SELECT Product_ID,
       Sales_Rep,
       Region,
       Sales_Amount
FROM Sales_Data1
WHERE Sales_Channel = 'Online';

SELECT * FROM Online_Sales;

CREATE VIEW Online_Sales1 AS
SELECT Product_ID,
       Sales_Rep,
       Region,
       Sales_Amount
FROM Sales_Data1
WHERE Sales_Channel = 'Retail';

SELECT * FROM Online_Sales1;

CREATE VIEW North_Sales AS
SELECT *
FROM Sales_Data1
WHERE Region = 'North';

CREATE VIEW Region_Sales AS
SELECT Region,
       SUM(Sales_Amount) AS Total_Sales
FROM Sales_Data1
GROUP BY Region;

CREATE OR REPLACE VIEW Region_Sales AS
SELECT Region,
       COUNT(*) AS Total_Orders,
       SUM(Sales_Amount) AS Total_Sales
FROM Sales_Data1
GROUP BY Region;

CREATE VIEW Returning_Customers AS
SELECT *
FROM Sales_Data1
WHERE Customer_Type = 'Returning';

CREATE VIEW Card_Payments AS
SELECT *
FROM Sales_Data1
WHERE Payment_Method = 'Card';

CREATE VIEW Customer_Orders AS
SELECT c.Customer_ID,
       c.Customer_Name,
       o.Order_ID,
       o.Amount
FROM Customers c
INNER JOIN Orders o
ON c.Customer_ID = o.Customer_ID;

CREATE VIEW Customer_Product_Details AS
SELECT c.Customer_Name,
       o.Order_ID,
       p.Product_Name,
       p.Price
FROM Customers c
INNER JOIN Orders o
ON c.Customer_ID = o.Customer_ID
INNER JOIN Products p
ON o.Product_ID = p.Product_ID;

