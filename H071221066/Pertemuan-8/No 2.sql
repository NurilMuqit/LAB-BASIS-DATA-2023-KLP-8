USE classicmodels;

-- No 2
-- menampilkan kota apa yang paling banyak karyawan atau pelanggan yang namanya diawali huruf L
SELECT city, COUNT(*) AS total
FROM (
   SELECT o.city, e.firstName 
	FROM employees e
	JOIN offices o USING(officeCode)
	WHERE firstName LIKE 'L%'
	
   UNION 
   
	SELECT city, customerName FROM customers 
	WHERE customerName LIKE 'L%'
) AS ec_city
GROUP BY city
ORDER BY total DESC  
LIMIT 1;