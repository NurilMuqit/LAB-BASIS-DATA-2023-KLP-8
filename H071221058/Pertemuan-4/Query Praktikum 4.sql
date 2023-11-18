# Nomor 1
SELECT 
	c.customerName AS 'Nama Customer',
	c.country AS 'Negara',
	p.paymentDate AS 'tanggal'
FROM customers AS c
JOIN payments AS p
USING(customerNumber)
WHERE p.paymentDate >= '2005-01-01'
ORDER BY p.paymentDate;

# Nomor 2
SELECT DISTINCT 
	c.customerName AS 'Nama customer',
	pr.productName,
	pl.textdescription
FROM customers AS c
JOIN orders AS o
USING(customerNumber)
JOIN orderdetails AS od
USING(orderNumber)
JOIN products AS pr
USING(productCode)
JOIN productlines AS pl
USING(productLine)
WHERE pr.productName = 'The Titanic'

# Nomor 3
ALTER TABLE products
ADD STATUS VARCHAR(20);
-- Cek Product Quantity Terbanyak
SELECT * FROM orderdetails 
ORDER BY quantityOrdered DESC   
LIMIT 1;
-- Merubah Status Menjadi = "best selling"
UPDATE products 
SET STATUS = 'best selling'
WHERE productCode = 'S12_4675';
-- Menampilkan 1 Data Terbanyak
SELECT
	pr.productCode,
	pr.productName,
	od.quantityOrdered,
	pr.`STATUS`
FROM products AS pr
JOIN orderdetails AS od
USING(productCode)
WHERE pr.productName = '1969 Dodge Charger'
ORDER BY od.quantityOrdered DESC
LIMIT 1;


# Nomor 4
-- FK orders Jadi Cascade  
SHOW CREATE TABLE orders;
ALTER TABLE orders
DROP FOREIGN KEY orders_ibfk_1;

-- FK payments Jadi Cascade  
SHOW CREATE TABLE payments;
ALTER TABLE payments
DROP FOREIGN KEY payments_ibfk_1;

-- FK orderdetails Jadi Cascade  
SHOW CREATE TABLE orderdetails;
ALTER TABLE orderdetails
DROP FOREIGN KEY orderdetails_ibfk_1


-- Delete Data Pelanggan Yang Statusnya = 'cancelled'
DELETE c
FROM customers AS c
JOIN orders AS o
USING(customerNumber)
WHERE o.`status` = 'cancelled';

# Pembuktian Data Pelanggan Yang Status 'Cancelled' sudah Terhapus
SELECT * FROM customers c
RIGHT JOIN orders o
USING(customerNumber)
WHERE o.`status` = 'cancelled'

## Soal Tambahan
 
 # Nomor 1
SELECT 
	o.orderDate 
FROM orders AS o
JOIN orderdetails AS od
USING(orderNumber)
JOIN products AS pr
USING(productCode)
WHERE pr.productName = '1940 Ford Pickup Truck' 
ORDER BY o.orderDate DESC;

 # Nomor 2
SELECT productName AS 'Nama Produk',
		 buyPrice 'Harga'
FROM products
WHERE buyPrice < MSRP * 0.8;









