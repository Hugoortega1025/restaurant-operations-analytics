-- Query 1 : Total Revenue Summary
SELECT
	SUM(TotalPrice) as total_revenue,
    COUNT(*) as total_orders,
    ROUND(AVG(TotalPrice), 2) as avg_order_value
FROM `ORDER`
WHERE Status = 'Delivered';



-- Query 2 : Revenue by month
SELECT
	DATE_FORMAT(OrderDate, '%Y-%m') as month,
    COUNT(*) as total_orders,
    SUM(TotalPrice) as monthly_revenue,
    ROUND(AVG(TotalPrice), 2) as avg_order_value    
FROM `ORDER`
WHERE status = 'Delivered'
GROUP BY DATE_FORMAT(OrderDate, '%Y-%m')
ORDER BY month;



-- Query 3: Peak order hours by day of week
SELECT 
    DAYNAME(OrderDate) AS day_of_week,
    DAYOFWEEK(OrderDate) AS day_num,
    HOUR(OrderTime) AS hour,
    COUNT(*) AS total_orders
FROM `ORDER`
WHERE Status = 'Delivered'
GROUP BY DAYNAME(OrderDate), DAYOFWEEK(OrderDate), HOUR(OrderTime)
ORDER BY day_num, hour;

-- Query 4: Top 5 pizzas by volume sold
SELECT
p.Name, p.Size, SUM(po.Quantity) as total_sold
FROM PIZZA as p
INNER JOIN PIZZA_ORDER as po
ON p.PizzaID = po.PizzaID
GROUP BY p.PizzaID, p.Name, p.Size
ORDER BY total_sold DESC
LIMIT 5;

-- Query 5 : Bottom 5 pizzas by volume sold
SELECT
p.Name, p.Size, SUM(po.Quantity) as total_sold
FROM PIZZA as p
INNER JOIN PIZZA_ORDER as po
ON p.PizzaID = po.PizzaID
GROUP BY p.PizzaID, p.Name, p.Size
ORDER BY total_sold ASC
LIMIT 5;



-- Query 6: Top 5 pizzas by revenue generated
SELECT
p.Name, p.Size, SUM(po.Quantity * p.Price) as total_revenue
FROM PIZZA as p
INNER JOIN PIZZA_ORDER as po
ON p.PizzaID = po.PizzaID
GROUP BY p.PizzaID, p.Name, p.Size
ORDER BY total_revenue DESC
LIMIT 5;

-- Query 7 : Bottom 5 pizzas by revenue generated
SELECT
p.Name, p.Size, SUM(po.Quantity * p.Price) as total_revenue
FROM PIZZA as p
INNER JOIN PIZZA_ORDER as po
ON p.PizzaID = po.PizzaID
GROUP BY p.PizzaID, p.Name, p.Size
ORDER BY total_revenue ASC
LIMIT 5;

-- Query 8 : Revenue by Day of Week
SELECT
	DAYNAME(OrderDate) as day_of_week,
    DAYOFWEEK(OrderDate) as day_num,
    COUNT(*) as total_orders,
    ROUND(SUM(TotalPrice),2) as total_revenue,
    ROUND(AVG(TotalPrice),2) as avg_order_value
FROM `ORDER`
WHERE Status = 'Delivered'
GROUP BY day_of_week, day_num
ORDER by day_num;


-- QUERY 9: Overall store cancel rate benchmark
SELECT 
    COUNT(*) AS total_orders,
    SUM(CASE WHEN Status = 'Cancelled' THEN 1 ELSE 0 END) AS total_cancelled,
    ROUND(SUM(CASE WHEN Status = 'Cancelled' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS overall_cancel_rate
FROM `ORDER`;


-- Query 10: Cancelled order rate overall and by day of week
SELECT 
    DAYNAME(OrderDate) AS day_of_week,
    DAYOFWEEK(OrderDate) AS day_num,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN Status = 'Cancelled' THEN 1 ELSE 0 END) AS cancelled_orders,
    ROUND(SUM(CASE WHEN Status = 'Cancelled' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS cancel_rate_pct
FROM `ORDER`
GROUP BY DAYNAME(OrderDate), DAYOFWEEK(OrderDate)
ORDER BY day_num;



-- Query 11: Employee Performance & Cancel order rate overall
SELECT 
    E.Name as employee_name,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN O.Status = 'Cancelled' THEN 1 ELSE 0 END) AS cancelled_orders,
    ROUND(SUM(CASE WHEN O.Status = 'Cancelled' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS cancel_rate_pct
FROM `ORDER` as O
INNER JOIN EMPLOYEE as E
ON O.EmployeeID = E.EmployeeID
GROUP BY E.EmployeeID, E.Name
ORDER BY cancel_rate_pct DESC;


-- Query 12: Top 10 Customers
SELECT 
C.name as customer_name,
C.email,
C.Phone,
COUNT(*) as total_orders,
SUM(TotalPrice) as total_spend
FROM CUSTOMER as C
INNER JOIN `ORDER` as O
ON C.CustomerID = O.CustomerID
WHERE Status = 'Delivered'
GROUP BY C.CustomerID ,customer_name, C.email,C.Phone
ORDER BY total_spend DESC
LIMIT 10;


