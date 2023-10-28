USE classicmodels;

-- NO 2
#Tampilkan pendapatan (amount) karyawan terbanyak dan terkecil! 
SELECT
	CONCAT(e.firstname, ' ', e.lastname) AS Nama_Karyawan,
	SUM(p.amount) AS totalPendapatan
FROM employees e
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments p USING(customerNumber)
GROUP BY e.employeeNumber
HAVING SUM(p.amount) = (
	SELECT MAX(totalPendapatan)      -- total pendapatan terbanyak
	FROM (SELECT SUM(p.amount) AS totalPendapatan
		FROM customers c
		JOIN payments p USING (customerNumber)
		GROUP BY c.salesRepEmployeeNumber) AS max_pendapatan
	)
	OR SUM(p.amount) = (
		SELECT MIN(totalPendapatan) 		-- total pendapatan terkecil 
		FROM (SELECT SUM(p.amount) AS totalPendapatan
			FROM customers c
			JOIN payments p
			USING (customerNumber)
			GROUP BY c.salesRepEmployeeNumber) AS min_pendapatan
);