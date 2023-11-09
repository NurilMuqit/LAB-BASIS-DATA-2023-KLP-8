USE classicmodels;
SELECT * FROM orderdetails

-- Nomor 1
(SELECT c.customerName, p.productName, (p.buyPrice * SUM(od.quantityOrdered)) AS 'modal'
FROM customers AS c
JOIN orders AS o 
USING (customerNumber)
JOIN orderdetails AS od
USING (orderNumber)
JOIN products AS p
USING (productCode)
GROUP BY customerNumber
ORDER BY (p.buyPrice * SUM(od.quantityOrdered)) DESC 
LIMIT 3)
UNION
(SELECT c.customerName, p.productName, (p.buyPrice * SUM(od.quantityOrdered))
FROM customers AS c
JOIN orders AS o 
USING (customerNumber)
JOIN orderdetails AS od
USING (orderNumber)
JOIN products AS p
USING (productCode)
GROUP BY customerNumber
ORDER BY (p.buyPrice * SUM(od.quantityOrdered))
LIMIT 3) 

-- Nomor 2
SELECT * FROM offices
SELECT * FROM employees
SELECT * FROM customers 
WHERE city = 'paris'

SELECT `kota` FROM 
(SELECT o.city AS 'kota', e.firstName AS 'Nama Karyawan / Pelanggan'
FROM offices AS o
JOIN employees AS e
USING (officeCode)
WHERE e.firstName LIKE "L%"
UNION 
SELECT city AS 'kota', c.customerName
FROM customers AS c 
WHERE c.customerName LIKE "L%") AS a 
GROUP BY `kota`
ORDER BY COUNT('Nama Karyawan / Pelanggan') DESC LIMIT 1;

-- Nomor 3
SELECT * FROM employees

SELECT CONCAT(e.firstName, " ", e.lastName) AS "Nama Karyawan/Pelanggan", "karyawan" AS "status"
FROM employees AS e
WHERE e.officeCode IN (SELECT e.officeCode 
                            FROM employees AS e
                            GROUP BY e.officeCode
                            HAVING COUNT(*) IN (SELECT MIN(employeescount)
                                          		FROM (SELECT COUNT(*) AS employeescount
                                                FROM employees
                                                GROUP BY officeCode) AS officeemployees)
)
UNION 
SELECT c.customerName, "pelanggan"
FROM customers AS c
WHERE customerNumber IN (SELECT c.customerNumber
                                FROM customers AS c
                                JOIN employees AS e
                                ON c.salesRepEmployeeNumber = e.employeeNumber
                                WHERE e.officeCode IN (SELECT e.officeCode 
                                                              FROM employees AS e
                                                              GROUP BY e.officeCode
                                                              HAVING COUNT(*) IN (SELECT MIN(employeescount)
                                                                          			FROM (SELECT COUNT(*) AS employeescount
                                                                                	FROM employees
                                                                                	GROUP BY officeCode) AS officeemployees)
))
ORDER BY `Nama Karyawan/Pelanggan`;

Nomor 4
(SELECT *, 'membayar pesanan' AS 'status' FROM (
(SELECT payments.paymentDate 'tanggal' FROM payments
WHERE MONTH(payments.paymentDate) = 4 AND YEAR(payments.paymentDate) = 2003)
EXCEPT
(
SELECT payments.paymentDate  AS "tanggal" FROM payments
WHERE MONTH(payments.paymentDate) = 4 AND YEAR(payments.paymentDate) = 2003
intersect
SELECT orders.orderDate FROM orders
WHERE MONTH(orders.orderDate) = 4 AND YEAR(orders.orderDate) = 2003
)) AS tanggal)
UNION 
(SELECT *, 'memesan barang' AS 'status' FROM (
(SELECT orders.orderDate  AS "tanggal" FROM orders
WHERE MONTH(orders.orderDate) = 4 AND YEAR(orders.orderDate) = 2003 
)
EXCEPT
(
SELECT payments.paymentDate  AS "tanggal" FROM payments
WHERE MONTH(payments.paymentDate) = 4 AND YEAR(payments.paymentDate) = 2003
intersect
SELECT orders.orderDate FROM orders
WHERE MONTH(orders.orderDate) = 4 AND YEAR(orders.orderDate) = 2003
)) AS tanggal)
UNION
(SELECT *, 'membayar pesanan dan memesan barang' AS 'status'FROM (
SELECT payments.paymentDate AS "tanggal" FROM payments
WHERE MONTH(payments.paymentDate) = 4 AND YEAR(payments.paymentDate) = 2003
intersect
SELECT orders.orderDate FROM orders
WHERE MONTH(orders.orderDate) = 4 AND YEAR(orders.orderDate) = 2003
) AS tanggal)
ORDER BY `tanggal`

-- Tambahan Nomor 1
SELECT * FROM offices 
SELECT * FROM customers 

SELECT country AS `negara`, COUNT(country) AS `jumlah`, GROUP_CONCAT(nama) AS `nama pelanggan dan karyawan` FROM 
(SELECT o.country, e.firstName AS 'nama' 
 FROM offices AS o 
 JOIN employees AS e
 USING (officeCode)
 WHERE e.firstName LIKE "G%"
 UNION
 SELECT c.country, c.customerName AS 'nama'
 FROM customers AS c
 WHERE c.customerName LIKE "G%"
 UNION 
 SELECT firstName, lastName AS 'nama'
 FROM employees 
 WHERE firstName LIKE "G%") AS a 
 GROUP BY country 
 ORDER BY COUNT(country) DESC 



