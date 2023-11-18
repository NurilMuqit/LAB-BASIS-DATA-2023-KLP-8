USE classicmodels;

-- Nomor 1
SELECT * FROM offices
SELECT * FROM payments

SELECT o.addressLine1, o.addressLine2, o.city, o.country
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

-- Nomor 2
SELECT CONCAT(e.firstName, ' ', e.lastName) AS Karyawan, SUM(p.amount) AS Pendapatan, e.employeeNumber
FROM employees AS e
JOIN customers AS c 
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments AS p 
USING (customerNumber)
WHERE e.employeeNumber IN (
  (SELECT e.employeeNumber FROM employees AS e JOIN customers AS c ON e.employeeNumber = c.salesRepEmployeeNumber JOIN payments AS p USING (customerNumber) GROUP BY e.employeeNumber ORDER BY SUM(p.amount) DESC LIMIT 1), 
  (SELECT e.employeeNumber FROM employees AS e JOIN customers AS c ON e.employeeNumber = c.salesRepEmployeeNumber JOIN payments AS p USING (customerNumber) GROUP BY e.employeeNumber ORDER BY SUM(p.amount) LIMIT 1)
)
GROUP BY e.employeeNumber;

-- Nomor 3
USE world;
SELECT * FROM country 
SELECT * FROM countrylanguage

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
						LIMIT 1
)

-- Nomor 4
SELECT c.customerName, SUM(amount) AS 'Total pembayaran' , SUM(od.quantityOrdered) AS 'banyak barang' , GROUP_CONCAT(p.productName SEPARATOR ', ') AS 'produk yang dibeli'
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
;

-- Nomor 1 Tambahan
SELECT * FROM customers
SELECT * FROM orderdetails

SELECT c.customerName AS 'Nama Pelanggan' , CONCAT(e.firstName , " " , e.lastName) AS 'Nama Karyawan', o.orderNumber AS 'Nomor Pesanan' , SUM(od.priceEach * od.quantityOrdered) AS 'Biaya Pesanan'
FROM employees AS e
JOIN customers AS c 
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders AS o
USING(customerNumber)
JOIN orderdetails AS od 
USING (orderNumber)
WHERE orderNumber = (SELECT orderNumber
							FROM orderdetails AS od
							GROUP BY orderNumber
							ORDER BY SUM(od.priceEach * od.quantityOrdered) DESC 
							LIMIT 1
							);
							
						
