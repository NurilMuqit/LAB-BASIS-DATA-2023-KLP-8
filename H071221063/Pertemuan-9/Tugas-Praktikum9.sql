#1
SELECT YEAR(orderDate) AS 'tahun', COUNT(orderNumber) AS 'jumlah pesanan', 
CASE
WHEN COUNT(orderNumber) > 150 
	THEN 'banyak'
WHEN COUNT(orderNumber) < 75 
	THEN 'sedikit'
	ELSE 'sedang' 
END AS 'kategori pesanan'
FROM orders
GROUP BY YEAR(orderDate)

#2
SELECT CONCAT(e.firstName, ' ' , e.lastName) AS 'nama pegawai', SUM(p.amount) AS 'gaji', 
CASE
WHEN SUM(amount) > (SELECT AVG(amountTotal) 
						  FROM (SELECT SUM(amount) amountTotal 
						  FROM customers
						  JOIN payments 
						  USING (customerNumber) 
						  JOIN employees
						  ON salesRepEmployeeNumber = employeeNumber
						  GROUP BY employeeNumber) AS a) 
		THEN 'di atas rata-rata'
		ELSE 'di bawah rata-rata'
END AS 'kategori gaji'
FROM employees AS e 
JOIN customers AS c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments AS p
USING (customerNumber)
GROUP BY employeeNumber
ORDER BY `gaji` DESC

#3
SELECT customerName 'pelanggan', 
    GROUP_CONCAT(LEFT(productName,4) SEPARATOR ', ') 'tahun pembuatan', 
    COUNT(productCode) 'jumlah produk', 
    SUM(DATEDIFF(shippedDate, orderDate)) 'total durasi pengiriman', 
CASE 
WHEN MONTH(orderDate) % 2 = 1 AND SUM(DATEDIFF(shippedDate, orderDate)) > (SELECT AVG(total) FROM (SELECT SUM(DATEDIFF(shippedDate, orderDate)) AS total FROM orders GROUP BY customerNumber)a1) THEN 'target 1' 
WHEN MONTH(orderDate) % 2 = 0 AND SUM(DATEDIFF(shippedDate, orderDate)) > (SELECT AVG(total) FROM (SELECT SUM(DATEDIFF(shippedDate, orderDate)) AS total FROM orders GROUP BY customerNumber)a) THEN 'target 2' 
END 'keterangan' 
FROM orders
JOIN customers USING (customerNumber)
JOIN orderdetails USING (orderNumber)
JOIN products USING (productCode)
WHERE LEFT(productName,4) BETWEEN 1799 AND 1900
GROUP BY customerName
HAVING keterangan IS NOT NULL
UNION
SELECT customerName 'pelanggan', 
    GROUP_CONCAT(LEFT(productName,4) SEPARATOR ', ') 'tahun pembuatan', 
    COUNT(productCode) 'jumlah produk', 
    SUM(DATEDIFF(shippedDate, orderDate)) 'total durasi pengiriman', 
CASE 
WHEN MONTH(orderDate) % 2 = 1 AND COUNT(productCode) > (SELECT AVG(jumlah)*10 FROM (SELECT COUNT(productname) AS jumlah FROM products GROUP BY productCode)b1) THEN 'target 3' 
WHEN MONTH(orderDate) % 2 = 0 AND COUNT(productCode) > (SELECT AVG(jumlah)*10 FROM (SELECT COUNT(productname) AS jumlah FROM products GROUP BY productCode)b) THEN 'target 4' 
END 'keterangan' 
FROM orders
JOIN customers USING (customerNumber)
JOIN orderdetails USING (orderNumber)
JOIN products USING (productCode)
WHERE LEFT(productName,2) = '19'
GROUP BY customerName
HAVING keterangan IS NOT NULL
UNION
SELECT customerName 'pelanggan', 
    GROUP_CONCAT(LEFT(productName,4) SEPARATOR ', ') 'tahun pembuatan', 
    COUNT(productCode) 'jumlah produk', 
    SUM(DATEDIFF(shippedDate, orderDate)) 'total durasi pengiriman', 
CASE 
WHEN MONTH(orderDate) % 2 = 1 AND COUNT(productCode) > (SELECT MIN(jumlah)*3 FROM (SELECT COUNT(productname) AS jumlah FROM products GROUP BY productCode)c1) THEN 'target 5' 
WHEN MONTH(orderDate) % 2 = 0 AND COUNT(productCode) > (SELECT MIN(jumlah)*3 FROM (SELECT COUNT(productname) AS jumlah FROM products GROUP BY productCode)c) THEN 'target 6' 
END 'keterangan' 
FROM orders
JOIN customers USING (customerNumber)
JOIN orderdetails USING (orderNumber)
JOIN products USING (productCode)
WHERE LEFT(productName,2) = '20'
GROUP BY customerName
HAVING keterangan IS NOT NULL 