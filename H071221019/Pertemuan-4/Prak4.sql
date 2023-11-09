USE classicmodels

SELECT * FROM products

-- 1
SELECT c.customerName AS 'Nama Customer', c.country AS 'Negara', p.paymentDate AS 'Tanggal'
FROM customers c
JOIN payments p
USING (customerNUmber)
WHERE p.paymentDate >= '2005-01-01'
ORDER BY p.paymentDate ASC;

-- 2
SELECT DISTINCT c.customerName AS 'Nama customer', p.productName, pl.textDescription
FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber
JOIN orderdetails od
ON o.orderNumber = od.orderNumber
JOIN products p
ON od.productCode = p.productCode
JOIN productlines pl
ON p.productLine = pl.productLine
WHERE p.productName = 'The Titanic'

-- 3
ALTER TABLE products
ADD status VARCHAR(20);

SELECT * FROM products

SELECT * FROM orderdetails ORDER BY quantityOrdered DESC LIMIT 1;
UPDATE products
SET STATUS = 'best selling'
WHERE productCode = 'S12_4675'; 

-- UPDATE products
-- JOIN (SELECT products.productCode FROM products
-- 		JOIN orderdetails
-- 		ON products.productCode = orderdetails.productCode
-- 		ORDER BY orderdetails.quantityOrdered DESC
-- 		LIMIT 1) AS sel
-- ON products.productCode = sel.productCode
-- SET products.status = 'best selling'

SELECT products.productCode, products.productName, orderdetails.quantityOrdered, products.status
FROM products
JOIN orderdetails
ON products.productCode = orderdetails.productCode
WHERE products.STATUS = 'best selling'
ORDER BY quantityOrdered DESC
LIMIT 1;

-- 4
ALTER TABLE orders
DROP FOREIGN KEY orders_ibfk_1;

ALTER TABLE payments
DROP FOREIGN KEY payments_ibfk_1;

SELECT * FROM customers
right JOIN orders
USING (customerNumber)
WHERE STATUS = 'cancelled'

DELETE c FROM customers c
JOIN orders o
USING (customerNumber)
WHERE STATUS = 'cancelled'

-- 5
SELECT p.productName, o.orderDate 
FROM orders o
JOIN orderdetails od
USING(orderNumber)
JOIN products p
USING(productCode)
WHERE p.productName = '1940 Ford Pickup Truck'
ORDER BY orderDate DESC;

-- 6
SELECT p.productName 
FROM products p
JOIN orderdetails od
USING(productCode)
WHERE od.priceEach < (0.8 * p.MSRP)


