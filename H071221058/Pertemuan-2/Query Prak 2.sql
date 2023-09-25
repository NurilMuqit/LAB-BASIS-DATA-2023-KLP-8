# NOMOR 1

# use db
USE classicmodels;

# Nomor 1
SELECT 
	customerName,
	city,
	country
FROM
	customers 
WHERE 
	country = 'USA';
	
# Nomor 2
SELECT DISTINCT 
	productVendor
FROM 
	products;
	
# Nomor 3
SELECT 
	customerNumber,
	checkNumber,
	paymentDate,
	amount
FROM 
	payments
WHERE customerNumber = 124
ORDER BY paymentDate DESC;

# Nomor 4
SELECT 
	productName 'Nama produk',
	buyprice 'Harga beli',
	quantityinstock 'Jumlah dalam stok'
FROM products
WHERE quantityinstock BETWEEN 1000 AND 3000
ORDER BY buyprice 
LIMIT 5,10; 

# Live Coding 
# Nomor 1
SELECT 
	orderNumber,
	orderDate,
	requiredDate,
	shippedDate,
	STATUS,
	comments,
	customerNumber
FROM orders
WHERE orderDate BETWEEN '2004-12-31' AND '2006-01-01' AND  status = 'shipped'
ORDER BY orderNumber DESC;

# Nomor 2
SELECT
	productName 'nama produk'
FROM products
WHERE productScale = '1:12' AND productLine = 'Classic Cars'
ORDER BY productName ASC
LIMIT 5;


