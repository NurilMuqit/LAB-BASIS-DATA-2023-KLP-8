# Nomor 1
USE classicmodels
SELECT 
	c.customerName,
	pr.productName,
	p.paymentDate,
	o.`status`
FROM payments AS p
JOIN customers AS c USING(customerNumber)
JOIN orders AS o USING(customerNumber)
JOIN orderdetails AS od USING(orderNumber)
JOIN products AS pr USING(productCode)
WHERE o.`status` = 'Shipped' AND pr.productName LIKE '%Ferrari%';

# Nomor 2

-- Bagian A
SELECT 
	c.customerName AS Nama_Customer,
	p.paymentDate AS Tanggal_Pembayaran,
	e.firstName AS First_Name_Employee,
	e.lastName AS Last_Name_Employee
FROM payments AS p
JOIN customers AS c USING(customerNumber)
JOIN employees AS e ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE MONTH(p.paymentDate) = 11;

-- Bagian B
SELECT 
	c.customerName AS Nama_Customer,
	p.paymentDate AS Tanggal_Pembayaran,
	e.firstName AS First_Name_Employee,
	e.lastName AS Last_Name_Employee
FROM payments AS p
JOIN customers AS c USING(customerNumber)
JOIN employees AS e ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE p.paymentDate LIKE '%-11-%'
ORDER BY p.amount DESC
LIMIT 1;

-- Bagian C
SELECT 
	c.customerName AS Nama_Customer,
	pr.productName AS Nama_Produk
FROM customers AS c
JOIN orders AS o USING(customerNumber)
JOIN orderdetails AS od USING(orderNumber)
JOIN products AS pr USING(productCode)
WHERE c.customerNumber = 321;


-- Bagian D
SELECT 
 c.customerName AS Nama_Customer, GROUP_CONCAT(DISTINCT pr.productName) AS Produk_Yang_Dibeli
FROM payments AS p
JOIN 
	customers c USING(customerNumber)
JOIN 
 orders o ON c.customerNumber = o.customerNumber
JOIN 
 orderdetails od ON o.orderNumber = od.orderNumber
JOIN 
 products pr ON od.productCode = pr.productCode
WHERE 
 c.customerName = 'Corporate Gift Ideas Co.' AND MONTH(p.paymentDate) = 11;
 
# Nomor 3
SELECT 
 c.customerName AS Nama_Customer, 
 o.orderDate AS Tanggal_Order, 
 o.shippedDate AS Tanggal_Pengiriman,
 o.shippedDate - o.orderDate AS Lama_Tunggu_Hari
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
WHERE c.customerName = 'GiftsForHim.com';

# Nomor 4
USE world;
SELECT *
FROM 
 Country
WHERE 
 Code LIKE 'C%K' AND lifeExpectancy IS NOT NULL;
 
 # Soal Tambahan
 # Nomor 1
 USE classicmodels;
 
UPDATE orders
SET status = 'Shipped'
WHERE status = 'On process';

# Nomor 2
SELECT 
	o.orderNumber AS Nomor_Order,
	p.paymentDate AS Tanggal_Pembayaran
FROM payments AS p
JOIN customers AS c
USING(customerNumber)
JOIN orders AS o
USING(customerNumber)
WHERE p.paymentDate < '2003-10-10';





