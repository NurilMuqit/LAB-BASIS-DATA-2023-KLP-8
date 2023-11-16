USE classicmodels;

-- nomor 1 15rx3c
SELECT CONCAT(e.firstName, ' ', e.lastName) AS 'Nama Employee', GROUP_CONCAT(o.orderNumber) AS 'Nomor Orderan', COUNT(o.orderNumber) AS 'Jumlah Orderan'
FROM employees e
JOIN customers c
ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN orders o
USING(customerNumber)
GROUP BY e.employeeNumber
HAVING COUNT(o.orderNumber) > 10
ORDER BY CONCAT(e.firstName, ' ', e.lastName) ASC;

-- nomor 2
SELECT p.productCode, p.productName, p.quantityInStock, o.orderDate AS 'orderDate'
FROM products p
JOIN orderdetails od
USING(productCode)
JOIN orders o
USING(orderNumber)
WHERE p.quantityInStock > 5000
GROUP BY p.productCode
ORDER BY o.orderDate ASC;

-- nomor 3
SELECT oc.addressLine1 AS 'Alamat', CONCAT(LEFT(oc.phone, 6), '* **') AS 'Nomor Telp', COUNT(DISTINCT e.employeeNumber) AS 'Jumlah Karyawan', COUNT(DISTINCT c.customerNumber) AS 'Jumlah Pelanggan', FORMAT(AVG(p.amount), 2) AS 'Rata-Rata Penghasilan'
FROM offices oc
LEFT JOIN employees e
USING(officeCode)
LEFT JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
LEFT JOIN payments p
USING(customerNumber)
GROUP BY oc.officeCode
ORDER BY oc.phone;

-- nomor 4 107rx5c
SELECT c.customerName, YEAR(o.orderDate) AS 'Tahun Order', MONTHNAME(o.orderDate) AS 'Bulan Order', COUNT(o.orderNumber) AS 'Jumlah Pesanan', SUM(od.priceEach * od.quantityOrdered) AS 'Uang Total Penjualan'
FROM customers c
JOIN orders o
USING(customerNumber)
JOIN orderdetails od
USING(orderNumber)
WHERE YEAR(o.orderDate) = 2003
GROUP BY c.customerName, MONTH(o.orderDate);

-- soal tambahan
-- nomor 1 
-- Hitung komisi untuk setiap penjualan, dengan asumsi komisi sebesar 5% dari nilai penjualan
-- Urutkan berdasarkan nama belakang dan nama depan karyawan
SELECT CONCAT(e.firstName, ' ', e.lastName) AS 'Nama Karyawan', FORMAT(SUM((od.priceEach * od.quantityOrdered) * 0.05), 2) AS 'Komisi'
FROM orderdetails od
JOIN orders o
USING(orderNumber)
JOIN customers c
USING(customerNumber)
JOIN employees e
ON e.employeeNumber = c.salesRepEmployeeNumber
GROUP BY CONCAT(e.firstName, ' ', e.lastName)
ORDER BY CONCAT(e.firstName, ' ', e.lastName);







