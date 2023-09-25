USE classicmodels;

-- nomor 1
DESCRIBE customers;
SELECT customerName, city, country FROM customers WHERE country = 'USA';

-- nomor 2
DESCRIBE products;
SELECT DISTINCT productVendor FROM products;

-- nomor 3
DESCRIBE payments;
SELECT * FROM payments WHERE customerNumber = 124 ORDER BY paymentDate DESC;

-- nomor 4
SELECT productName AS 'Nama produk', buyPrice AS 'Harga beli', quantityInStock AS 'Jumlah dalam stok' FROM products 
-- WHERE quantityInStock > 1000 AND quantityInStock < 3000 
WHERE quantityInStock BETWEEN 1000 AND 3000
ORDER BY buyPrice ASC
LIMIT 5, 10;

-- soal tambahan
-- nomor 1
DESCRIBE orders;
SELECT * FROM orders;
SELECT * FROM orders WHERE orderDate BETWEEN '2004-12-31' AND '2006-01-01' AND status = 'Shipped' 
ORDER BY orderNumber DESC;

-- nomor 2
SELECT * FROM products;
SELECT productName AS 'nama produk' FROM products 
WHERE productLine = 'Classic Cars' AND productScale = '1:12' 
ORDER BY productName ASC LIMIT 5;

