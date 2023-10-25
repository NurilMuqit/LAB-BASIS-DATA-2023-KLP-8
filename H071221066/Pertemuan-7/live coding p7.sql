USE classicmodels;

SELECT c.customerName, CONCAT(e.firstName, ' ', e.lastName) AS nama_karyawan, o.orderNumber, od.biaya_pemesanan 
FROM customers c
JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN (
    SELECT orderNumber, SUM(priceEach * quantityOrdered) AS biaya_pemesanan
    FROM orderdetails
    GROUP BY orderNumber
) od USING(orderNumber)
GROUP BY o.orderNumber
ORDER BY biaya_pemesanan DESC
LIMIT 1; 