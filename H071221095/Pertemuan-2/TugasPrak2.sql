USE classicmodels;

## Nomor 1
SELECT customername, 
		city, 
		country
FROM customers
WHERE
		country = 'USA';
		
## Nomor 2
SELECT DISTINCT productVendor
FROM products

## Nomor 3
SELECT *
FROM payments
WHERE customerNumber = 124
ORDER BY paymentDate DESC

## Nomor 4
SELECT productname 'Nama produk',
		buyprice 'Harga beli',
		quantityinstock 'Jumlah dalam stok'
FROM products
WHERE quantityinstock BETWEEN 1000 AND 3000
ORDER BY buyprice ASC
LIMIT 5,10;

### Soal latihan No 1
SELECT *
FROM orders
WHERE orderDate BETWEEN '2004-12-31' AND '2006-01-01' AND STATUS = 'Shipped'
ORDER BY orderNumber DESC

### Soal latihan No 2
SELECT productName 
FROM products
WHERE productLine = 'classic cars' and productScale = '1:12'
ORDER BY productName
LIMIT 5;