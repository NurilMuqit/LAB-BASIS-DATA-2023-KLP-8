USE classicmodels

-- 1
(SELECT c.customerName, p.productName ,
		p.buyPrice * SUM(od.quantityOrdered) AS modal
FROM customers c
JOIN orders o USING(customerNumber)
JOIN orderdetails od USING(orderNumber)
JOIN products p USING(productCode)
GROUP BY c.customerName
ORDER BY modal DESC 
LIMIT 3)
UNION
(SELECT customers.customerName, products.productName ,
		products.buyPrice * SUM(orderdetails.quantityOrdered)
FROM customers
JOIN orders USING(customerNumber)
JOIN orderdetails USING(orderNumber)
JOIN products USING(productCode)
GROUP BY customers.customerName
ORDER BY products.buyPrice * SUM(orderdetails.quantityOrdered)
LIMIT 3)

-- 2
(SELECT ofc.city FROM offices ofc
JOIN employees e USING(officeCode)
WHERE CONCAT(e.firstName,' ',e.firstName) = (
		SELECT CONCAT(firstName,' ',firstName) 
		FROM employees
		WHERE employees.firstName LIKE 'L%'
		GROUP BY employees.employeeNumber
		ORDER BY COUNT(*) DESC
		LIMIT 1))
UNION
(SELECT city FROM customers
WHERE customers.customerName = (
		SELECT customerName FROM customers
		WHERE customerName LIKE 'L%'
		GROUP BY customerName
		ORDER BY COUNT(*) DESC
		LIMIT 1))

-- 3
(SELECT CONCAT(e.firstName, ' ', e.lastName) AS 'Nama Karyawan/Pelanggan',
'karyawan' AS 'status'
FROM employees e
WHERE e.officeCode IN (
	SELECT officeCode FROM employees
	GROUP BY officeCode
	HAVING COUNT(employees.employeeNumber) = (
		SELECT COUNT(employees.employeeNumber) FROM offices
		JOIN employees USING (officeCode)
		GROUP BY officeCode
		ORDER BY COUNT(employees.employeeNumber)
		LIMIT 1)
))
UNION
(SELECT c.customerName, 'pelanggan' FROM customers c
JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE e.officeCode IN (
	SELECT officeCode FROM employees
	GROUP BY officeCode
	HAVING COUNT(employees.employeeNumber) = (
		SELECT COUNT(employees.employeeNumber) FROM offices
		JOIN employees USING (officeCode)
		GROUP BY officeCode
		ORDER BY COUNT(employees.employeeNumber)
		LIMIT 1)
))
ORDER BY `Nama Karyawan/Pelanggan`;

-- 4
## Cara 1
(SELECT o.orderDate AS 'tanggal',
		'membayar pesanan dan memesan barang' AS 'riwayat'
FROM orders o
JOIN customers c USING (customerNumber)
JOIN payments p ON o.orderDate = p.paymentDate
WHERE MONTH(o.orderDate) = 04 AND YEAR(o.orderDate) = 2003
)
UNION
(SELECT orderDate, 'memesan barang' FROM orders
WHERE MONTH(orderDate) = 04 AND YEAR(orderDate) = 2003
AND orderDate NOT IN (  
	SELECT o.orderDate AS 'Tanggal'
	FROM orders o
	JOIN customers c USING (customerNumber)
	JOIN payments p ON o.orderDate = p.paymentDate
	HAVING MONTH(o.orderDate) = 04 AND YEAR(o.orderDate) = 2003)
)
UNION
(SELECT paymentDate, 'membayar pesanan' FROM payments
WHERE MONTH(paymentDate) = 04 AND YEAR(paymentDate) = 2003
AND paymentDate NOT IN (  
	SELECT p.paymentDate AS 'Tanggal'
	FROM orders o
	JOIN customers c USING (customerNumber)
	JOIN payments p ON o.orderDate = p.paymentDate
	HAVING MONTH(p.paymentDate) = 04 AND YEAR(p.paymentDate) = 2003)
)
ORDER BY tanggal;

## Cara 2
SELECT Tanggal, GROUP_CONCAT(Riwayat ORDER BY Tanggal SEPARATOR ' dan ') AS Riwayat
FROM (
    SELECT o.orderDate AS Tanggal, 'memesan barang' AS Riwayat
    FROM orders o
    WHERE MONTH(o.orderDate) = 4 AND YEAR(o.orderDate) = 2003
    
    UNION

    SELECT p.paymentDate AS Tanggal, 'membayar pesanan' AS Riwayat
    FROM payments p
    WHERE MONTH(p.paymentDate) = 4 AND YEAR(p.paymentDate) = 2003
) AS CombinedData
GROUP BY Tanggal
ORDER BY Tanggal;

-- 5
(SELECT c.customerName AS 'customer/employee name', 
		CONCAT('melakukan pembayaran = ', COUNT(py.paymentDate)) AS 'jumlah'
FROM customers c
JOIN payments py USING(customerNumber)
GROUP BY customerName
ORDER BY COUNT(py.paymentDate) DESC
LIMIT 1)
UNION
(SELECT CONCAT(firstName,' ',lastname),
		CONCAT('melayani pelanggan = ', COUNT(*))
FROM employees e
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
GROUP BY e.employeeNumber
ORDER BY COUNT(*) DESC
LIMIT 1)
