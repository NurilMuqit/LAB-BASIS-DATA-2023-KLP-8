USE classicmodels

# nomor1
SELECT o.addressLine1, o.addressLine2, o.city, o.country
FROM offices o
JOIN employees e USING(officecode)
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments p USING(customernumber)
GROUP BY c.customerNumber
having COUNT(*) = 
	(SELECT COUNT(*) FROM payments 
	GROUP BY customerNumber
	ORDER BY COUNT(*)
	LIMIT 1);

# nomor2
SELECT CONCAT(e.firstName, ' ', e.lastName) 'nama employee', sum(p.amount) 'pendapatan'
FROM employees e
JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments p
USING (customernumber)
WHERE e.employeeNumber IN  
	((SELECT employeenumber 
	FROM employees e
	JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
	JOIN payments p USING (customernumber)
	GROUP BY e.employeeNumber
	ORDER BY SUM(p.amount)
	LIMIT 1),
		(SELECT employeenumber 
		FROM employees e
		JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
		JOIN payments p USING (customernumber)
		GROUP BY e.employeeNumber
		ORDER BY SUM(p.amount) DESC 
		LIMIT 1))
GROUP BY CONCAT(e.firstName, ' ', e.lastName);

# nomor3
USE world
-- memperlihatkan bahasa yang paling banyak digunakan di benua asia
SELECT cl.Language
FROM country c
JOIN countrylanguage cl 
ON c.Code = cl.CountryCode
WHERE c.Continent = 'Asia'
GROUP BY cl.Language
ORDER BY COUNT(cl.language) DESC
LIMIT 1;

SELECT
    c.Name 'Negara',
    c.Population*cl.percentage/100 'Pengguna Bahasa'
FROM country c
JOIN countrylanguage cl
ON c.Code = cl.CountryCode
WHERE cl.language = 
	(SELECT countrylanguage.language
	FROM countrylanguage
	JOIN country ON country.Code = countrylanguage.CountryCode
	WHERE country.Continent = 'Asia'
	GROUP BY countrylanguage.language
	ORDER BY COUNT(countrylanguage.language) DESC
	LIMIT 1)
ORDER BY  c.Name ASC;

# nomor4
SELECT c.customerName,
    SUM(p.amount) 'Total pembayaran',  
	 COUNT(od.productCode) 'banyak barang',
    GROUP_CONCAT(pr.productName SEPARATOR ', ') 'produk yang dibeli'
FROM customers c
JOIN payments p USING(customernumber)
JOIN orders o USING(customernumber)
JOIN orderdetails od USING(ordernumber)
JOIN products pr USING(productcode)
GROUP BY c.customername
HAVING SUM(p.amount) > 
	(SELECT AVG(amount) 
	FROM payments)
ORDER BY SUM(p.amount) DESC;
