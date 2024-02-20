/* Overall view of superstore sales dataset 
Find all unique values for country, product_name, category, sub_category and year) 
Find the total sales, and total quantity sold 
Find the average profit, and discount */

select * from dbo.SuperStoreOrders

SELECT 
COUNT(order_id) as Total_orders,
COUNT(DISTINCT country) as Total_countries,
COUNT(DISTINCT product_name) as Total_products,
COUNT(DISTINCT category) as Total_categories,
COUNT(DISTINCT sub_category) as Total_subcategories,
COUNT(DISTINCT year) as Total_years,
ROUND(SUM(sales), 2) as Total_sales,
SUM(quantity) as Total_quantity_sold,
ROUND(AVG(profit), 2) as Avg_profit,
ROUND(AVG(discount), 2) as Avg_discount
FROM dbo.SuperStoreOrders 

-- sales performance analysis 
-- identify the top-selling products and categories
SELECT TOP 10
product_name, 
category, 
ROUND(SUM(sales), 2) as Total_sales,
SUM(quantity) as Total_quantity_sold
FROM dbo.SuperStoreOrders
GROUP BY product_name, category
ORDER BY SUM(sales) DESC

-- sales over year
SELECT 
year,
ROUND(SUM(sales), 2) as Total_sales
FROM dbo.SuperStoreOrders
GROUP BY year
ORDER BY SUM(sales) DESC

-- customer segmentation 
SELECT 
segment, 
COUNT(DISTINCT customer_name) as Total_customers, 
ROUND(SUM(sales), 2) as Total_sales
FROM dbo.SuperStoreOrders
GROUP BY segment
ORDER BY SUM(sales) DESC

-- Shipping and order management 
SELECT 
ship_mode,
ROUND(AVG(shipping_cost), 2) as Avg_Shipping_Cost,
ROUND(AVG(profit), 2) as Avg_Profit
FROM dbo.SuperStoreOrders
GROUP BY ship_mode
ORDER BY AVG(profit) DESC


-- Time analysis use try_cast can be treated as a date
SELECT ship_mode,
AVG(DATEDIFF(DAY, TRY_CAST(order_date AS DATE), TRY_CAST(ship_date AS DATE))) as Avg_time_gape
FROM dbo.SuperStoreOrders
GROUP BY ship_mode

-- Profibility and cost analysis 
SELECT 
product_name,
category,
sub_category,
ROUND(AVG(profit), 2) as Avg_Profit,
ROUND(AVG(discount), 2) as Avg_Discount
FROM dbo.SuperStoreOrders
GROUP BY 
product_name,
category,
sub_category
ORDER BY AVG(profit) DESC

-- Global sales and quantity product overview 
-- The distribution of sales across different countries
-- The most sold products in each country
SELECT
country,
ROUND(SUM(sales), 2) as Total_Sales,
SUM(quantity) as Total_quantity
FROM dbo.SuperStoreOrders
GROUP BY country
ORDER BY SUM(sales) DESC

-- State level categoty exploration 
SELECT 
state,
product_name,
category,
SUM(quantity) as Total_quantity_sold
FROM dbo.SuperStoreOrders
GROUP BY 
state,
product_name,
category
ORDER BY SUM(quantity) DESC

-- Regional Sub-Category Analysis
SELECT
region,
sub_category,
SUM(quantity) as Total_quantity_sold
FROM dbo.SuperStoreOrders
GROUP BY region,
sub_category
ORDER BY SUM(quantity) DESC