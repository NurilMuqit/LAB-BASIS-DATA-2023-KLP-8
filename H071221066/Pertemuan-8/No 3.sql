USE classicmodels;

-- tampilkan seluruh karyawan atau pelanggan yang dilayani dan statusnya (karyawan/pelanggan) 
-- yang berasal dari kantor yang memiliki employee (karyawan)
-- paling sedikit kemudian urutkan berdasarkan nama karyawan/pelanggan

SELECT CONCAT(e.firstName, ' ', e.lastName) AS NamaKaryawanPelanggan, 'Employee' AS Status
FROM employees e
WHERE e.officeCode IN (
	SELECT officeCode
	FROM employees
	GROUP BY officeCode
	HAVING COUNT(*) = (
		SELECT MIN(employee_count)
		FROM (
		   SELECT COUNT(*) AS employee_count
		   FROM employees
		   GROUP BY officeCode
		) AS OfficeEmployeeCounts
	)
)

UNION

SELECT c.customerName, 'Customer'
FROM customers c
WHERE c.salesRepEmployeeNumber IN (
	SELECT employeeNumber
	FROM employees
	WHERE officeCode IN (
		SELECT officeCode
		FROM employees
		GROUP BY officeCode
		HAVING COUNT(*) = (
	      SELECT MIN(employee_count)
			FROM (
			   SELECT COUNT(*) AS employee_count
			   FROM employees
			   GROUP BY officeCode
			) AS OfficeEmployeeCounts
		)
   )
)
ORDER BY NamaKaryawanPelanggan;