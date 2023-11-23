#1
SELECT * FROM offices
SELECT * FROM payments

SELECT o.addressLine1, o.addressLine2, o.city AS kota, o.country AS negara
FROM offices AS o
JOIN employees AS e
USING (officeCode)
JOIN customers AS c
ON e.employeeNumber = c.salesRepEmployeeNumber
WHERE customerNumber IN (SELECT customerNumber
								 FROM payments
								 GROUP BY customerNumber
								 HAVING COUNT(*) = (SELECT COUNT(*)
														  FROM payments
														  GROUP BY customerNumber
														  ORDER BY COUNT(*)
														  LIMIT 1)
);	

#2
SELECT CONCAT(e.firstName, ' ', e.lastName) AS Karyawan, SUM(p.amount) AS Pendapatan
FROM employees AS e
JOIN customers AS c 
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments AS p 
USING (customerNumber)
WHERE e.employeeNumber IN (
  (SELECT e.employeeNumber 
  FROM employees AS e 
  JOIN customers AS c 
  ON e.employeeNumber = c.salesRepEmployeeNumber 
  JOIN payments AS p 
  USING (customerNumber) 
  GROUP BY e.employeeNumber 
  ORDER BY SUM(p.amount) DESC 
  LIMIT 1), 
  (SELECT e.employeeNumber 
  FROM employees AS e 
  JOIN customers AS c 
  ON e.employeeNumber = c.salesRepEmployeeNumber 
  JOIN payments AS p 
  USING (customerNumber) 
  GROUP BY e.employeeNumber 
  ORDER BY SUM(p.amount) 
  LIMIT 1)
)
GROUP BY e.employeeNumber
ORDER BY SUM(p.amount) DESC

#3
SELECT * FROM country; 
SELECT * FROM countrylanguage;

SELECT c.name negara, ((cl.Percentage / 100) * c.Population) 'Pengguna bahasa'
FROM country AS c
JOIN countrylanguage AS cl
ON c.Code = cl.CountryCode 
WHERE LANGUAGE = (SELECT cl.LANGUAGE 
						FROM countrylanguage cl
						JOIN country c
						ON c.Code = cl.CountryCode 
						WHERE Continent = 'asia'
						GROUP BY LANGUAGE
						ORDER BY COUNT(*) DESC 
						LIMIT 1)
						

#4
SELECT c.customerName, SUM(amount) AS 'Total pembayaran' , SUM(od.quantityOrdered) AS 'banyak barang' , GROUP_CONCAT(p.productName SEPARATOR ' | ') AS 'produk yang dibeli'
FROM customers AS c
JOIN orders AS o 
USING (customerNumber)
JOIN orderdetails AS od 
USING (orderNumber)
JOIN products AS p 
USING (productCode)
JOIN payments 
USING (customerNumber)
GROUP BY c.customerNumber
HAVING SUM(amount) > (SELECT AVG(TotalPaymentCustomer)
    						 FROM (select SUM(amount) TotalPaymentCustomer
    							    FROM payments
								    GROUP BY customerNumber) totalPurchased)		