USE classicmodels;

-- no 4
-- Tampilkan tanggal dan riwayat proses yang pernah dilakukan oleh customer 
-- (memesan barang atau membayar pesanan) pada bulan april 2003
SELECT tanggal, GROUP_CONCAT(statuspesanan SEPARATOR ' dan ') AS riwayat
FROM (
	SELECT orderDate AS tanggal, 'memesan barang' AS statuspesanan
	FROM orders
	WHERE MONTH(orderDate) = 4 AND YEAR(orderDate) = 2003
	
	UNION
	
	SELECT paymentDate, 'membayar pesanan'
	FROM payments
	WHERE MONTH(paymentDate) = 4 AND YEAR(paymentDate) = 2003
) AS datacustomers
GROUP BY tanggal
ORDER BY tanggal;