USE classicmodels

-- 1
SELECT c.customerName, p.productName, py.paymentDate, o.`status`
FROM customers c
JOIN payments py
USING (customerNumber)
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products p
USING (productCode)
WHERE productName LIKE '%Ferrari%' AND 
		STATUS = 'Shipped'

-- 2
-- a
SELECT c.customerName AS 'Nama Pelanggan', 
		py.paymentDate AS 'Tanggal Pembayaran', 
		CONCAT(firstName,' ',lastName) AS 'Nama Karyawan'
FROM customers c
JOIN payments py
USING(customerNumber)
JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE paymentDate LIKE '____-11-__'

-- b
SELECT c.customerName AS 'Nama Pelanggan',
		py.paymentDate AS 'Tanggal Pembayaran', 
		CONCAT(firstName,' ',lastName) AS 'Nama Karyawan'
		-- e.firstName,
-- 		e.lastName
FROM customers c
JOIN payments py
USING(customerNumber)
JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE paymentDate LIKE '____-11-__'
ORDER BY amount desc 
LIMIT 1;

-- c
SELECT c.customerName, p.productName
FROM customers c
JOIN payments py
USING(customerNumber)
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products p
USING (productCode)
WHERE customerName LIKE 'Corporate%'
		AND MONTH(paymentDate) = 11;
	

-- d
SELECT c.customerName AS 'Nama Pelanggan', 
		GROUP_CONCAT(p.productName SEPARATOR ', ') AS 'Nama Produk'
FROM customers c
JOIN payments py
USING(customerNumber)
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products p
USING (productCode)
WHERE customerName LIKE 'Corporate%'
		
-- 3
SELECT customerName, orderDate, shippedDate,
		DATEDIFF(ShippedDate, orderDate) AS 'Lama Pengiriman'
FROM customers
JOIN orders
USING(customerNumber)
WHERE customerName = 'GiftsForhim.com'
ORDER BY DATEDIFF(shippedDate, orderDate) DESC;

-- 4
USE world

SELECT Nama FROM country c
WHERE c.Code LIKE 'C%K' AND c.LifeExpectancy IS NOT NULL;

-- 5
USE classicmodels

SELECT orderNumber, STATUS, shippedDate, quantityOrdered
FROM orders
JOIN orderdetails
USING(orderNumber)
WHERE STATUS = 'Cancelled' AND shippedDate IS NOT NULL;



  