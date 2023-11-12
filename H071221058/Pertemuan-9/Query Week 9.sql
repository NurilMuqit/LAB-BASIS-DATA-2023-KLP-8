use classicmodels;
#NOMOR 1
SELECT
    YEAR(orderDate) AS Tahun,
    COUNT(orderNumber) AS JumlahPesanan,
    CASE
        WHEN COUNT(orderNumber) > 150 THEN 'Banyak'
        WHEN COUNT(orderNumber) < 75 THEN 'Sedikit'
        ELSE 'Sedang'
    END AS KategoriPesanan
FROM
    orders
GROUP BY
    Tahun
ORDER BY
    Tahun;


#NOMOR 2
SELECT CONCAT(e.firstName, ' ', e.lastName) nama_pegawai, SUM(py.amount) gaji,
	case
		WHEN SUM(py.amount) > (SELECT AVG(total_gaji) FROM
		                                                  (SELECT SUM(py.amount) AS total_gaji FROM payments py
																	JOIN customers c USING(customerNumber)
																	JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
																	GROUP BY e.employeeNumber) gajitotal) then 'di atas rata rata'
		WHEN SUM(py.amount) < (SELECT AVG(total_gaji) FROM
		                                                  (SELECT SUM(py.amount) AS total_gaji FROM payments py
																	JOIN customers c USING(customerNumber)
																	JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
																	GROUP BY e.employeeNumber) gajitotal) then 'di bawah rata rata'
	END AS kategori_gaji
FROM payments py
JOIN customers c USING(customernumber)
JOIN employees e ON e.employeeNumber = c.salesRepEmployeeNumber
GROUP BY e.employeeNumber
ORDER BY nama_pegawai;

#NOMOR 3
SELECT c.customerName AS 'Nama Pelanggan',
    GROUP_CONCAT(LEFT(p.productName, 4)) AS 'Tahun Pembuatan',
    COUNT(p.productCode) AS 'Jumlah Produk',
    SUM(DATEDIFF(o.shippedDate, o.orderDate)) AS 'Total Durasi Pengiriman',
    CASE
        WHEN MONTH(o.orderDate) % 2 = 1 AND
            SUM(DATEDIFF(o.shippedDate, o.orderDate)) > (SELECT AVG(total) FROM (SELECT SUM(DATEDIFF(shippedDate, orderDate)) AS 'total' FROM orders GROUP BY customerNumber) AS a)
            THEN 'Target 1'
        WHEN MONTH(o.orderDate) % 2 = 0 AND
            SUM(DATEDIFF(o.shippedDate, o.orderDate)) > (SELECT AVG(total) FROM (SELECT SUM(DATEDIFF(shippedDate, orderDate)) AS 'total' FROM orders GROUP BY customerNumber) AS a)
            THEN 'Target 2'
    END AS 'Keterangan'
FROM customers AS c
JOIN orders AS o USING (customerNumber)
JOIN orderdetails AS od USING (orderNumber)
JOIN products AS p USING (productCode)
WHERE LEFT(p.productName, 4) BETWEEN '1800' AND '1899' -- Tahun 1800an
GROUP BY c.customerNumber
HAVING Keterangan IS NOT NULL

UNION

SELECT c.customerName,
    GROUP_CONCAT(LEFT(p.productName, 4)),
    COUNT(p.productCode),
    SUM(DATEDIFF(o.shippedDate, o.orderDate)),
    CASE
        WHEN MONTH(o.orderDate) % 2 = 1 AND
            COUNT(p.productCode) > (SELECT AVG(total) * 10 FROM (SELECT COUNT(productName) AS total FROM products GROUP BY productCode) AS a)
            THEN 'Target 3'
        WHEN MONTH(o.orderDate) % 2 = 0 AND
            COUNT(p.productCode) > (SELECT AVG(total) * 10 FROM (SELECT COUNT(productName) AS total FROM products GROUP BY productCode) AS a)
            THEN 'Target 4'
    END AS 'Keterangan'
FROM customers AS c
JOIN orders AS o USING (customerNumber)
JOIN orderdetails AS od USING (orderNumber)
JOIN products AS p USING (productCode)
WHERE p.productName LIKE '19%'
GROUP BY c.customerNumber
HAVING Keterangan IS NOT NULL

UNION

SELECT c.customerName,
    GROUP_CONCAT(LEFT(p.productName, 4)),
    COUNT(p.productCode),
    SUM(DATEDIFF(o.shippedDate, o.orderDate)),
    CASE
        WHEN MONTH(o.orderDate) % 2 = 1 AND
            COUNT(p.productCode) > (SELECT MIN(total) * 3 FROM (SELECT COUNT(productName) AS total FROM products GROUP BY productCode) AS a)
            THEN 'Target 5'
        WHEN MONTH(o.orderDate) % 2 = 0 AND
            COUNT(p.productCode) > (SELECT MIN(total) * 3 FROM (SELECT COUNT(productName) AS total FROM products GROUP BY productCode) AS a)
            THEN 'Target 6'
    END AS 'Keterangan'
FROM customers AS c
JOIN orders AS o USING (customerNumber)
JOIN orderdetails AS od USING (orderNumber)
JOIN products AS p USING (productCode)
WHERE p.productName LIKE '20%'
GROUP BY c.customerNumber
HAVING Keterangan IS NOT NULL;







