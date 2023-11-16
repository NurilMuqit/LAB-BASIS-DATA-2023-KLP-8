-- praktikum pekan 5
USE classicmodels;

-- no 3
SELECT
	c.customerName AS 'Nama Customer',
	o.orderDate AS 'Tanggal Order',
	o.shippedDate AS 'Tanggal Pengiriman',
   DATEDIFF(o.shippedDate, o.orderDate) AS 'Waktu Menunggu'
FROM customers c
JOIN orders o USING (customerNumber)
WHERE c.customerName = 'GiftsForHim.com';