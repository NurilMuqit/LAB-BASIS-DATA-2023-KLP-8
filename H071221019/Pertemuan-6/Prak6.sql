USE classicmodels

-- 1
SELECT CONCAT(e.firstname, ' ', e.lastname) AS 'Nama Employee', 
		GROUP_CONCAT(o.orderNumber SEPARATOR ', ') AS 'Nomor Orderan', 
		COUNT(o.customerNumber) AS 'Jumlah Pesanan' 
FROM employees e
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders o USING(customerNumber)
GROUP BY e.employeeNumber
HAVING COUNT(o.customerNumber) > 10 
ORDER BY e.firstname;

-- 2
SELECT p.productCode, p.productName,p.quantityInStock, o.orderDate
FROM products p
JOIN orderdetails od USING(productCode)
JOIN orders o USING(orderNumber)
GROUP BY p.productCode
Having p.quantityInStock > 5000
ORDER BY o.orderDate;

-- 3
SELECT oc.addressLine1 AS 'Alamat',
		CONCAT(LEFT(oc.phone,6),'* **') AS 'Nomor Telp', 
		COUNT(DISTINCT e.employeeNumber) AS 'Jumlah Karyawan',
		COUNT(DISTINCT c.customerNumber) AS 'Jumlah Pelanggan',
		FORMAT(AVG(py.amount),2) AS 'Rata-rata Penghasilan'
FROM offices oc
LEFT JOIN employees e USING(officeCode)
LEFT JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
LEFT JOIN payments py USING(customerNumber)
GROUP BY oc.addressLine1
ORDER BY oc.phone

-- 4
SELECT c.customerName AS 'Nama Pelanggan',
		YEAR(o.orderDate) 'Tahun Order',
		MONTHNAME(o.orderDate) 'Bulan Order',
		COUNT(o.orderNumber) AS 'Jumlah Pesanan' ,
		SUM(od.priceEach * od.quantityOrdered) AS 'Uang Total Penjualan'
FROM customers c
JOIN orders o USING(customerNumber)
JOIN orderdetails od USING(orderNumber)
JOIN payments py USING(customerNumber)
WHERE YEAR(o.orderDate) = 2003       
GROUP BY c.customerName, MONTH(o.orderDate);

-- 5
SELECT c.customerName AS 'Nama Pelanggan', 
		ROUND(AVG(DATEDIFF(o.shippedDate, o.orderDate))) as 'Rata-rata Selisih Hari'
FROM orders o
JOIN customers c USING(customerNumber)
GROUP BY c.customerName
ORDER BY AVG(DATEDIFF(o.shippedDate, o.orderDate)) DESC;


 