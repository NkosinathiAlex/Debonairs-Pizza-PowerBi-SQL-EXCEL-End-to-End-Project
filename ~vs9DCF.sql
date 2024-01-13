use Pizzas;

SELECT  * FROM shop;

--Total Revenue 
select   Round(sum(total_price),2) AS Total_Revenue from shop ;

--Average order Value
Select Round((SUM(total_price) / COUNT(Distinct order_id)),2) AS Average_order_value
from shop;

--Sum of all the Pizzas sold
SELECT  Round(SUM(quantity),2)
from shop

--Count  of all orders made
SELECT ROUND(Count( DISTINCT order_id),2)
from shop

--Average orders made by each Customer
SELECT Round((SUM(quantity) / Count( DISTINCT order_id)),2)
from shop


--Daily Trend from our orders

SELECT DATENAME(DW, order_date) as order_day, COUNT(DISTINCT order_id ) AS Total_orders
from shop
group by DATENAME(DW, order_date)


--Monthly trend from our orders
SELECT DATENAME(MONTH, order_date) as order_Month, COUNT(DISTINCT order_id ) AS Total_orders
from shop
group by DATENAME(MONTH, order_date)
order by Total_orders DESC

--Percentage of Sales  by  Category
SELECT DISTINCT pizza_category,  Round(100 * SUM(total_price)  over(Partition by pizza_category ) / SUM(total_price) OVER(),2) AS percentage
from shop

--Percentage of Sales by Pizza Size:
SELECT DISTINCT pizza_size,  Round(100 * SUM(total_price)  over(Partition by pizza_size ) / SUM(total_price) OVER(),2) AS percentage
from shop
order by percentage DESC;


--Top 5 Pizzas by Revenue
SELECT top 5 pizza_name, sum(total_price) AS Total_Revenue 
from shop
group by pizza_name
order by Total_Revenue DESC

---Bottom 5 Pizzas by Revenue
SELECT top 5 pizza_name, sum(total_price) AS Total_Revenue 
from shop
group by pizza_name
order by Total_Revenue ASC

---Top 5 Pizzas by Quantity
SELECT top 5 pizza_name, sum(quantity) AS Total_Quantity 
from shop
group by pizza_name
order by Total_Quantity DESC

--Bottom 5 Pizzas by Qauntity
SELECT top 5 pizza_name, sum(quantity) AS Total_Quantity
from shop
group by pizza_name
order by Total_Quantity ASC

select distinct pizza_name
from shop


--Peak Order time
With cte as(
select  
  CASE WHEN  DATEPART(HOUR, order_time) BETWEEN  8 AND  11 THEN '8-11'
   WHEN  DATEPART(HOUR, order_time) BETWEEN  12 AND  15 THEN '12-15'
     WHEN  DATEPART(HOUR, order_time) BETWEEN  16 AND  19 THEN '16-19'
	WHEN  DATEPART(HOUR, order_time) BETWEEN  20 AND  23 THEN '20-23'
	END  AS PeakHour, order_id
from shop)
select  PeakHour, Round(count( Distinct order_id),2) AS Total_Revenue
from cte
group by PeakHour
order by Total_Revenue DESC


