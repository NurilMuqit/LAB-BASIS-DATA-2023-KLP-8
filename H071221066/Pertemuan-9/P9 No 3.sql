-- No 3
-- Tampilkan nama pelanggan, tahun pembuatan produk, jumlah produk,
-- total durasi pengiriman(tgl pengiriman - tanggal pemesanan) dan keterangan target...
USE classicmodels;

(SELECT c.customerName AS 'Nama Pelanggan', 
	GROUP_CONCAT(LEFT(p.productName, 4)) AS 'Tahun Pembuatan', 
	COUNT(p.productCode) AS 'Jumlah Produk', 
	SUM(DATEDIFF(o.shippedDate, o.orderDate)) AS 'Total Durasi Pengiriman',
	CASE 
	WHEN MONTH(o.orderDate) % 2 = 1 AND 
		SUM(DATEDIFF(o.shippedDate, o.orderDate)) > (SELECT AVG(total) FROM (
																	SELECT SUM(DATEDIFF(shippedDate, orderDate)) AS total
																	FROM orders GROUP BY customerNumber) AS a) THEN 'Target 1'
	WHEN MONTH(o.orderDate) % 2 = 0 AND 
		SUM(DATEDIFF(o.shippedDate, o.orderDate)) > (SELECT AVG(total) FROM (
																	SELECT SUM(DATEDIFF(shippedDate, orderDate)) AS total 
																	FROM orders GROUP BY customerNumber) AS a) THEN 'Target 2'
	END 'Keterangan'
	FROM customers AS c
	JOIN orders AS o USING (customerNumber)
	JOIN orderdetails AS od USING (orderNumber)
	JOIN products AS p USING (productCode)
	WHERE LEFT(p.productName, 4) BETWEEN 1800 AND 1899
	GROUP BY c.customerNumber
	HAVING `keterangan` IS NOT NULL)
	
UNION

(SELECT c.customerName,
	GROUP_CONCAT(LEFT(p.productName, 4)), 
	COUNT(p.productCode),
	SUM(DATEDIFF(o.shippedDate, o.orderDate)),
	CASE 
	WHEN MONTH(o.orderDate) % 2 = 1 AND 
		COUNT(p.productCode) > (SELECT AVG(total) * 10 FROM (	
										SELECT COUNT(productCode) AS total 
										FROM products GROUP BY productCode) AS a) THEN 'Target 3'
	WHEN MONTH(o.orderDate) % 2 = 0 AND 
		COUNT(p.productCode) > (SELECT AVG(total) * 10 FROM (	
										SELECT COUNT(productCode) AS total 
										FROM products GROUP BY productCode) AS a) THEN 'Target 4'
	END 'Keterangan'
	FROM customers AS c
	JOIN orders AS o USING (customerNumber)
	JOIN orderdetails AS od USING (orderNumber)
	JOIN products AS p USING (productCode)
	WHERE p.productName LIKE '19%'
	GROUP BY c.customerNumber
	HAVING `keterangan` IS NOT NULL)
	
UNION

(SELECT c.customerName,
		GROUP_CONCAT(LEFT(p.productName, 4)), 
		COUNT(p.productCode),
		SUM(DATEDIFF(o.shippedDate, o.orderDate)),
		CASE 
		WHEN MONTH(o.orderDate) % 2 = 1 AND 
			COUNT(p.productCode) > (SELECT MIN(total) * 3 FROM (
											SELECT COUNT(productCode) AS total 
											FROM products GROUP BY productCode) AS a) THEN 'Target 5'
		WHEN MONTH(o.orderDate) % 2 = 0 AND 
			COUNT(p.productCode) > (SELECT MIN(total) * 3 FROM (
											SELECT COUNT(productCode) AS total 
											FROM products GROUP BY productCode) AS a) THEN 'Target 6'
	END 'keterangan'
	FROM customers AS c
	JOIN orders AS o USING (customerNumber)
	JOIN orderdetails AS od USING (orderNumber)
	JOIN products AS p USING (productCode)
	WHERE p.productName LIKE '20%'
	GROUP BY c.customerNumber
	HAVING `keterangan` IS NOT NULL);