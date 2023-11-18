## Nomor 1

USE classicmodels;

SELECT
    c.customerName AS `Nama Customer`,
    c.country AS Negara,
    p.paymentDate AS tanggal
FROM customers c
JOIN payments p ON c.customerNumber = p.customerNumber
WHERE p.paymentDate > '2004-12-31'
ORDER BY p.paymentDate DESC;

## Nomor 2
SELECT * FROM productLines
SELECT DISTINCT
    c.customerName AS Nama_Customer,
    p.productName,
    pl.textDescription
FROM customers c
JOIN orders o USING (customerNumber)
JOIN orderdetails od USING (orderNumber)
JOIN products p USING (productCode)
JOIN productlines pl USING (productLine)
WHERE p.productName = 'The Titanic';

## Nomor 3
SELECT * FROM products

ALTER TABLE products 
ADD COLUMN `status` VARCHAR(20);

SELECT * FROM orderdetails
ORDER BY quantityOrdered DESC
LIMIT 1;


UPDATE products 
SET STATUS = 'best selling'
WHERE productCode = 'S12_4675';

SELECT p.productCode, p.productName, od.quantityOrdered, p.`status`
FROM products p 
JOIN orderdetails od 
ON od.productCode = p.productCode
ORDER BY od.quantityOrdered DESC 
LIMIT 1


## Nomor 4

SHOW CREATE TABLE payments
ALTER TABLE payments DROP FOREIGN KEY payments_ibfk_1;

ALTER TABLE orders DROP FOREIGN KEY orders_ibfk_1;

DELETE c
FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber
WHERE o.`status` = 'cancelled';

SELECT * FROM customers
RIGHT JOIN orders USING (customerNumber)
WHERE status = 'cancelled';

### Soal Tambahan
## Nomor 1
SELECT * FROM products

SELECT orderDate
FROM products
JOIN orderdetails
USING(productCode)
JOIN orders
USING (orderNumber)
WHERE productName= '1940 ford pickup truck'
ORDER BY orderDate DESC

## Nomor 2
SELECT productName
FROM products
JOIN orderdetails
USING (productCode)
WHERE priceEach < (0.8 * MSRP)
