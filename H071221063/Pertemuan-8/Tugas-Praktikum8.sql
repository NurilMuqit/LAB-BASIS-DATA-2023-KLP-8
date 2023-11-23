SELECT * FROM customers;
SELECT * FROM employees;
SELECT * FROM offices;
SELECT * FROM orderdetails;
SELECT * FROM orders;
SELECT * FROM payments;
SELECT * FROM productlines;
SELECT * FROM products;

#1
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

#2
SELECT `kota` FROM 
						(SELECT o.city AS 'kota', e.firstName AS 'Nama Karyawan / Pelanggan'
						FROM offices AS o
						JOIN employees AS e
						USING (officeCode)
WHERE e.firstName LIKE 'L%'

UNION 

SELECT city AS 'kota', c.customerName
FROM customers AS c 
WHERE c.customerName LIKE "L%") AS a 
GROUP BY `kota`
ORDER BY COUNT('Nama Karyawan / Pelanggan') DESC 
LIMIT 1

#3
SELECT CONCAT(e.firstName, " ", e.lastName) AS "Nama Karyawan/Pelanggan", "karyawan" AS "status"
FROM employees AS e
WHERE e.officeCode IN (SELECT e.officeCode 
                            FROM employees AS e
                            GROUP BY e.officeCode
                            HAVING COUNT(*) IN (SELECT MIN(employeescount)
                                          		FROM (SELECT COUNT(*) AS employeescount
                                                FROM employees
                                                GROUP BY officeCode) AS officeemployees))
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
ORDER BY `Nama Karyawan/Pelanggan`

#4
(SELECT *, 'membayar pesanan' AS 'status' FROM (
(SELECT payments.paymentDate 'tanggal' FROM payments
WHERE MONTH(payments.paymentDate) = 4 AND YEAR(payments.paymentDate) = 2003)

EXCEPT

(SELECT payments.paymentDate  AS "tanggal" FROM payments
WHERE MONTH(payments.paymentDate) = 4 AND YEAR(payments.paymentDate) = 2003

intersect

SELECT orders.orderDate FROM orders
WHERE MONTH(orders.orderDate) = 4 AND YEAR(orders.orderDate) = 2003
)) AS tanggal)

UNION 

(SELECT *, 'memesan barang' AS 'riwayat' FROM (
(SELECT orders.orderDate  AS "tanggal" FROM orders
WHERE MONTH(orders.orderDate) = 4 AND YEAR(orders.orderDate) = 2003 )

EXCEPT

(SELECT payments.paymentDate  AS "tanggal" FROM payments
WHERE MONTH(payments.paymentDate) = 4 AND YEAR(payments.paymentDate) = 2003

intersect

SELECT orders.orderDate FROM orders
WHERE MONTH(orders.orderDate) = 4 AND YEAR(orders.orderDate) = 2003
)) AS tanggal)

UNION

(SELECT *, 'membayar pesanan dan memesan barang' AS 'riwayat'FROM (
SELECT payments.paymentDate AS "tanggal" FROM payments
WHERE MONTH(payments.paymentDate) = 4 AND YEAR(payments.paymentDate) = 2003

intersect

SELECT orders.orderDate FROM orders
WHERE MONTH(orders.orderDate) = 4 AND YEAR(orders.orderDate) = 2003) AS tanggal)
ORDER BY `tanggal`
