USE classicmodels;

-- nomor 1
SELECT * FROM customers
SELECT * FROM payments

SELECT c.customerName AS 'Nama Customer', c.country AS 'Negara', p.paymentDate AS 'tanggal'
FROM customers AS c 
JOIN payments AS p 
ON c.customerNumber = p.customerNumber
WHERE paymentDate >= '2005-01-01'
ORDER BY paymentDate;

-- nomor 2
SELECT * FROM customers
SELECT * FROM products
SELECT * FROM productlines 
SELECT * FROM orderdetails
SELECT * FROM orders

SELECT DISTINCT c.customerName AS 'Nama Customer', p.productName, pl.textDescription
FROM customers AS c
JOIN orders AS o
ON c.customerNumber = o.customerNumber
JOIN orderdetails AS od
ON o.orderNumber = od.orderNumber
JOIN products AS p
ON od.productCode = p.productCode
JOIN productlines AS pl
ON p.productLine = pl.productLine
WHERE productName = 'The Titanic'

-- nomor 3
SELECT * FROM products
SELECT * FROM orderdetails

ALTER TABLE products
ADD `status` VARCHAR (20);

SELECT * FROM orderdetails
ORDER BY quantityOrdered DESC
LIMIT 1;

UPDATE products
JOIN orderdetails AS od 
USING (productCode)
SET STATUS = 'best selling'
WHERE quantityOrdered = 97
ORDER BY quantityOrdered DESC
LIMIT 1;

SELECT p.productCode, p.productName, od.quantityOrdered, p.status
FROM products AS p
JOIN orderdetails AS od 
USING (productCode)
ORDER BY quantityOrdered DESC
LIMIT 1;

-- nomor 4
SELECT * FROM customers 
SELECT * FROM orders
WHERE STATUS = 'cancelled'

ALTER TABLE orders DROP FOREIGN KEY orders_ibfk_1;
ALTER TABLE payments DROP FOREIGN KEY payments_ibfk_1;

DELETE customers
FROM customers
JOIN orders AS o
USING (customerNumber)
WHERE STATUS = 'Cancelled'

SHOW CREATE TABLE orders

SELECT * FROM customers 
RIGHT JOIN  orders
USING (customerNumber)
WHERE STATUS = 'cancelled'

-- nomor 1 tambahan
SELECT * FROM products
WHERE productline = 'Trucks and Buses'
SELECT * FROM productlines
SELECT * FROM orders
SELECT * FROM orderdetails

SELECT o.orderDate 
FROM orders AS o
JOIN orderdetails AS od
USING (orderNumber)
JOIN products AS p
USING (productCode)
WHERE productName = '1940 Ford Pickup Truck'
ORDER BY orderDate DESC 

-- nomor 2 tambahan
SELECT * FROM products
SELECT * FROM orderdetails

SELECT p.productName 
FROM products AS p
JOIN orderdetails AS od 
USING (productCode)
WHERE priceEach < (0.8 * MSRP) 