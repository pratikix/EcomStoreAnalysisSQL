-- 1. List the top 10 orders with the highest sales from the EachOrderBreakdown table

SELECT * 
FROM Eachorderbreakdown
ORDER BY SALES DESC
LIMIT 10;


-- 2. Show the number of orders for each product category in the EachOrderBreakdown table

SELECT category , COUNT(category) AS NumberOfOrders
FROM eachorderbreakdown
GROUP BY category
ORDER BY NumberOfOrders DESC


-- 3. Find the total profit for each sub-category in the EachOrderBreakdown table

SELECT category , SUM(profit) AS ProfitByCategory
FROM eachorderbreakdown
GROUP BY category
ORDER BY  ProfitByCategory DESC


-- 4. Identify the customer with the highest total sales across all orders.

SELECT  ol.customername , SUM(eo.sales) as totalsales
FROM orderlist ol
JOIN eachorderbreakdown eo on eo.orderid = ol.orderid
GROUP BY ol.customername
ORDER BY  totalsales DESC

--5. Find the month with the highest average sales in the OrdersList table

SELECT EXTRACT('MONTH' FROM orderdate)
FROM orderlist

SELECT  EXTRACT('MONTH' FROM orderdate)as months , AVG(sales) as av
FROM orderlist ol
JOIN eachorderbreakdown eo on eo.orderid = ol.orderid
GROUP BY months
ORDER BY  av DESC



--6. Find out the average quantity ordered by customers whose first name starts with an alphabet's'?

SELECT  ol.customername , ROUND(AVG(eo.quantity),2) as quantiti
FROM orderlist ol
JOIN eachorderbreakdown eo on eo.orderid = ol.orderid
WHERE ol.customername  LIKE 'S%'
GROUP BY ol.customername
ORDER BY  quantiti DESC -- Avg quantity by each customer 


SELECT  ROUND(AVG(eo.quantity),2) as quantiti
FROM orderlist ol
JOIN eachorderbreakdown eo on eo.orderid = ol.orderid
WHERE ol.customername  LIKE 'S%'
ORDER BY  quantiti DESC  --Total avg quantity by a customer whose name starts with s


--7. Find out how many new customers were acquired in the year 2014?

SELECT COUNT(*) As NumberOfNewCustomers FROM (
SELECT CustomerName, MIN(OrderDate) AS FirstOrderDate
from Orderlist
GROUP BY CustomerName
Having EXTRACT('YEAR' FROM MIN(OrderDate)) = '2014') AS CustWithFirstOrder2014

--8. Calculate the percentage of total profit contributed by each sub-category to the overall profit


SELECT subcategory,SUM(profit) as ProfitBySubCat , 
SUM(profit)/(SELECT SUM(profit) FROM eachorderbreakdown)*100 as percentage
FROM eachorderbreakdown
GROUP BY subcategory

--9. Find the average sales per customer, considering only customers who have made more than one order.
WITH CustomerAvgSales AS(
SELECT CustomerName, COUNT(DISTINCT ol.OrderID) As NumberOfOrders, AVG(Sales) AS AvgSales
FROM OrderList ol
JOIN EachOrderBreakdown ob
ON ol.OrderID = ob.OrderID 
GROUP BY CustomerName
)
SELECT CustomerName, AvgSales
FROM CustomerAvgSales
WHERE NumberOfOrders > 1



--10.Identify the top-performing subcategory in each category based on total sales. Include the sub-category name, total sales, and a ranking of sub-category within each category.
WITH topsubcategory AS(
SELECT Category, SubCategory, SUM(sales) as TotalSales,
RANK() OVER(PARTITION BY Category ORDER BY SUM(sales) DESC) AS SubcategoryRank
FROM EachOrderBreakdown
Group By Category, SubCategory
)
SELECT *
FROM topsubcategory
WHERE SubcategoryRank = 1




