-- praktikum pekan 5
USE classicmodels;

-- no 1
SELECT c.customerName, p.productName, py.paymentDate, o.`status`
FROM customers c
JOIN orders o USING (customerNumber)
JOIN orderdetails od USING (orderNumber)
JOIN products p USING (productCode)
JOIN payments py USING (customerNumber)
WHERE 
	p.productName LIKE '%Ferrari%' AND 
	o.status = 'Shipped';