USE classicmodels;

-- NO 1
#Tampilkan secara lengkap alamat (addessline1, addressline2, kota, dan negara) kantor
#tempat karyawan yang melayani pelanggan yang melakukan pembayaran paling sedikit
SELECT  o.addressLine1, o.addressLine2, o.city, o.country
FROM offices o
JOIN employees e USING(officeCode)
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments p USING(customerNumber)
GROUP BY p.customerNumber
HAVING COUNT(p.amount) = (
	SELECT COUNT(p.amount) 
	FROM payments p
	GROUP BY p.customerNumber
	ORDER BY COUNT(p.amount) 
	LIMIT 1
	)