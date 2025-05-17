create database superstore;
use superstore;

desc sales_data;
select * from sales_data limit 10;

-- Changeing datatype text to date in orderdate column
ALTER TABLE sales_data ADD COLUMN Order_Date_Converted DATE;
UPDATE sales_data
SET Order_Date_Converted = STR_TO_DATE(Order_Date, '%d/%m/%Y');
ALTER TABLE sales_data DROP COLUMN Order_Date;
ALTER TABLE sales_data CHANGE Order_Date_Converted Order_Date DATE;





ALTER TABLE sales_data ADD COLUMN Profit_Num DOUBLE;

UPDATE sales_data
SET Profit_Num = CAST(Profit AS DOUBLE);

ALTER TABLE sales_data DROP COLUMN Profit;
ALTER TABLE sales_data RENAME COLUMN Profit_Num TO Profit;





 
ALTER TABLE sales_data ADD COLUMN Profit_Margin DOUBLE;
UPDATE sales_data
SET Profit_Margin = CAST(Profit AS DECIMAL(10,2)) / Sales;

ALTER TABLE sales_data ADD COLUMN Revenue_per_Unit DOUBLE;
UPDATE sales_data
SET Revenue_per_Unit = Sales / Order_Quantity;

select * from sales_data limit 10;

-- Total sales by Province
SELECT Province, sum(Sales) AS Total_Sales
FROM sales_data
GROUP BY Province order by Total_Sales desc;

-- Top 5 products by profit
SELECT Product_Name, SUM(Profit) AS Total_Profit
FROM sales_data
GROUP BY Product_Name
ORDER BY Total_Profit DESC
LIMIT 5;

-- Monthly sales trend
SELECT monthName(order_date) AS Month, SUM(Sales) AS Monthly_Sales
FROM sales_data
GROUP BY Month
order by Monthly_Sales desc;

-- Yearly sales trend
SELECT DATE_FORMAT(Order_Date, '%Y') AS Years, SUM(Sales) AS Monthly_Sales
FROM sales_data
GROUP BY Years
order by Monthly_Sales desc;

--  Monthly Sales Trend
-- Group sales and profit by month and year to observe trends over time:
SELECT 
    DATE_FORMAT(Order_Date, '%Y-%m') AS Month,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM sales_data
GROUP BY Month
ORDER BY Month;

-- Sales by Customer Segment
SELECT 
    Customer_Segment,
    COUNT(DISTINCT Customer_Name) AS Total_Customers,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM sales_data
GROUP BY Customer_Segment
ORDER BY Total_Sales DESC;

-- Shipping Cost Impact on Profit
SELECT 
    Shipping_Cost,
    AVG(Profit) AS Avg_Profit,
    COUNT(*) AS Num_Orders
FROM sales_data
GROUP BY Shipping_Cost
ORDER BY Shipping_Cost;

--  Top 5 Products by Sales
SELECT 
    Product_Name,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM sales_data
GROUP BY Product_Name
ORDER BY Total_Sales DESC
LIMIT 5;


SELECT Ship_Mode,
       AVG(Shipping_Cost) AS Avg_Shipping_Cost,
       AVG(Profit_Margin) AS Avg_Profit_Margin
FROM sales_data
GROUP BY Ship_Mode;

SELECT 
    Product_Sub_Category ,
    SUM(Sales) AS Total_Sales,
    SUM(CAST(Profit AS DECIMAL(10,2))) AS Total_Profit,
    SUM(Order_Quantity) AS Total_Order_Quantity
FROM sales_data
GROUP BY Product_Sub_Category
ORDER BY Total_Sales DESC;
