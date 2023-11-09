USE classicmodels

-- 1
SELECT customerName, city, country 
FROM customers 
WHERE country = 'USA' 

-- 2
SELECT DISTINCT productVendor FROM products;

-- 3
SELECT customerNumber, checkNumber, paymentDate, amount 
FROM payments 
WHERE customerNumber = 124 
ORDER BY paymentDate DESC;

-- 4
SELECT productname AS 'Nama produk', buyprice AS 'Harga beli', 
quantityinstock AS 'Jumlah dalam stok' FROM products 
-- WHERE quantityinstock > 1000 AND quantityinstock < 3000 
WHERE quantityinstock BETWEEN 1000 AND 3000
ORDER BY buyprice ASC 
LIMIT 5,10;

-- 5
SELECT * FROM orders
WHERE `status` = 'Shipped' AND orderDate BETWEEN '2004-12-31' AND '2006-01-01'
ORDER BY orderDate DESC;

-- 6
SELECT productname AS 'Nama produk' FROM products
WHERE productLine = 'Classic Cars' AND productScale = '1:12'
ORDER BY productname ASC
LIMIT 5;

