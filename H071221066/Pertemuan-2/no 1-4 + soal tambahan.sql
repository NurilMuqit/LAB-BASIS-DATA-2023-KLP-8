USE classicmodels;

-- no1
SELECT 
	customerName, 
	city,
	country
FROM 
	customers 
WHERE 
	country = 'USA';
	
-- no 2
SELECT DISTINCT productVendor
FROM products;
	
-- no 3
SELECT *
FROM payments
WHERE customerNumber = 124
ORDER BY paymentDate DESC; 

-- no 4
SELECT 
	productName AS 'Nama produk',
	buyPrice AS 'Harga beli',
	quantityInStock AS 'Jumlah dalam stok'
FROM 
	products
WHERE quantityInStock BETWEEN 1000 AND 3000
	-- quantityInStock > '1000' AND quantityInStock <'3000'
ORDER BY buyPrice ASC
LIMIT 5,10;


-- soal tambahan
-- no 1
SELECT * FROM orders
WHERE orderDate BETWEEN '2004-12-31' AND '2006-01-01'
AND STATUS = 'shipped'
ORDER BY orderNumber DESC;

-- no 2
SELECT productName
FROM products
WHERE 
	productLine = 'classic cars' AND 
	productScale = '1:12'
ORDER BY productName 
LIMIT 5;