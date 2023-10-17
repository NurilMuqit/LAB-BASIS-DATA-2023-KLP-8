#Nomor 1
SELECT
    CONCAT(e.firstName, ' ', e.lastName) AS Nama_Karyawan,
    GROUP_CONCAT(o.orderNumber ORDER BY o.orderNumber ASC) AS Nomor_Orderan,
    COUNT(o.orderNumber) AS Jumlah_Orderan
FROM
    employees as e
JOIN
    customers as c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN
    orders as o USING (customerNumber)
GROUP BY
    e.employeeNumber;


#Nomor 2
SELECT
    p.productCode,
    p.productName,
    p.quantityInStock,
    MIN(o.orderDate)AS orderDate
FROM
    products AS p
JOIN
    orderdetails AS od USING (productCode)
JOIN
    orders AS o USING (orderNumber)
WHERE
    p.quantityInStock > 5000
GROUP BY
    p.productCode, p.productName, p.quantityInStock
ORDER BY
    orderDate;

#Nomor 3
SELECT
    o.addressLine1 AS Alamat_Pertama,
    CONCAT(LEFT(o.phone,6), '* **') AS No_Telp,
    COUNT(DISTINCT e.employeeNumber) AS Jumlah_Karyawan,
    COUNT(DISTINCT c.customerNumber) AS Jumlah_Pelanggan,
    FORMAT(AVG(p.amount), 2) AS Rata_Rata_Penghasilan
FROM
    offices o
LEFT JOIN
    employees e
ON o.officeCode = e.officeCode
LEFT JOIN
    customers c ON e.employeeNumber = c.salesRepEmployeeNumber
LEFT JOIN
    payments p USING (customerNumber)
GROUP BY
    o.officeCode
ORDER BY
    No_Telp;


#Nomor 4
SELECT
    c.customerName AS CustomerName,
    YEAR(o.orderDate ) AS TahunOrder,
    MONTH(o.orderDate) AS BulanOrder,
    COUNT(o.orderNumber) AS JumlahPesanan,
    SUM(od.priceEach * od.quantityOrdered)  AS UangTotalPenjualan
FROM
    customers c
JOIN
    orders o USING (customerNumber)
JOIN
    orderdetails od USING (orderNumber)
WHERE
    YEAR(o.orderDate) = 2003
GROUP BY
    CustomerName,BulanOrder;

#Soal_Tambahan
##Nomor_1
select
    c.customerName,
    AVG(DATEDIFF(o.shippedDate,o.orderDate)) as Selisih_Hari
from customers as c
    join orders as o using(customerNumber)
group by c.customerName
order by Selisih_Hari desc;
