USE classicmodels;

-- nomor 1
(SELECT c.customerName, p.productName, (p.buyPrice * SUM(od.quantityOrdered)) AS modal
FROM customers c
JOIN orders o 
USING(customerNumber)
JOIN orderdetails od 
USING(orderNumber)
JOIN products p 
USING(productCode)
GROUP BY c.customerNumber
ORDER BY modal DESC
LIMIT 3)
UNION
(SELECT c.customerName, p.productName, (p.buyPrice * SUM(od.quantityOrdered)) AS modal
FROM customers c
JOIN orders o 
USING(customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products p 
USING (productCode)
GROUP BY c.customerNumber
ORDER BY modal
LIMIT 3);

-- nomor 2
SELECT city, COUNT(*) AS Total
FROM (SELECT o.city, e.firstName
		FROM employees e
		JOIN offices o
		USING(officeCode)
		WHERE e.firstName LIKE 'L%'
		UNION
		SELECT city, customerName
		FROM customers
		WHERE customerName LIKE 'L%'
		) AS city_name
		GROUP BY city
		ORDER BY Total DESC
		LIMIT 1;

-- nomor 3
SELECT CONCAT(e.firstName, ' ', e.lastName) AS `Nama Karyawan/Pelanggan`, 'employee' AS status
FROM employees e
WHERE e.officeCode IN (
	SELECT officeCode
	FROM employees
	GROUP BY officeCode
	HAVING COUNT(*) = (
		SELECT MIN(numEmployees)
		FROM (SELECT officeCode, COUNT(*) AS numEmployees
		FROM employees
		GROUP BY officeCode
		) AS OfficeEmployeeCounts
	)
)
UNION
SELECT c.customerName AS `Nama Karyawan/Pelanggan`, 'customer' AS status
FROM customers c
WHERE c.salesRepEmployeeNumber IN (
	SELECT employeeNumber
  	FROM employees
  	WHERE officeCode IN (
    	SELECT officeCode
    	FROM employees
    	GROUP BY officeCode
    	HAVING COUNT(*) = (
      	SELECT MIN(numEmployees)
      	FROM (
        		SELECT officeCode, COUNT(*) AS numEmployees
        		FROM employees
        		GROUP BY officeCode
      	) AS OfficeEmployeeCounts
    	)
  	)
)
ORDER BY `Nama Karyawan/Pelanggan`;

-- nomor 4
SELECT tanggal, GROUP_CONCAT(riwayat SEPARATOR  ' dan ') AS riwayat
FROM (
   SELECT orderDate as tanggal, 'memesan barang' as riwayat
   FROM orders
   WHERE MONTH(orderDate) = 4 AND YEAR(orderDate) = 2003
   UNION
   SELECT paymentDate as tanggal, 'membayar pesanan' as riwayat
   FROM payments
   WHERE MONTH(paymentDate) = 4 AND YEAR(paymentDate) = 2003
) AS d_cs
GROUP BY tanggal
ORDER BY tanggal;

-- soal tambahan
-- Tampilkan customers atau karyawan dengan karakter
-- nama 2 terpanjang masing-masing
(SELECT customerName AS 'customer/employee name', 
			LENGTH(customerName) AS 'panjang karakter',
			'customer' AS `status`
FROM customers
ORDER BY LENGTH(customerName) DESC
LIMIT 2)
UNION
(SELECT CONCAT(firstName, ' ', lastName) AS 'customer/employee name',
			LENGTH(CONCAT(firstName, ' ', lastName)) AS 'panjang karakter',
			'employee' AS `status`
FROM employees 
ORDER BY 'panjang karakter' DESC
LIMIT 2);

			