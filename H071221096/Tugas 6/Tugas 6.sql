USE classicmodels;

-- Nomor 1
SELECT * FROM employees
SELECT * FROM customers
SELECT * FROM orders
SELECT * FROM orderdetails

SELECT CONCAT(e.firstName , " " , e.lastName) AS "nama employee" , GROUP_CONCAT(o.orderNumber) AS "Nomor Orderan" , COUNT(o.customerNumber) AS "Jumlah pesanan"
FROM employees AS e
JOIN customers AS c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders AS o
USING (customerNumber)
GROUP BY employeeNumber
HAVING COUNT(o.customerNumber) > 10

-- Nomor 2
SELECT * FROM products
SELECT * FROM orders

SELECT p.productCode , p.productName , p.quantityInStock , MIN(o.orderDate)
FROM products AS p 
JOIN orderdetails AS od
USING (productCode)
JOIN orders AS o
USING (orderNumber)
GROUP BY productCode
HAVING (quantityInStock) > 5000

-- Nomor 3
SELECT * FROM offices 
SELECT * FROM employees
SELECT * FROM customers
SELECT * FROM payments

SELECT DISTINCT o.addressLine1 "Alamat", CONCAT(SUBSTRING(o.phone, 1, LENGTH(o.phone) - 9), "* **") "Nomor Telp",  COUNT(DISTINCT e.employeeNumber) "Jumlah Karyawan", 
		COUNT(DISTINCT c.customerNumber) "Jumlah Pelanggan", FORMAT(AVG(amount), 2) "Rata-rata Penghasilan" FROM offices o
JOIN employees e USING (officeCode)
LEFT JOIN customers c ON (c.salesRepEmployeeNumber = e.employeeNumber)
LEFT JOIN payments p USING (customerNumber)
GROUP BY o.addressLine1 
ORDER BY o.phone

-- Nomor 4
SELECT * FROM customers
SELECT * FROM orders
SELECT * FROM orderdetails
SELECT * FROM payments

SELECT c.customerName , YEAR(o.orderDate) AS "tahun order" , MONTHNAME(o.orderDate) AS "bulan order" , 
		COUNT(o.orderNumber) AS "jumlah pesanan" , SUM(od.quantityOrdered * od.priceEach) AS "uang total penjualan"
FROM customers AS c
JOIN orders AS o
USING (customerNumber)
JOIN orderdetails AS od 
USING (orderNumber)
WHERE YEAR(o.orderDate) = 2003
GROUP BY c.customerNumber , YEAR(o.orderDate), MONTHNAME(o.orderDate)

-- Soal Tambahan Nomor 1 
SELECT * FROM employees
SELECT * FROM customers
SELECT * FROM orders 
SELECT * FROM orderdetails

SELECT e.lastName , e.firstName , SUM(od.quantityOrdered * od.priceEach) * 0.05 AS komisi
FROM employees AS e
JOIN customers AS c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders AS o
USING(customerNumber)
JOIN orderdetails AS od 
USING(orderNumber)
GROUP BY employeeNumber
ORDER BY e.lastName , e.firstName DESC 



