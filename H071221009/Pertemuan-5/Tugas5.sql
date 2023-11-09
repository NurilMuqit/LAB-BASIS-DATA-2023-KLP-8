USE classicmodels

-- nomor 1
SELECT c.customerName, p.productName, pa.paymentDate, o.`status`
FROM payments pa
JOIN customers c
USING (customerNumber)
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products p
USING (productCode)
WHERE productName LIKE '%Ferrari%' AND `status` = 'shipped';

-- nomor 2 a
SELECT c.customerName, pa.paymentDate, e.firstName, e.lastName
FROM payments pa
JOIN customers c
USING (customerNumber)
JOIN employees e
ON salesRepEmployeeNumber = employeeNumber
WHERE MONTH(paymentDate) = 11;

-- nomor 2 b
SELECT c.customerName, pa.customerNumber, pa.paymentDate, pa.amount
FROM payments pa
JOIN customers c
USING (customerNumber)
WHERE MONTH(pa.paymentDate) = 11
ORDER BY pa.amount DESC
LIMIT 1;

-- nomor 2 c
SELECT c.customerName, p.productName
FROM payments pa
JOIN customers c
USING (customerNumber)
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products p
USING (productCode)
WHERE MONTH(pa.paymentDate) = 11 AND customerName = 'Corporate Gift Ideas Co.';

-- nomor 2 d
SELECT c.customerName, GROUP_CONCAT(p.productName) AS 'Nama Produk'
FROM payments pa
JOIN customers c
USING (customerNumber)
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products p
USING (productCode)
WHERE MONTH(pa.paymentDate) = 11 AND c.customerName = 'Corporate Gift Ideas Co.';

-- nomor 3
SELECT c.customerName, o.orderDate, o.shippedDate, DATEDIFF(o.shippedDate, o.orderDate) AS 'waktu tunggu'
FROM customers c
JOIN orders o
USING (customerNumber)
WHERE c.customerName = 'GiftsForHim.com';

-- nomor 4 
USE world

SELECT *
FROM country
WHERE `Code` LIKE 'C%K' AND lifeExpectancy IS NOT NULL;

-- soal tambahan
-- nomor 1
SELECT `status` FROM orders;

UPDATE orders
SET `status` = 'shipped'
WHERE `status` = 'in process';

-- nomor 2
SELECT o.orderNumber, p.paymentDate
FROM orders o
JOIN customers
USING (customerNumber)
JOIN payments p
USING (customerNumber)
WHERE p.paymentDate < '2003-10-10';











