USE PIZZA_dataset;
select * from pizza_sales;

--1. total revenue
select sum(total_price) as total_revenue from pizza_sales;
--2. Average Order Value
select sum(total_price)/count(distinct order_id) from pizza_sales
--3. Total Pizza Sold
select sum(quantity) as Total_Pizza_Sold from pizza_sales;
--4. Total Orders
select count(distinct order_id) as total_order from pizza_sales;
--5. Average pizza per order
select cast(cast(sum(quantity) as decimal(10,2))/
cast(count(distinct order_id) as decimal(10, 2)) as decimal(10,2)) as avg_pizza_per_order
from pizza_sales;

-- Daily Trend for total orders
select datename(dw, order_date) as order_day, count(distinct order_id) as total_orders
from pizza_sales
group by DATENAME(dw, order_date);

-- Hourly Trend for orders
select DATEPART(HOUR, order_time) as order_hours, count(distinct order_id) 
from pizza_sales
group by DATEPART(hour, order_time)
order by datepart(hour, order_time);

-- Percentage of sales by Pizza Category
SELECT pizza_category, sum(total_price) * 100 / (SELECT sum(total_price) from pizza_sales) as Total_Sales
from pizza_sales 
GROUP BY pizza_category;

--% of sales by pizza size
SELECT pizza_size, sum(total_price), sum(total_price) * 100 / (SELECT sum(total_price) from pizza_sales) as PCT
from pizza_sales 
GROUP BY pizza_size
order by pct desc;

--Total pizza sold by pizza category
SELECT pizza_category, SUM(quantity) as Total_Quantity_Sold
FROM pizza_sales
WHERE MONTH(order_date) = 2
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC

--Top 5 Best Sellers by Total Pizzas Sold
SELECT Top 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC

--Bottom 5 Best Sellers by Total Pizzas Sold
SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC
