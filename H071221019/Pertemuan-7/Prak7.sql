USE classicmodels;

# No 1
SELECT o.addressline1, o.addressLine2, o.city, o.country 
FROM employees e
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN offices o USING(officeCode)
WHERE c.customerNumber IN (
		SELECT customerNumber FROM payments
		GROUP BY customernumber
		HAVING COUNT(*) = 
			(SELECT COUNT(*) FROM payments
			GROUP BY customernumber
			ORDER BY COUNT(*)
			LIMIT 1));

# No 2
SELECT CONCAT(e.firstName, ' ', e.lastName) 'nama employee', 
		SUM(p.amount) 'pendapatan'
FROM employees e
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments p USING (customernumber)
GROUP BY e.employeeNumber
HAVING SUM(p.amount) = 
		(SELECT SUM(p.amount) FROM payments p
		JOIN customers c USING (customernumber)
		JOIN employees e ON e.employeeNumber = c.salesRepEmployeeNumber
		GROUP BY e.employeeNumber
		ORDER BY SUM(p.amount) DESC
		LIMIT 1)
OR SUM(p.amount) = 
		(SELECT SUM(p.amount) FROM payments p
		JOIN customers c USING (customernumber)
		JOIN employees e ON e.employeeNumber = c.salesRepEmployeeNumber
		GROUP BY e.employeeNumber
		ORDER BY SUM(p.amount) ASC
		LIMIT 1);

# No 3
USE  world;

SELECT c.`Name` 'Negara',
   	(c.Population * (cl.Percentage/100)) 'Pengguna Bahasa'
FROM country c
JOIN countrylanguage cl ON c.`Code` = cl.CountryCode
WHERE cl.`language` = 
		(SELECT countrylanguage.`language`
		FROM countrylanguage
		JOIN country ON country.`Code` = countrylanguage.CountryCode
		WHERE country.Continent = 'Asia'
		GROUP BY countrylanguage.`language`
		ORDER BY COUNT(countrylanguage.`language`) DESC
		LIMIT 1)
ORDER BY (c.Population * (cl.Percentage/100));

# No 4
USE classicmodels;

SELECT c.customerName, 
		SUM(p.amount) AS 'Total pembayaran', 
		SUM(od.quantityOrdered) 'banyak barang', 
		GROUP_CONCAT(pr.productName SEPARATOR '; ')'produk yang dibeli'
FROM payments p
JOIN customers c USING (customerNumber)
JOIN orders o USING (customerNumber)
JOIN orderdetails od USING (orderNumber)
JOIN products pr USING (productcode)
GROUP BY customerNumber
HAVING SUM(p.amount) > 
		(SELECT AVG(jumlah)
		FROM (
			SELECT SUM(amount) 'jumlah'
			FROM payments
			GROUP BY customernumber) AS a)
ORDER BY c.customerName;

-- 5
SELECT c.customerName 'Nama Pelanggan', 
		CONCAT(e.firstName, ' ', e.lastname) 'Nama Karyawan', 
		o.orderNumber 'Nomor Pesanan',
		SUM(od.priceEach * od.quantityOrdered) 'Biaya Pesanan'
FROM customers c
JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN orders o USING(customerNumber)
JOIN orderdetails od USING(OrderNumber)
GROUP BY o.orderNumber
HAVING SUM(od.priceEach * od.quantityOrdered) = 
		(SELECT SUM(priceEach * quantityOrdered) FROM orderdetails
		GROUP BY orderNumber
		ORDER BY SUM(priceEach * quantityOrdered) DESC
		LIMIT 1)
ORDER BY orderNumber DESC;
 


