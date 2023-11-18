USE classicmodels
SELECT * FROM customers
SELECT * FROM payments

-- nomor 1
SELECT c.customerName AS 'Nama Customer', c.country AS 'Negara', p.paymentDate AS 'tanggal'
FROM customers c
JOIN payments p
USING (customerNumber)
WHERE p.paymentDate >= '2005-01-01'
ORDER BY p.paymentDate ASC;

-- nomor 2
SELECT * FROM products
SELECT * FROM productlines

SELECT DISTINCT c.customerName AS 'Nama customer', p.productName, pl.textDescription
FROM customers c
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products p
USING (productCode)
JOIN productlines pl
USING (productline)
WHERE p.productName = 'The Titanic';

-- nomor 3
DESCRIBE products;

SELECT * FROM orderdetails
ORDER BY quantityOrdered DESC

SELECT * FROM products
WHERE productCode = 'S12_4675'

ALTER TABLE products
ADD status VARCHAR(20);

UPDATE products p
SET STATUS = 'best selling'
WHERE productCode = 'S12_4675'

SELECT p.productCode, p.productName, od.quantityOrdered, p.status
FROM products p
JOIN orderdetails od
USING (productCode)
WHERE od.quantityOrdered = 97;

-- nomor 4
SELECT * FROM orderdetails
SELECT * FROM customers

SELECT * FROM orders
WHERE STATUS = 'Cancelled';

SHOW CREATE table orderdetails -- cara melihat tabel 
SHOW CREATE TABLE customers

ALTER TABLE customers
DROP FOREIGN KEY customers_ibfk_1;

ALTER TABLE orders
DROP FOREIGN KEY orders_ibfk_1;

ALTER TABLE orderdetails
DROP FOREIGN KEY orderdetails_ibfk_1;

ALTER TABLE payments
DROP FOREIGN KEY payments_ibfk_1;

DELETE c FROM customers c
JOIN orders o
USING (customerNumber)
WHERE STATUS = 'Cancelled';

-- soal tambahan
-- nomor 1
SELECT o.orderDate
FROM orders o
JOIN orderdetails od
USING (orderNumber)
JOIN products p
USING (productCode)
WHERE p.productName = '1940 Ford Pickup Truck'
ORDER BY o.orderDate DESC;

-- nomor 2
SELECT p.productName, MSRP * 0.8
FROM products p
JOIN orderdetails od
USING (productCode)
WHERE od.priceEach < (0.8 * MSRP);

SELECT * FROM products
