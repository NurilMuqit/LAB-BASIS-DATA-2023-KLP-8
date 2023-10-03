-- 1 -- 
select c.customername as 'Nama Customer', c.country as 'Negara', p.paymentdate as 'tanggal'
from customers c
join payments p using (customernumber) 
where p.paymentdate > '2004-12-31'
order by p.paymentdate asc

-- 2 --
select distinct c.customername as 'Nama Customer', p.productname, pl.textDescription
from customers c
join orders o using (customerNumber)
join orderdetails o2 using (orderNumber)
join products p using (productCode)
join productlines pl using (productline)
where productname = 'The Titanic'

-- 3 --
alter table products
add status varchar(20)

update products p
join orderdetails od using (productcode)
set p.status = 'best selling'
where od.quantityordered = '97'

select p.productcode, p.productname, od.quantityordered, p.status
from products p
join orderdetails od using (productcode)
where od.quantityordered = '97'

-- 4 --
delete c from customers c
join orders o using (customernumber)
where o.status = 'Cancelled'

-- Soal Tambahan --
-- 1 --
select o.orderdate
from orders o 
join orderdetails od using (ordernumber)
join products p using (productcode)
where p.productname = '1940 ford pickup truck'
order by o.orderdate asc

-- 2 --
select p.productname, p.msrp*0.8
from products p
join orderdetails od using (productcode)
where od.priceeach










