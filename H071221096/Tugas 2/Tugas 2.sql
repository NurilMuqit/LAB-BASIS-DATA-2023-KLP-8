-- nomor 1
SELECT customerName, city, country FROM customers 
WHERE country = 'USA'

-- nomor 2
SELECT DISTINCT productVendor FROM products

-- nomor 3
SELECT customerNumber, checkNumber, paymentDate, amount FROM payments
WHERE customerNumber = 124 
ORDER BY paymentDate DESC 

-- nomor 4
SELECT productname AS 'Nama produk', buyprice AS 'Harga beli' , quantityinstock AS 'Jumlah dalam stok' FROM  products 
WHERE quantityinstock BETWEEN 1000 AND 3000
-- WHERE quantityinstock > 1000 AND quantityinstock < 3000
ORDER BY buyprice 
LIMIT 5,10 

-- nomor 1 tambahan
SELECT orderNumber, orderDate, requiredDate, shippedDate, `status`, comments, customerNumber FROM orders
WHERE orderDate BETWEEN '2004-12-31' AND '2006-01-01' AND `status` = 'shipped'
ORDER BY orderNumber DESC 

-- nomor 2 tambahan
SELECT productName AS 'nama produk' FROM products
WHERE productLine = 'Classic Cars' AND productScale = '1:12'
ORDER BY productName
LIMIT 5 


