use classicmodels

#1
select concat(e.firstname, ' ', e.lastname) as 'Nama Karyawan',
		group_concat(o.ordernumber separator ', '),
		count(o.customernumber) as 'Jumlah Order'
from orders o
join customers c on o.customernumber = c.customernumber
join employees e on c.salesRepEmployeeNumber = e.employeenumber
group by e.employeeNumber 
having count(o.customernumber) > 10

#2
select p.productCode, p.productName, p.quantityInStock, min(o.orderDate)
from products p
join orderdetails od on p.productCode = od.productCode
join orders o on od.orderNumber = o.orderNumber
where p.quantityInStock > 5000
group by p.productCode, p.productName, p.quantityInStock

#3
SELECT
    o.addressLine1 AS Alamat,
    CONCAT(LEFT(o.phone, 6), '*', ' ', '**') AS 'Nomor Telp',
    COUNT(DISTINCT e.employeeNumber) AS 'Jumlah Karyawan',
    COUNT(distinct c.customerNumber) AS 'Jumlah Pelanggan',
    FORMAT(AVG(p.amount),2) AS 'Rata-rata Penghasilan'
FROM
    offices o
    left JOIN employees e ON o.officeCode = e.officeCode
    left JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
    left JOIN payments p ON c.customerNumber = p.customerNumber
GROUP BY
    o.officeCode
ORDER BY
    o.officeCode 

#4
select c.customername, 
		year(o.orderdate) as 'Tahun Order',
		monthname(o.orderdate) as 'Bulan Order',
		count(o.ordernumber) as 'Jumlah Pesanan',
		sum(od.quantityordered * od.priceeach) as 'Uang Total Penjualan'
from customers c
join orders o on c.customernumber = o.customerNumber 
join orderdetails od on o.ordernumber = od.orderNumber 
where year(o.orderdate) = 2003
group by c.customername, year(o.orderdate), monthname(o.orderdate)
order by year (o.orderdate), monthname(o.orderdate)

-- Soal Tambahan --
#1
select
    concat(e.lastName, ', ', e.firstName) as 'Nama Karyawan',
    sum(od.quantityOrdered * od.priceEach * 0.05) as 'Komisi'
from
    employees e
    join customers c on e.employeeNumber = c.salesRepEmployeeNumber
    join orders o on c.customerNumber = o.customerNumber
    join orderdetails od on o.orderNumber = od.orderNumber
group by
    e.employeeNumber
order by
    e.lastName, e.firstName


	
