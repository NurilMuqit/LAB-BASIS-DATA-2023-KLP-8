#1
(SELECT customers.customerName, products.productName, 
(products.buyprice * SUM(orderdetails.quantityOrdered)) AS modal
FROM customers
JOIN orders USING (customerNumber)
JOIN orderdetails USING (orderNumber)
JOIN products USING (productCode)
GROUP BY customers.customerNumber
ORDER BY `modal` DESC LIMIT 3)
UNION
(SELECT customers.customerName, products.productName, 
(products.buyprice * SUM(orderdetails.quantityOrdered)) AS modal
FROM customers
JOIN orders USING (customerNumber)
JOIN orderdetails USING (orderNumber)
JOIN products USING (productCode)
GROUP BY customers.customerNumber
ORDER BY `modal` LIMIT 3)

#2
SELECT `kota` FROM 
(SELECT o.city AS 'kota', e.firstName AS 'Nama Karyawan / Pelanggan'
FROM offices AS o
JOIN employees AS e
USING (officeCode)
WHERE e.firstName LIKE "L%"
UNION 
SELECT city AS 'kota', c.customerName
FROM customers AS c 
WHERE c.customerName LIKE "L%") AS a 
GROUP BY `kota`
ORDER BY COUNT('Nama Karyawan / Pelanggan') DESC LIMIT 1;

#3
SELECT CONCAT(firstName, ' ', lastName) AS `Nama Karyawan/Pelanggan`, 'Employee' AS status
FROM employees
WHERE officeCode IN (
    SELECT officeCode
    FROM employees
    GROUP BY officeCode
    HAVING COUNT(*) = (
        SELECT MIN(empCount)
        FROM (
            SELECT COUNT(*) AS empCount
            FROM employees
            GROUP BY officeCode
        ) AS counts
    )
)
UNION
SELECT customerName AS `Nama Karyawan/Pelanggan`, 'Customer' AS status
FROM customers
WHERE salesRepEmployeeNumber IN (
    SELECT employeeNumber
    FROM employees
    WHERE officeCode IN (
        SELECT officeCode
        FROM employees
        GROUP BY officeCode
        HAVING COUNT(*) = (
            SELECT MIN(empCount)
            FROM (
                SELECT COUNT(*) AS empCount
                FROM employees
                GROUP BY officeCode
            ) AS counts
        )
    )
)
ORDER BY `Nama Karyawan/Pelanggan`

#4
(SELECT *, 'membayar pesanan' AS 'status' FROM (
(SELECT payments.paymentDate 'tanggal' FROM payments
WHERE MONTH(payments.paymentDate) = 4 AND YEAR(payments.paymentDate) = 2003)
EXCEPT
(
SELECT payments.paymentDate  AS "tanggal" FROM payments
WHERE MONTH(payments.paymentDate) = 4 AND YEAR(payments.paymentDate) = 2003
intersect
SELECT orders.orderDate FROM orders
WHERE MONTH(orders.orderDate) = 4 AND YEAR(orders.orderDate) = 2003
)) AS tanggal)
UNION 
(SELECT *, 'memesan barang' AS 'status' FROM (
(SELECT orders.orderDate  AS "tanggal" FROM orders
WHERE MONTH(orders.orderDate) = 4 AND YEAR(orders.orderDate) = 2003 
)
EXCEPT
(
SELECT payments.paymentDate  AS "tanggal" FROM payments
WHERE MONTH(payments.paymentDate) = 4 AND YEAR(payments.paymentDate) = 2003
intersect
SELECT orders.orderDate FROM orders
WHERE MONTH(orders.orderDate) = 4 AND YEAR(orders.orderDate) = 2003
)) AS tanggal)
UNION
(SELECT *, 'membayar pesanan dan memesan barang' AS 'status'FROM (
SELECT payments.paymentDate AS "tanggal" FROM payments
WHERE MONTH(payments.paymentDate) = 4 AND YEAR(payments.paymentDate) = 2003
intersect
SELECT orders.orderDate FROM orders
WHERE MONTH(orders.orderDate) = 4 AND YEAR(orders.orderDate) = 2003
) AS tanggal)
ORDER BY `tanggal`









