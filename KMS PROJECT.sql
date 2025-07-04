
----------------KMS PROJECT------------------
SELECT * FROM KMS_db 
------------Change profit, unit price and shipping_cost data type to decimal 10,3 ------------
ALTER TABLE KMS_db 
ALTER COLUMN Shipping_Cost decimal(10, 3);

ALTER TABLE KMS_db 
ALTER COLUMN Profit decimal (10,3);

ALTER TABLE KMS_db 
ALTER COLUMN Unit_Price decimal (10,3)

SELECT * FROM KMS_db

DROP VIEW kmscase1
------------------Create a view table to select some columns-------------------
CREATE VIEW kmscase1
AS
SELECT Row_ID, Sales,Ship_Mode, Profit, Shipping_Cost, Customer_Name, Province, Region, Product_Category, Product_Name, Product_Sub_Category
FROM KMS_db

SELECT *  FROM kmscase1

-------------1:  Product category that had highest sales------------
SELECT TOP 1 Product_Category, sum (Sales) as sales
FROM kmscase1
GROUP BY Product_Category
ORDER By sales Desc
-------------Technology was the product category that had the highest sales---------

----------------2: Top 3 and bottom 3 region in terms of sales-------
SELECT Top 3 Region, sum (Sales) as sales
FROM kmscase1
GROUP BY Region
ORDER By sales Desc

SELECT Top 3 Region, sum (Sales) as sales
FROM kmscase1
GROUP BY Region
ORDER By sales Asc;
-----------Top 3 and Bottom 3 in terms of sales were West, Ontario and Prarie and Nunavut, Northwest Territories and Yukon respectively--------------

-----------------3: Total sales of appliance in ontario-------------
SELECT Province, sum (Sales) as Tot_sale_of_app
FROM kmscase1
WHERE Province = 'Ontario' AND Product_Sub_Category = 'Appliances'
GROUP BY Province
----------------Total sales of appliances in ontario was 202350---------------
select * from kms_db
--------------4: Advice for the management------------- 
SELECT TOP 10 Customer_Name, sum(Unit_Price * Order_Quantity) as Total_revenue1
FROM kms_db
GROUP BY Customer_Name
ORDER BY Total_revenue1 asc
-------------The management should increase the order_order to atleast 3 per order.
--------------5: The most costly method of shipping --------------
SELECT Top 1 Ship_Mode, sum(Shipping_Cost) as Total_Cost
	FROM kmscase1
	GROUP BY Ship_Mode
	ORDER BY Total_Cost Desc
----------------the most costly shipping cost was Delivery Truck------------
---------------CASE2-------------
-------------6: The most valuable customer--------------
SELECT TOP 3 Customer_name, sum (Order_Quantity) as Tot_Prod_Services, sum (Unit_Price) as Total_Price
	FROM kms_db
	GROUP BY Customer_name
	ORDER BY Total_Price Desc

SELECT DISTINCT  Customer_Name, Product_Name
FROM kms_db
WHERE Customer_Name = 'Roy Phan'
-------------The most valuable customer is Darren Budd-----------------

-------------------7: SMALL businness customer with the highest sales-----------------
SELECT TOP 1 Customer_Segment, Customer_Name, Sales 
	FROM kms_db
	WHERE Customer_Segment = 'Small Business'
	ORDER BY Sales Desc
--------------------8: Corporate customers with the most number of orders in 2009-2012-----------------
SELECT TOP 1 Customer_Name,  SUM (Order_Quantity) as Total_Order
	FROM kms_db
	WHERE Customer_Segment = 'Corporate' AND Order_Date BETWEEN '2009-01-01' AND '2012-12-31'
	GROUP BY Customer_Name
	ORDER BY Total_Order DESC
----------------Roy Skaria with 773 orders---------------

	--------------9:The most profitable consumer customer-------------------
	SELECT TOP 1 Customer_Name,  SUM (Profit) as Total_Profit
	FROM kms_db
	WHERE Customer_Segment = 'Consumer'
	GROUP BY Customer_Name
	ORDER BY Total_Profit DESC
---------------EMILY PHAN----------------------
	----------------10: ----------------------
	SELECT DISTINCT kms_db.Customer_Name, kms_db.Customer_Segment
	FROM kms_db
	JOIN dbo.Order_Status AS Order_Status ON
	kms_db.Order_ID= Order_Status.Order_ID
	WHERE Order_Status.Status = 'Returned'
-------------The customers that returned items are many-------------
----------------question 11--------------
SELECT * from kms_db
 SELECT Ship_Mode, Order_Priority, Shipping_Cost
 from kms_db