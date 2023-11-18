use classicmodels;

-- NO 4		
#jumlah pembayaran, jumlah barang, serta produk yang dibeli oleh customer yg total pembayaran di atas rata-rata
SELECT
	c.customerName,
	SUM(p.amount) AS Total_Pembayaran,
	SUM(od.quantityOrdered) AS Banyak_Barang,
	GROUP_CONCAT(pr.productName) AS Produk_yang_dibeli
FROM customers c
JOIN orders o USING(customerNumber)
JOIN orderdetails od USING(orderNumber)
JOIN products pr USING(productCode)
JOIN payments p USING(customerNumber)
GROUP BY c.customerNumber
HAVING Total_Pembayaran >
	(SELECT AVG(subTotal)
	FROM (SELECT SUM(od.quantityOrdered * od.priceEach) AS subTotal
			FROM customers c 
			JOIN orders o USING(customerNumber)
			JOIN orderdetails od USING (orderNumber)
			GROUP BY c.customerNumber) AS avgTotal
	);