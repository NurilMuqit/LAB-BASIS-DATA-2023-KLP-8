USE classicmodels;

-- Tampilkan customer yang melakukan pembayaran paling banyak dan
-- employee yang melayani paling banyak pelanggan

(SELECT c.customerName AS 'customer/employee name', CONCAT("melakukan pembayaran = ", COUNT(*)) AS jumlah
FROM customers c
JOIN payments p USING(customerNumber)
GROUP BY customerNumber
ORDER BY COUNT(*) DESC
LIMIT 1)

UNION

(SELECT concat(e.firstName, ' ', e.lastName), CONCAT("melayani pelanggan = ", COUNT(*))
FROM employees AS e
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
GROUP BY c.salesRepEmployeeNumber
ORDER BY COUNT(*) DESC 
LIMIT 1);