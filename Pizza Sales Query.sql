------KPI's REQUIREMENTS

--All Data

SELECT *
FROM pizza_sales;


--Total Revenue

SELECT SUM(total_price) AS Total_Revenue 
FROM pizza_sales;


--Average Order Value

SELECT (SUM(total_price) / COUNT(DISTINCT order_id)) AS Avg_order_Value 
FROM pizza_sales;


--Total Pizza Sold

SELECT SUM(quantity) AS Total_pizza_sold
FROM pizza_sales;


--Total Order

SELECT COUNT(DISTINCT order_id) AS Total_Orders 
FROM pizza_sales;


--Average Pizza Per Order

SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS Avg_Pizzas_per_order
FROM pizza_sales;



------CHARTS REQUIREMENTS


-- Daily trend for Total Order

SELECT 
	DATENAME(DW, order_date) AS Order_day,
	COUNT(DISTINCT order_id) AS Total_orders
FROM pizza_sales
GROUP BY DATENAME(DW, order_date);


--Monthly trend for Total Order

SELECT 
	DATENAME(MONTH, order_date) AS Month_Name,
	COUNT(DISTINCT order_id) AS Total_orders
FROM pizza_sales
GROUP BY DATENAME(MONTH, order_date);


--Percentage of Sales by Pizza Category 

SELECT Pizza_category, SUM(total_price) AS Total_sales,
	SUM(total_price) * 100 /
		(SELECT 
			SUM(total_price) 
		FROM pizza_sales
		WHERE MONTH(order_date) = 1) AS PCT
FROM pizza_sales
WHERE MONTH(order_date) = 1
GROUP BY pizza_category;


--Percentage of Sales by Pizza size

SELECT pizza_size, CAST(SUM(total_price) AS decimal (10,2)) AS Total_sales,
	CAST(SUM(total_price) * 100 /
		(SELECT 
			SUM(total_price) 
		FROM pizza_sales
		WHERE DATEPART(QUARTER, order_date) = 1) AS decimal (10,2))AS PCT
FROM pizza_sales
WHERE DATEPART(QUARTER, order_date) = 1
GROUP BY pizza_size
ORDER BY PCT ASC ;


--Top 5 Best sellers by Revenue, Total quantity and Total Order

SELECT TOP 5 pizza_name, 
		SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC;


--Bottom 5 Best sellers by Revenue, Total quantity and Total Order

SELECT TOP 5 pizza_name, 
		SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC;


--Top 5 Best sellers by Total quantity

SELECT TOP 5 pizza_name, 
		SUM(quantity) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity DESC;

--Top 5 Best sellers by Total Order

SELECT TOP 5 pizza_name, 
		COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC;