use classicmodels

show tables

-- 1 --
select customername, city, country 
from customers 
where country = 'USA';

-- 2 --
select distinct productvendor 
from products;

-- 3 --
select customernumber, checknumber, paymentdate, amount 
from payments 
where customernumber = 124 
order by paymentdate desc;

-- 4 --
select productname as 'Nama Produk', buyprice as 'Harga Beli', quantityinstock as 'Jumlah dalam Stok' 
from products 
where quantityinstock between 1000 and 3000 
order by quantityinstock asc 
limit 5, 10;

-- Soal Tambahan --
-- 1 --
select * from orders 
where status = 'shipped' and orderdate between '2004-12-31' and '2006-01-01' 
order by ordernumber desc

-- 2 --
select productname as'nama produk'
from products 
where productline = 'classic cars' and productscale = '1:12' 
order by productname asc limit 5