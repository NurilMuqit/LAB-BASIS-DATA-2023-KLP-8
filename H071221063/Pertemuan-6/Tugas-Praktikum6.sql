SELECT * FROM customers;
SELECT * FROM employees;
SELECT * FROM offices;
SELECT * FROM orderdetails;
SELECT * FROM orders;
SELECT * FROM payments;
SELECT * FROM productlines;
SELECT * FROM products;

-- No 1
SELECT CONCAT(e.firstName,' ', e.lastName) AS 'Nama Employee', GROUP_CONCAT(o.orderNumber) AS 'Nomor Orderan', COUNT(o.customerNumber) AS 'Jumlah pesanan'
FROM employees AS e
JOIN customers AS c
ON e.employeeNumber =  c.salesRepEmployeeNumber
JOIN orders AS o
USING (customerNumber)
-- JOIN orderdetails AS od
-- USING (orderNumber)
GROUP BY e.employeeNumber
HAVING COUNT(o.customerNumber) > 10

-- No 2
SELECT p.productCode, p.productName, p.quantityInStock, o.orderDate
FROM products AS p
JOIN orderdetails AS od
USING (productCode)
JOIN orders AS o
USING (orderNumber)
WHERE p.quantityInStock > 5000
GROUP BY p.productCode
ORDER BY o.orderDate

-- No 3
SELECT oc.addressLine1 AS 'Alamat', CONCAT(LEFT(oc.phone, 6),'* **') AS 'Nomor Telp', 
COUNT(DISTINCT e.employeeNumber) AS 'Jumlah Karyawan', COUNT(DISTINCT c.customerNumber) AS 'Jumlah Pelanggan', 
FORMAT(AVG(p.amount),2) AS 'Rata-rata Penghasilan'
FROM offices AS oc
LEFT JOIN employees AS e
USING (officeCode)
LEFT JOIN customers AS c
ON e.employeeNumber =  c.salesRepEmployeeNumber
LEFT JOIN payments AS p
USING (customerNumber)
GROUP BY oc.officeCode
ORDER BY oc.phone

-- No 4
SELECT c.customerName, YEAR(o.orderDate) AS 'Tahun Order', MONTHNAME(o.orderDate) AS 'Bulan Order', 
COUNT( o.orderNumber) AS 'Jumlah pesanan', 
SUM(od.quantityOrdered * od.priceEach) AS 'Uang Total Penjualan'
FROM customers AS c
JOIN orders AS o
USING (CustomerNumber)
JOIN orderdetails AS od
USING (orderNumber)
WHERE YEAR(o.orderDate) = 2003
GROUP BY c.customerName, MONTHNAME(o.orderDate)
ORDER BY od.quantityOrdered DESC

-- tambahan
SELECT ROUND(AVG(DATEDIFF(shippedDate, orderDate))) AS rata_rata
FROM orders AS o
JOIN customers AS c
GROUP BY o.customerNumber
ORDER BY rata_rata DESC
