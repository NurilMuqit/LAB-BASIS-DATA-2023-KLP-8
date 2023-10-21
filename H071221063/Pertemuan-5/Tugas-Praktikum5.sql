SELECT * FROM customers;
SELECT * FROM employees;
SELECT * FROM offices;
SELECT * FROM orderdetails;
SELECT * FROM orders;
SELECT * FROM payments;
SELECT * FROM productlines;
SELECT * FROM products;

-- No 1
SELECT c.customerName , pr.productName, py.paymentDate, o.`status`
FROM customers AS c
JOIN payments AS py
USING (customerNumber)
JOIN orders AS o
USING (customerNumber)
JOIN orderdetails
USING (orderNumber)
JOIN products AS pr
USING (productCode)
WHERE pr.productName LIKE '%Ferrari%' AND c.customerName LIKE '%Stores%' AND `status` = 'Shipped'
ORDER BY c.customerName DESC
LIMIT 3

-- No 2
-- bagian (a)
SELECT c.customerName AS 'Nama Customer' , py.paymentDate AS 'Tanggal Pembayaran', e.firstName AS 'Nama Depan Karyawan', e.lastName AS 'Nama Belakang Karyawan' 
FROM payments AS py
JOIN customers AS c
USING (customerNumber)
JOIN employees AS e
ON c.salesRepEmployeeNumber = e.employeeNumber 
WHERE MONTH(py.paymentDate) = 11
-- bagian(b)
ORDER BY amount DESC
LIMIT 1
-- bagian(c)
SELECT c.customerName AS 'Nama Customer', pr.productName AS 'Nama Produk'
FROM products AS pr
JOIN orderdetails AS od
USING (productCode)
JOIN orders AS o
USING (orderNumber)
JOIN customers AS c
USING (customerNumber)
WHERE c.customerName LIKE 'Corporate%'
-- bagian(d)
SELECT c.customerName AS 'Nama Pelanggan', GROUP_CONCAT(p.productName SEPARATOR ' | ') AS 'Nama Produk'
FROM customers c
JOIN payments py
USING(customerNumber)
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products p
USING (productCode)
WHERE c.customerName LIKE 'Corporate%'

-- No 3
SELECT customerName, orderDate, shippedDate, DATEDIFF(shippedDate, orderDate) AS 'Lama Pengiriman'
FROM customers AS c
JOIN orders AS o
USING (customerNumber)
WHERE c.customerName LIKE 'GiftsForHim%'
ORDER BY DATEDIFF(shippedDate, orderDate) DESC

SELECT * FROM city;
SELECT * FROM country;
SELECT * FROM countrylanguage;

-- No 4
SELECT * FROM country
WHERE Code LIKE 'C%K' AND lifeExpectancy IS NOT NULL

-- tambahan
SELECT orderNumber, paymentDate
FROM orders
JOIN payments
USING (customerNumber)
WHERE paymentDate < '2003-10-21'






