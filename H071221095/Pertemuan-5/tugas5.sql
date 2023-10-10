USE classicmodels;

# nomor 1
SELECT customers.customerName, products.productName, payments.paymentDate, orders.`status`
FROM customers
JOIN payments USING(customerNumber)
JOIN orders USING(customerNumber)
JOIN orderdetails USING(orderNumber)
JOIN products USING(productCode)
WHERE products.productName LIKE '%ferrari%' AND orders.`status` = 'Shipped';

# nomor 2
## a
SELECT customers.customerName, payments.paymentDate, employees.lastName, employees.firstName
FROM customers
JOIN payments USING(customerNumber)
JOIN employees on employees.employeeNumber = customers.salesRepEmployeeNumber
WHERE MONTH(payments.paymentDate) = 11;

## b
SELECT customers.customerName, payments.paymentDate, employees.lastName, employees.firstName
FROM customers
JOIN payments USING(customerNumber)
JOIN employees on employees.employeeNumber = customers.salesRepEmployeeNumber
WHERE MONTH(payments.paymentDate) = 11 
ORDER BY payments.amount DESC 
LIMIT 1;

## c
SELECT customers.customerName, products.productName
FROM customers
JOIN payments USING(customerNumber)
JOIN orders USING(customerNumber)
JOIN orderdetails USING(orderNumber)
JOIN products USING(productCode)
WHERE MONTH(payments.paymentDate) = 11 AND customers.customerName = 'Corporate Gift Ideas Co.'


# nomor 3
SELECT customers.customerName, orders.orderDate, orders.shippedDate, 
DATEDIFF(orders.shippedDate, orders.orderDate) AS 'lama menunggu'
FROM customers
JOIN orders USING(customerNumber)
WHERE customers.customerName = 'GiftsForHim.com';

# nomor 4
USE world;
SELECT *
FROM country
WHERE country.Code LIKE 'c%k' AND country.LifeExpectancy IS NOT NULL;

# latihan soal 1
SELECT `STATUS` FROM orders
UPDATE orders
SET STATUS = 'Shipped'
WHERE STATUS = 'on process'

# latihan soal 2
SELECT o.orderNumber AS 'Nomor Order', p.paymentDate AS 'Tanggal Pembayaran'
FROM orders AS o
JOIN payments AS p
USING (customerNumber)
WHERE p.paymentDate < "2003-10-10"