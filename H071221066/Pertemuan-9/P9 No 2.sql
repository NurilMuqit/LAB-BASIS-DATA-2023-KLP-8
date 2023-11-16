-- No 2
-- Tampilkan total gaji karyawan dan kategorikan berdasarkan gaji karyawan
-- (Kategori karyawan: di atas rata-rata total gaji karyawan dan di bawah rata-rata total gaji karyawan)
USE classicmodels;

SELECT CONCAT(e.firstName, ' ', e.lastName) AS 'nama karyawan', SUM(p.amount) AS 'gaji', 
CASE
	WHEN SUM(p.amount) > (SELECT AVG(total) 
								FROM (SELECT SUM(amount) AS 'total' 
								FROM payments
 								JOIN customers USING (customerNumber)
 								JOIN employees ON employeeNumber = salesRepEmployeeNumber
 								GROUP BY employeeNumber) AS a) THEN 'di atas rata-rata gaji'
	ELSE 'di bawah rata-rata gaji' 
	END 'kategori gaji'
FROM employees e
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments p USING (customerNumber)
GROUP BY e.employeeNumber
ORDER BY SUM(p.amount) DESC;