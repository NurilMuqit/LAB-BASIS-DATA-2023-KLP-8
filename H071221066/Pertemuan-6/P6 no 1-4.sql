USE classicmodels;

-- no 1 >> karyawan yang menangani lebih dari 10 orderan.
SELECT
	CONCAT(e.firstName, ' ', e.lastName) AS NamaKaryawan,
	GROUP_CONCAT(o.orderNumber ORDER BY o.orderNumber) AS NomorOrderan,
	COUNT(o.orderNumber) AS JumlahOrderan
FROM employees e
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders o USING(customerNumber)
GROUP BY NamaKaryawan
HAVING JumlahOrderan > 10;

-- no 2 >> tanggal pesanan paling awal dari produk yang memiliki stok lebih dari 5000
SELECT p.productCode, p.productName, p.quantityInStock, o.orderDate
FROM products p
JOIN orderdetails od USING(productCode)
JOIN orders o USING(orderNumber)
GROUP BY p.productCode, p.productName, p.quantityInStock
HAVING p.quantityInStock > 5000
ORDER BY orderDate;

-- no 3 >> alamat pertama tiap kantor, no.telp yg 5 angka terakhir disamarkan,
--  jumlah karyawan, jumlah pelanggan yg pernah dilayani, serta rata-rata penghasilan.
SELECT 
	oc.addressLine1 AS Alamat,
	CONCAT(LEFT(oc.phone, 6),'* **') AS Nomor_Telp, 
	COUNT(DISTINCT e.employeeNumber) AS Jumlah_Karyawan,
	COUNT(DISTINCT c.customerNumber) AS Jumlah_Pelanggan,
	ROUND(AVG(py.amount), 2) AS RataRata_Penghasilan
FROM offices oc
JOIN employees e USING(officeCode)
LEFT JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
LEFT JOIN payments py USING(customerNumber)
GROUP BY Alamat
ORDER BY Nomor_Telp;

-- no 4 >> orderan dilakukan pada tahun 2003.
SELECT
	c.customerName AS Nama_Customer,
	YEAR(o.orderDate) AS Tahun_Order,
	MONTHNAME(o.orderDate) AS Bulan_Order,
	COUNT(o.orderNumber) AS Jumlah_Pesanan,
	SUM(od.priceEach * od.quantityOrdered) AS Uang_Total_Penjualan
FROM customers c
JOIN orders o USING (customerNumber)
JOIN orderdetails od USING (orderNumber)
GROUP BY Nama_Customer, Bulan_Order
HAVING Tahun_Order = 2003;

-- STUDY CASE 
# Hitung rata-rata selisih hari antara tanggal order dan tanggal pengiriman untuk setiap 
# pelanggan yang dipesan berdasarkan selisih terbesar
SELECT 
	customerNumber, shippedDate, orderDate,
	AVG(DATEDIFF(shippedDate, orderDate)) AS RatarataSelisihHari
FROM orders
GROUP BY customerNumber
ORDER BY RatarataSelisihHari DESC;