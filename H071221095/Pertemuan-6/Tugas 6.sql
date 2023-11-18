USE classicmodels;

# nomor 1
SELECT CONCAT(e.firstname, ' ', e.lastname) 'nama employee' , group_concat(o.ordernumber) 'Nomor orderan' , COUNT(o.ordernumber) 'Jumlah orderan'
FROM employees e
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders o USING(customerNumber)
GROUP BY e.employeeNumber
HAVING COUNT(o.orderNumber) > 10;

# nomor 2
SELECT p.productcode, p.productname, p.quantityinstock, MIN(o.orderDate)
FROM products p 
JOIN  orderdetails od USING(productcode)
JOIN orders o USING(ordernumber)
WHERE p.quantityInStock > 5000
GROUP BY p.productcode
ORDER BY o.orderDate 

# nomor 3
SELECT offices.addressLine1 'Alamat', 
		CONCAT(LEFT(offices.phone, 6), '* **') 'No Telp', 
		COUNT(DISTINCT employees.employeeNumber) 'Jumlah Karyawan', 
		COUNT(DISTINCT customers.customerNumber) 'Jumlah Pelanggan',
		FORMAT(avg(payments.amount), 2) 'Rata-Rata Penghasilan'
FROM offices 
JOIN employees USING(officecode)
LEFT JOIN customers ON customers.salesRepEmployeeNumber = employees.employeeNumber
LEFT JOIN payments USING(customernumber)
GROUP BY offices.officecode
ORDER BY offices.phone

# nomor 4
SELECT * FROM orderdetails;
SELECT customers.customerName, 
		YEAR(orders.orderDate) 'tahun order' , 
		MONTHNAME(orders.orderDate) 'bulan order',
		COUNT(od.orderNumber) 'jumlah pesanan',
		SUM(od.quantityOrdered * od.priceEach) 'uang total penjualan'
FROM customers
JOIN orders USING(customernumber)
JOIN orderdetails od USING(ordernumber)
WHERE year(orders.orderDate) = 2003
GROUP BY customers.customerName, MONTHNAME(orders.orderDate);

# soal tambahan 
SELECT CONCAT(e.firstname, ' ', e.lastname) AS 'nama lengkap',
    SUM(od.quantityOrdered * od.priceEach) * 0.05 AS 'Komisi'
FROM employees AS e
JOIN customers ON customers.salesRepEmployeeNumber = e.employeeNumber
JOIN orders USING (customerNumber)
JOIN orderdetails AS od USING (orderNumber)
GROUP BY CONCAT(e.firstname, ' ', e.lastname)
ORDER BY e.lastname, e.firstname;








