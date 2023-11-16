-- NO 1
-- Tampilkan jumlah pesanan tiap tahun dan kategorikan jumlah pesanan tersebut
-- (Kategori pesanan: banyak = di atas 150, sedikit = di bawah 75 dan yang lain dikategorikan sedang)
USE classicmodels;

SELECT YEAR(orderDate) AS 'tahun', COUNT(orderNumber) AS 'jumlah pesanan', 
CASE
	WHEN COUNT(orderNumber) > 150 THEN 'Banyak'
	WHEN COUNT(orderNumber) < 75 THEN 'Sedikit'
	ELSE 'Sedang' 
	END 'kategori pesanan'
FROM orders
GROUP BY YEAR(orderDate);