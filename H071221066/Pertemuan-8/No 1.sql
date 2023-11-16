USE classicmodels;
-- Tampilkan 3 pelanggan dengan modal tertinggi dan 3 pelanggan dengan modal 
-- terendah beserta productName (Modal = harga beli x total pesanan)
(SELECT
  c.customerName,
  p.productName,
  p.buyPrice * SUM(od.quantityOrdered) AS modal
FROM customers c
JOIN orders o USING(customerNumber)
JOIN orderdetails od USING(orderNumber)
JOIN products p USING(productCode)
GROUP BY c.customerNumber
ORDER BY modal DESC
LIMIT 3)
	
UNION

-- terendah
(SELECT
  c.customerName,
  p.productName,
  p.buyPrice * SUM(od.quantityOrdered) AS modal
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
JOIN products p ON od.productCode = p.productCode
GROUP BY c.customerNumber
ORDER BY modal
LIMIT 3)
