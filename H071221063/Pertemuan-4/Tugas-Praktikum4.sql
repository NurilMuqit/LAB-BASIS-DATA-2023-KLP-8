SELECT * FROM customers;
SELECT * FROM employees;
SELECT * FROM offices;
SELECT * FROM orderdetails;
SELECT * FROM orders;
SELECT * FROM payments;
SELECT * FROM productlines;
SELECT * FROM products;
-- No 1
SELECT c.customerName AS 'Nama Customer', c.country AS 'Negara', p.paymentDate AS 'Tanggal'
FROM customers AS c
INNER JOIN payments AS p
ON c.customerNumber = p.customerNumber
WHERE p.paymentDate BETWEEN '2004-12-31' AND '2006-01-01'
ORDER BY p.paymentDate

-- No 2
SELECT DISTINCT c.customerName AS 'Nama Customer', pr.productName, pl.textDescription 
FROM customers AS c
JOIN orders AS o
USING (customerNumber)
JOIN orderdetails AS od
USING(orderNumber)
JOIN products AS pr
USING(productCode)
JOIN productlines AS pl
USING(productLine)
WHERE pr.productName = 'The Titanic'

-- No 3
ALTER TABLE products
ADD `status` VARCHAR(20)

UPDATE products
JOIN orderdetails
USING(productCode)
SET `status` = 'Best Selling'
WHERE quantityOrdered = 97

SELECT pr.productCode, pr.productName, od.quantityOrdered , pr.status
FROM products AS pr
JOIN orderdetails AS od
USING(productCode)
ORDER BY quantityOrdered DESC
LIMIT 1

-- No 4
DESC 
SHOW CREATE TABLE orders;

ALTER TABLE orders
DROP FOREIGN KEY orders_ibfk_1;

ALTER TABLE payments
DROP FOREIGN KEY payments_ibfk_1;

SELECT * FROM customers
right JOIN orders
USING (customerNumber)
WHERE STATUS = 'cancelled'

DELETE c FROM customers AS C
JOIN orders AS o
USING (customerNumber)
WHERE STATUS = 'cancelled'

DROP DATABASE classicmodels

-- tambahan
SELECT productName
FROM products
JOIN orderdetails
USING (productCode)
WHERE priceEach < (MSRP * 0.8)
