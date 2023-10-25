USE classicmodels;

-- nomor 1
SELECT o.addressLine1, o.addressLine2, o.city, o.country
FROM offices o
JOIN employees e
USING(officecode)
JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments p
USING(customerNumber)
GROUP BY c.customerNumber
HAVING COUNT(p.amount) = (SELECT COUNT(p.amount)
									FROM customers c
									JOIN payments p
									USING(customernumber)
									GROUP BY c.customerNumber
									ORDER BY COUNT(p.amount) ASC
									LIMIT 1);

-- nomor 2
SELECT CONCAT(e.firstName, ' ', e.lastName) AS 'nama employee', 
SUM(p.amount) AS 'pendapatan'
FROM employees e
JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments p
USING(customernumber)
GROUP BY e.employeeNumber
HAVING SUM(p.amount) = (SELECT SUM(p.amount)
								FROM employees e
								JOIN customers c
								ON e.employeeNumber = c.salesRepEmployeeNumber
								JOIN payments p
								USING(customernumber)
								GROUP BY e.employeeNumber
								ORDER BY SUM(p.amount) DESC
								LIMIT 1) OR
SUM(p.amount) = (SELECT SUM(p.amount)
						FROM employees e
						JOIN customers c
						ON e.employeeNumber = c.salesRepEmployeeNumber
						JOIN payments p
						USING(customernumber)
						GROUP BY e.employeeNumber
						ORDER BY SUM(p.amount) ASC
						LIMIT 1);

-- nomor 3
USE world;

SELECT c.`Name` 'Negara', (c.Population * (cl.Percentage/100)) AS 'Pengguna Bahasa'
FROM country c
JOIN countrylanguage cl
ON c.Code = cl.CountryCode
WHERE cl.`Language` = (SELECT cl.`Language`
								FROM countrylanguage cl
								JOIN country c
								ON c.Code = cl.CountryCode
								WHERE c.Continent = 'Asia'
								GROUP BY cl.`Language`
								ORDER BY COUNT(cl.`Language`) DESC 
								LIMIT 1);

-- nomor 4
USE classicmodels;

SELECT c.customerName, SUM(p.amount) AS 'Total pembayaran', SUM(od.quantityOrdered) AS 'Banyak barang', GROUP_CONCAT(pr.productName) AS 'Produk yang dibeli'
FROM customers c
JOIN orders o 
USING(customerNumber)
JOIN orderdetails od 
USING(orderNumber)
JOIN products pr
USING(productCode)
JOIN payments p 
USING(customerNumber)
GROUP BY c.customerNumber
HAVING SUM(p.amount) > (SELECT AVG(jumlah)
FROM (SELECT SUM(p.amount) AS 'jumlah'
     FROM customers c 
	  JOIN payments p
	  USING(customerNumber)
     GROUP BY c.customerNumber) AS Rata_Rata);

-- soal tambahan
-- siapa nama pelanggan, dan nama karyawan serta berapa nomor
-- nomor pesanan dan biaya pesanan untuk pesanan yang paling
-- mahal?
SELECT c.customerName AS 'Nama pelanggan',
		CONCAT(e.firstName, ' ', e.lastName) AS 'Nama karyawan', 
		o.orderNumber AS 'Nomor pesanan', 
		MAX(od.biaya_pemesanan) AS 'Biaya Pesanan'
FROM employees e
JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders o 
USING(customerNumber)
JOIN (SELECT orderNumber, 
		SUM(priceEach * quantityOrdered) AS biaya_pemesanan
    	FROM orderdetails
    	GROUP BY orderNumber
		) od 
ON o.orderNumber = od.orderNumber
GROUP BY o.orderNumber
ORDER BY biaya_pemesanan DESC
LIMIT 1;