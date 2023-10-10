USE classicmodels;

-- no 1
SELECT * FROM orders

UPDATE orders
SET STATUS = 'Shipped'
WHERE STATUS = 'On process';

-- no 2
SELECT 
    o.orderNumber AS 'Nomor Order',
    p.paymentDate AS 'Tanggal Pembayaran',
    CURRENT_TIMESTAMP AS 'Waktu_Sekarang' 
FROM payments p
JOIN customers c
USING(customerNumber)
JOIN orders o
USING(customerNumber)
WHERE p.paymentDate < '2003-10-10';

SELECT * FROM orders;