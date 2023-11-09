USE classicmodels
DROP DATABASE classicmodels;

# Nomor 1
(SELECT c.customerName, p.productName, (p.buyprice * sum(od.quantityordered)) 'modal'
FROM customers c
JOIN orders o USING(customernumber)
JOIN orderdetails od USING(ordernumber)
JOIN products p USING(productcode)
GROUP BY c.customerName
ORDER BY modal DESC
LIMIT 3)
UNION 
(SELECT c.customerName, p.productName, (p.buyprice * sum(od.quantityordered)) 'modal'
FROM customers c
JOIN orders o USING(customernumber)
JOIN orderdetails od USING(ordernumber)
JOIN products p USING(productcode)
GROUP BY c.customerName
ORDER BY modal ASC
LIMIT 3);

# Nomor 2
SELECT city, COUNT(*) AS total
FROM
	(SELECT offices.city, employees.firstname FROM employees 
	JOIN offices USING(officecode)
	WHERE firstName LIKE 'L%'
	UNION
	SELECT city, customername
	FROM customers c
	WHERE c.customerName LIKE 'L%') AS EmployeeCustomerCities
GROUP BY city
ORDER BY total DESC
LIMIT 1;

# Nomor 3
SELECT CONCAT(e.firstname, ' ', e.lastname) AS 'Nama Karyawan/Pelanggan', 'Employee' AS `status`
FROM employees e
WHERE e.officeCode IN 
	(SELECT officecode
	FROM employees
	GROUP BY officecode
	HAVING COUNT(*) = (
		SELECT officecode
		FROM employees 
		GROUP BY officecode
		ORDER BY COUNT(*)
		LIMIT 1)
	)
UNION 
SELECT c.customername AS 'Nama Karyawan/Pelanggan', 'Customer' AS `status`
FROM customers c
JOIN employees e 
ON c.salesrepemployeenumber = e.employeeNumber
WHERE e.officeCode IN
		(SELECT officecode 
		FROM employees 
		GROUP BY officecode
		HAVING COUNT(*) = (
				SELECT officecode
				FROM employees 
				GROUP BY officecode
				ORDER BY COUNT(*)
				LIMIT 1)
		) 
ORDER BY `Nama Karyawan/Pelanggan`;

# Nomor 4
SELECT tanggal, GROUP_CONCAT(riwayat SEPARATOR ' dan ') AS riwayat
FROM 
	(SELECT paymentDate AS tanggal, 'membayar pesanan' AS riwayat 
	FROM payments
	WHERE MONTH(paymentDate) = 4 AND YEAR(paymentdate) = 2003
	UNION 
	SELECT orderdate AS tanggal, 'memesan barang' AS riwayat
	FROM orders
	WHERE MONTH(orderdate) = 4 AND YEAR(orderdate)= 2003) AS datacustomers
GROUP BY tanggal
ORDER BY tanggal;

# Soal tambahan 
## Nomor 1
SELECT c.customerName AS 'nama pelanggan' , CONCAT(e.firstName , " " , e.lastName) AS 'nama karyawan', o.orderNumber AS 'nomor pesanan' , SUM(od.priceEach * od.quantityOrdered) AS 'biaya pesanan'
FROM employees AS e
JOIN customers AS c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders AS o USING(customerNumber)
JOIN orderdetails AS od USING (orderNumber)
WHERE orderNumber = 
	(SELECT orderNumber
	FROM orderdetails AS od
	GROUP BY orderNumber
	ORDER BY SUM(od.priceEach * od.quantityOrdered) DESC 
	LIMIT 1);
	
## Nomor 2
(SELECT c.customerName,length(c.customerName) AS karakter, 'Customer' AS `status`
FROM customers c
ORDER BY karakter DESC
LIMIT 2)
UNION
(SELECT CONCAT(e.firstName , " " , e.lastName),length(CONCAT(e.firstName , " " , e.lastName)) AS karakter, 'Employee' AS `status`
FROM employees e
ORDER BY karakter DESC
LIMIT 2);

							                                                       