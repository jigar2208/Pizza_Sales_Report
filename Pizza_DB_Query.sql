-- 1. find total revenue : total price 
select sum(total_price) as total_revenue from pizza_sales

--2. avg order value
select sum(total_price) / count(distinct order_id) as avg_order_value from pizza_sales

--3. total pizza sold
select sum(quantity) as total_pizza_sold from pizza_sales

--4. total order place
select count(distinct order_id) as total_orders  from pizza_sales

--5. avg pizza per order
select cast(cast(sum(quantity) as decimal(10,2))/count(distinct order_id) as decimal(10,2)) as avg_pizza_per_order from pizza_sales

--6. trend on day base
select DATENAME(dw, order_date) as order_day, count(distinct order_id) as total_orders
from pizza_sales
group by DATENAME(dw, order_date)

--7. monthy order trend
select DATENAME(MONTH, order_date) as Month_name, count(distinct order_id) as total_orders
from pizza_sales
group by DATENAME(MONTH, order_date)
order by total_orders desc

--8. percentage of sale
select pizza_category, sum(total_price) * 100 / 
(select sum(total_price) from pizza_sales where month(order_date) = 1) as percentage_of_sale
from pizza_sales
where month(order_date) = 1
group by pizza_category

--9. percentage of sale by size
select pizza_size, cast(sum(total_price) as decimal(10,2)) as total_sale,cast(sum(total_price) * 100 / 
(select sum(total_price) from pizza_sales where datepart(quarter, order_date) = 1)  as decimal(10,2))as percentage_of_sale
from pizza_sales
where datepart(quarter, order_date) = 1
group by pizza_size
order by percentage_of_sale desc

--10. top 5 pizza by revenued 
select top 5 pizza_name, sum(total_price) as total_price
from pizza_sales
group by pizza_name
order by total_price desc

--11. bottom 5 pizza by revenued 
select top 5 pizza_name, cast(sum(total_price) as decimal(10,2)) as total_price
from pizza_sales
group by pizza_name
order by total_price 

--12 top 5 pizza by quantity 
select top 5 pizza_name, sum(quantity) as total_quantity
from pizza_sales
group by pizza_name
order by total_quantity desc

--13.bottom 5 pizza by quantity
select top 5 pizza_name, sum(quantity) as total_quantity
from pizza_sales
group by pizza_name

--14. top 5 pizza by orders 
select top 5 pizza_name, count(order_id) as total_quantity
from pizza_sales
group by pizza_name
order by total_quantity desc


--14.bottom 5 pizza by orders 
select top 5 pizza_name, count(order_id) as total_quantity
from pizza_sales
group by pizza_name
order by total_quantity 
