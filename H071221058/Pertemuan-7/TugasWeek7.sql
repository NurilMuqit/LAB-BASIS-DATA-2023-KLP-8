#NOMOR 1
USE classicmodels;
SELECT o.addressLine1,
		o.addressLine2,
		o.city,
		o.country
FROM
    offices o
JOIN
    employees e
USING
    (officeCode)
JOIN
    customers c
ON
    e.employeeNumber = c.salesRepEmployeeNumber
JOIN
    payments p
USING
    (customernumber)
GROUP BY c.customerNumber
HAVING count(p.amount) = (
	SELECT COUNT(p.amount)
	FROM customers c
	JOIN payments p
	USING(customernumber)
	GROUP BY c.customerNumber
	ORDER BY COUNT(p.amount)
	LIMIT 1
);

#NOMOR 2
-- MAX dan MIN
SELECT
       CONCAT(e.lastName, ' ' ,e.firstName) as Nama_Karyawan,
       FORMAT(SUM(p.amount), 0) AS totalPendapatan
FROM employees e
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments p ON c.customerNumber = p.customerNumber
GROUP BY e.employeeNumber
HAVING SUM(p.amount) =
       (SELECT MAX(totalPendapatan)
        FROM (SELECT SUM(p.amount) AS totalPendapatan
              FROM customers c
              JOIN payments p
              USING (customerNumber)
              GROUP BY c.salesRepEmployeeNumber) AS max_pendapatan) UNION ALL
SELECT
       CONCAT(e.lastName, ' ' ,e.firstName) as Nama_Karyawan,
       FORMAT(SUM(p.amount), 0) AS totalPendapatan
FROM employees e
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments p ON c.customerNumber = p.customerNumber
GROUP BY e.employeeNumber
HAVING SUM(p.amount) =
       (SELECT MIN(totalPendapatan)
        FROM (SELECT SUM(p.amount) AS totalPendapatan
              FROM customers c
              JOIN payments p
              USING (customerNumber)
              GROUP BY c.salesRepEmployeeNumber) AS max_pendapatan);

#NOMOR 3
USE world;
SELECT
    c.Name Negara,
    FORMAT(c.Population * cl.Percentage / 100, 0) Pengguna_Bahasa
FROM country c
JOIN countrylanguage cl
ON c.Code = cl.CountryCode
WHERE cl.language =
(SELECT cl.language
FROM countrylanguage cl
JOIN country c
ON c.Code = cl.CountryCode
WHERE c.Continent = 'Asia'
GROUP BY cl.language
ORDER BY COUNT(cl.language) DESC
LIMIT 1);

#NOMOR 4
USE classicmodels;
SELECT
    c.customerName AS Nama_Pelanggan,
    FORMAT(SUM(p.amount), 0) AS Total_Pembayaran,
    FORMAT(SUM(od.quantityOrdered), 0) AS Total_Barang,
    GROUP_CONCAT(pr.productName) AS Produk_Dibeli
FROM
    customers c
JOIN
    orders o ON c.customerNumber = o.customerNumber
JOIN
    orderdetails od ON o.orderNumber = od.orderNumber
JOIN
    products pr ON od.productCode = pr.productCode
JOIN
    payments p ON o.customerNumber = p.customerNumber
GROUP BY
    c.customerName
HAVING
    SUM(p.amount) > (SELECT AVG(subTotal)
     FROM (SELECT SUM(p.amount) AS subTotal
           FROM customers c JOIN payments p USING (customerNumber)
           GROUP BY c.customerNumber) AS Rata_Rata_Total);

#SOAL_TAMBAHAN
SELECT
    c.customerName as Nama_Pelanggan,
    CONCAT(e.firstName, ' ' ,e.lastName) as Nama_Karyawan,
    o.orderNumber as Nomor_Pesanan,
    SUM(od.priceEach * od.quantityOrdered) as Biaya_Pesanan
FROM employees e
JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
GROUP BY c.customerNumber, o.orderNumber
HAVING SUM(od.priceEach * od.quantityOrdered) = (SELECT MAX(total_amount)
                                                 FROM (SELECT SUM(od1.priceEach * od1.quantityOrdered) as total_amount
                                                       FROM orders o1 JOIN orderdetails od1 USING (orderNumber) GROUP BY o1.orderNumber) AS order_totals);


