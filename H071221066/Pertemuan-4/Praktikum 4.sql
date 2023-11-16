USE classicmodels;

-- no 1
SELECT c.customerName AS 'Nama Customer', c.country AS 'Negara', p.paymentDate AS 'Tanggal'
FROM customers c
INNER JOIN payments p
ON c.customerNumber = p.customerNumber
WHERE p.paymentDate > '2004-12-31'
ORDER BY p.paymentDate;

-- no 2
SELECT DISTINCT c.customerName AS 'Nama Customer', p.productName, pl.textDescription
FROM customers c 
INNER JOIN orders o
ON c.customerNumber = o.customerNumber
INNER JOIN orderdetails od
ON o.orderNumber = od.orderNumber
INNER JOIN products p
ON od.productCode = p.productCode
INNER JOIN productlines pl
ON p.productLine = pl.productLine
WHERE p.productName = 'The Titanic';

-- no 3
SELECT * FROM products;
SELECT * FROM orderdetails
ORDER BY quantityOrdered DESC;

ALTER TABLE products
ADD STATUS VARCHAR(20);

UPDATE products p
JOIN orderdetails o
ON p.productCode = o.productCode
SET status = 'Best Selling'
WHERE o.quantityOrdered = 97;

SELECT p.productCode, p.productName, od.quantityOrdered, p.status
FROM products p
INNER JOIN orderdetails od
ON p.productCode = od.productCode
ORDER BY od.quantityOrdered DESC 
LIMIT 1;

-- no 4

SHOW CREATE TABLE customers
ALTER TABLE orders
	DROP FOREIGN KEY orders_ibfk_1;
ALTER TABLE orders
	ADD CONSTRAINT order_ibfk_1 FOREIGN KEY (customerNumber) REFERENCES customers (customerNumber)ON UPDATE CASCADE ON DELETE CASCADE;
	
ALTER TABLE orderdetails 
	DROP FOREIGN KEY orderdetails_ibfk_1,
	DROP FOREIGN KEY orderdetails_ibfk_2;
ALTER TABLE orderdetails
	ADD CONSTRAINT orderdetails_ibfk_1 FOREIGN KEY (orderNumber) REFERENCES orders (orderNumber) ON UPDATE CASCADE ON DELETE CASCADE,
	ADD CONSTRAINT orderdetails_ibfk_2 FOREIGN KEY (productCode) REFERENCES products (productCode) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE payments
	DROP FOREIGN KEY  payments_ibfk_1;
ALTER TABLE payments
	ADD CONSTRAINT payments_ibfk_1 FOREIGN KEY (customerNumber) REFERENCES customers (customerNumber) ON UPDATE CASCADE ON DELETE CASCADE;

SELECT * FROM orders
WHERE STATUS = 'Cancelled';

SELECT * FROM customers 
JOIN orders 
USING (customerNumber)
WHERE STATUS = 'Cancelled'

WHERE STATUS = 'Cancelled';

DELETE customers FROM classicmodels.customers 
JOIN orders
USING (customerNumber)
WHERE STATUS = 'Cancelled';

DROP DATABASE classicmodels;

-- soal tambahan 
-- no 1
SELECT o.orderDate
FROM orders o
JOIN orderdetails od
USING (orderNumber)
JOIN products p
USING (productCode)
WHERE productName = '1940 Ford Pickup Truck'
ORDER BY orderDate DESC

-- no 2
SELECT p.productName AS 'Nama Produk', MSRP * 0.8
FROM products p
JOIN orderdetails od
USING (productCode)
WHERE od.priceEach = (0.8 * MSRP);




