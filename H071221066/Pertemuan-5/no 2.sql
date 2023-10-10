-- praktikum pekan 5
USE classicmodels;

-- no 2
-- a. Data nama customer, tanggal pembayaran, dan nama karyawan
SELECT DISTINCT c.customerName AS 'Nama Customer', 
	py.paymentDate AS 'Tanggal Pembayaran', 
	CONCAT(ep.firstName, ' ', ep.lastName) AS 'Nama Karyawan', 
	py.amount
FROM customers c
JOIN orders o USING (customerNumber)
JOIN orderdetails od USING (orderNumber)
JOIN products p USING (productCode)
JOIN payments py USING (customerNumber)
JOIN employees ep ON ep.employeeNumber = c.salesRepEmployeeNumber
WHERE MONTH(py.paymentDate) = 11;

-- b. Pelanggan dengan transaksi terbesar pada bulan November
SELECT c.customerName AS 'Nama Customer', 
	py.paymentDate AS 'Tanggal Pembayaran', 
	CONCAT(ep.firstName, ' ', ep.lastName) AS 'Nama Karyawan', 
	py.amount AS 'Total Transaksi'
FROM customers c
JOIN orders o USING (customerNumber)
JOIN orderdetails od USING (orderNumber)
JOIN products p USING (productCode)
JOIN payments py USING (customerNumber)
JOIN employees ep
ON ep.employeeNumber = c.salesRepEmployeeNumber
WHERE MONTH(py.paymentDate) = 11
ORDER BY py.amount DESC
LIMIT 1;

-- c. Data nama customer dan nama produk yang dibeli
SELECT c.customerName AS 'Nama Customer', p.productName AS 'Nama Produk'
FROM customers c
JOIN orders o USING (customerNumber)
JOIN orderdetails od USING (orderNumber)
JOIN products p USING (productCode)
WHERE c.customerName = 'Corporate Gift Ideas Co.';

-- d. Produk yang dibeli oleh pelanggan dengan transaksi terbanyak
SELECT c.customerName AS 'Nama Customer', GROUP_CONCAT(p.productName) AS 'Nama Produk'
FROM customers c
JOIN orders o USING (customerNumber)
JOIN orderdetails od USING (orderNumber)
JOIN products p USING (productCode)
WHERE c.customerName = 'Corporate Gift Ideas Co.';