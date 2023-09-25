-- No 1
SELECT customerName, country, city FROM customers
WHERE country = 'usa'

-- No 2
SELECT DISTINCT productVendor FROM products

-- No 3
SELECT * FROM payments
WHERE customerNumber = 124
ORDER BY paymentDate DESC

-- No 4
SELECT productName AS 'Nama produk', buyPrice AS 'Harga beli', quantityInStock AS 'Jumlah dalam stok' FROM products
-- WHERE quantityInStock > 1000 AND quantityInStock < 3000
WHERE quantityInStock BETWEEN 1000 AND 3000
ORDER BY buyPrice
LIMIT 5,10

-- No 5
SELECT * FROM orders
WHERE orderDate BETWEEN '2004-12-31' AND '2006-01-01' AND STATUS = 'Shipped'
-- WHERE STATUS = 'Shipped'
ORDER BY orderNumber DESC

-- No 6
SELECT productName AS 'nama produk' FROM products
-- SELECT * FROM products
WHERE productLine = 'Classic Cars' AND productScale = '1:12'
ORDER BY productName
LIMIT 5