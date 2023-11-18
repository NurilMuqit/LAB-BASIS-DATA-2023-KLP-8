USE classicmodels;

-- Nomor 1

SELECT * FROM customers
SELECT * FROM products
SELECT * FROM orders
SELECT * FROM payments
SELECT * FROM orderdetails 

SELECT c.customerName, p.productName, pa.paymentDate, o.status
FROM customers AS c
JOIN payments AS pa
USING (customerNumber)
JOIN orders AS o 
USING (customerNumber)
JOIN orderdetails AS od
USING (orderNumber)
JOIN products AS p
USING (productCode)
WHERE productName LIKE "%Ferrari%" AND STATUS = "Shipped"

-- Nomor 2 a 

SELECT * FROM customers
SELECT * FROM payments
SELECT * FROM employees 

SELECT c.customerName, p.paymentDate, e.lastName, e.firstName
FROM payments AS p
JOIN customers AS c
USING (customerNumber)
JOIN employees AS e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE MONTH (paymentDate) = 11

-- Nomor 2 b

SELECT c.customerName, p.paymentDate, e.lastName, e.firstName
FROM payments AS p
JOIN customers AS c
USING (customerNumber)
JOIN employees AS e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE MONTH (paymentDate) = 11
ORDER BY amount DESC
LIMIT 1

-- Nomor 2 c

SELECT c.customerName, p.productName
FROM customers AS c
JOIN orders AS o 
USING (customerNumber)
JOIN orderdetails AS od
USING (orderNumber)
JOIN products AS p
USING (productCode)
WHERE customerName = "Corporate Gift Ideas Co."

-- Nomor 2 d

SELECT c.customerName, GROUP_CONCAT(p.productName) productList 
FROM customers AS c
JOIN payments AS pa
USING (customerNumber)
JOIN orders AS o 
USING (customerNumber)
JOIN orderdetails AS od
USING (orderNumber)
JOIN products AS p
USING (productCode)
WHERE customerName = "Corporate Gift Ideas Co."

-- Nomor 3

SELECT c.customerName , DATEDIFF(o.shippedDate , o.orderDate) waitingTime 
FROM customers AS c
JOIN orders AS o
USING (customerNumber)
WHERE customerName = "GiftsForHim.com"

-- Nomor 4 

USE world;

SELECT * FROM country 
WHERE Code LIKE "C%K" AND lifeExpectancy IS NOT NULL 

-- Nomor 1 tambahan

SELECT * FROM orders 
WHERE STATUS = "in process"

UPDATE orders 
SET STATUS = "Shipped"
WHERE STATUS = "in process"

-- Nomor 2 tambahan

SELECT * FROM orders 
SELECT * FROM payments 

SELECT o.orderNumber , p.paymentDate
FROM orders AS o
JOIN payments AS p
USING (customerNumber)
WHERE paymentDate < "2003-10-10"




