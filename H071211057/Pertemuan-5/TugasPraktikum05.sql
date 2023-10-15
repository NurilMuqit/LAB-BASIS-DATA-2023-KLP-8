use classicmodels

-- 1 --
select c.customername, p.productname, p2.paymentdate, o.status
from customers c
join payments p2 using (customernumber)
join orders o using (customernumber)
join orderdetails od using (ordernumber)
join products p using (productcode)
where p.productname like "%Ferrari%" and o.status = "shipped" 
order by c.customernumber asc

-- 2 --
#a
select c.customername as 'nama customer', p.paymentdate as 'tanggal pembayaran terkait', concat(e.lastname, ' ', e.firstname) as 'nama karyawan', p.amount
from employees e
join customers c on e.employeenumber = c.salesRepEmployeeNumber 
join payments p on c.customernumber = p.customerNumber 
where monthname (p.paymentdate) = 'november'

#b
select c.customername as 'nama customer', p.paymentdate as 'tanggal pembayaran terkait', concat(e.lastname, ' ', e.firstname) as 'nama karyawan', p.amount
from employees e
join customers c on e.employeenumber = c.salesRepEmployeeNumber 
join payments p on c.customernumber = p.customerNumber 
where monthname (p.paymentdate) = 'november' 
order by p.amount desc limit 1

#c
select c.customername as 'nama customer', p.productname as 'nama produk'
from products p
join orderdetails od on p.productcode = od.productCode 
join orders o on od.ordernumber = o.orderNumber 
join customers c on o.customernumber = c.customernumber
where c.customername = 'Corporate Gift Ideas Co.' 

#d
SELECT customers.customerName, GROUP_CONCAT(products.productName SEPARATOR ', ') AS produk_dibeli
FROM customers
JOIN orders ON customers.customerNumber = orders.customerNumber
JOIN orderdetails ON orders.orderNumber = orderdetails.orderNumber
JOIN products ON orderdetails.productCode = products.productCode
WHERE customers.customername = 'Corporate Gift Ideas Co.'

-- 3 --
select c.customername as 'nama customer', o.orderdate as 'tanggal order', o.shippeddate as 'tanggal pengiriman', datediff (shippedDate, orderDate) AS selisih_hari
from orders o
join customers c on o.customernumber = c.customernumber
where c.customername = 'giftsforhim.com'

-- 4 --

use world

#a 
select * from country
where code like "C%K"

#b
select * from country 
where lifeexpectancy is not null and code like "C%K"

