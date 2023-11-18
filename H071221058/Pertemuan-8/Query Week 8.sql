#NOMOR 1
(SELECT
    c.customerName,
    pr.productName,
    pr.buyPrice * SUM(od.quantityOrdered) AS modal
FROM customers c
JOIN orders o USING (customerNumber)
JOIN orderdetails od USING (orderNumber)
JOIN products pr USING (productCode)
GROUP BY c.customerNumber
ORDER BY modal DESC
LIMIT 3)

UNION

(SELECT
    c.customerName,
    pr.productName,
    pr.buyPrice * SUM(od.quantityOrdered) AS modal
FROM customers c
JOIN orders o USING (customerNumber)
JOIN orderdetails od USING (orderNumber)
JOIN products pr USING (productCode)
GROUP BY c.customerNumber
ORDER BY modal
LIMIT 3);

#NOMOR 2
SELECT city, COUNT(*) AS total
FROM (
   SELECT offices.city FROM employees
	JOIN offices USING(officeCode)
	WHERE firstName LIKE 'L%'

    UNION ALL

	SELECT c.city
	FROM customers c
	WHERE c.customerName LIKE 'L%'
) AS EmployeeCustomerCities
GROUP BY city
ORDER BY total DESC
LIMIT 1;

#NOMOR 3
SELECT CONCAT(E.firstName, ' ', E.lastName) AS `Nama Karyawan/Pelanggan`, 'Employee' AS status
FROM Employees E
WHERE E.officeCode IN (
  SELECT officeCode
  FROM Employees
  GROUP BY officeCode
  HAVING COUNT(*) = (
    SELECT MIN(numEmployees)
    FROM (
      SELECT officeCode, COUNT(*) AS numEmployees
      FROM Employees
      GROUP BY officeCode
    ) AS OfficeEmployeeCounts
  )
)
UNION
SELECT C.customerName AS `Nama Karyawan/Pelanggan`, 'Customer' AS status
FROM Customers C
WHERE C.salesRepEmployeeNumber IN (
  SELECT employeeNumber
  FROM Employees
  WHERE officeCode IN (
    SELECT officeCode
    FROM Employees
    GROUP BY officeCode
    HAVING COUNT(*) = (
      SELECT MIN(numEmployees)
      FROM (
        SELECT officeCode, COUNT(*) AS numEmployees
        FROM Employees
        GROUP BY officeCode
      ) AS OfficeEmployeeCounts
    )
  )
)
ORDER BY `Nama Karyawan/Pelanggan`;

#NOMOR 4
SELECT tanggal, GROUP_CONCAT(riwayat SEPARATOR  ' dan ') AS riwayat
FROM (
    SELECT paymentDate as tanggal, 'membayar pesanan' as riwayat
    FROM payments
    WHERE MONTH(paymentDate) = 4 AND YEAR(paymentDate) = 2003

    UNION

    SELECT orderDate as tanggal, 'memesan barang' as riwayat
    FROM orders
    WHERE MONTH(orderDate) = 4 AND YEAR(orderDate) = 2003

     ) as dataCustomers
GROUP BY tanggal
ORDER BY tanggal;

#SOAL TAMBAHAN

SELECT
    'tertinggi' AS status,
    MAX(od.quantityOrdered) AS QuantityOrder,
    p.productName
FROM orderdetails od
JOIN products p

UNION

SELECT
    'terendah' AS status,
    MIN(od.quantityOrdered) AS QuantityOrder,
    p.productName
FROM orderdetails od
JOIN products p;
