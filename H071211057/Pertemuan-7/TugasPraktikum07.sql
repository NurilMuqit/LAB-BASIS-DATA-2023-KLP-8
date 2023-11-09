#1	
select o.addressline1, o.addressline2, o.city as kota, o.country as negara
from offices o
join employees e on o.officecode = e.officeCode 
join customers c on e.employeeNumber = c.salesRepEmployeeNumber 
join payments p on c.customernumber = p.customerNumber 
group by c.customerNumber 
having count(p.amount) =(
 select count(p.amount)
 from payments p
 group by customerNumber 
 order by count(p.amount) 
 limit 1)
 
#2
select concat(e.lastName, e.firstName) as 'Nama Employee', totalAmount as Pendapatan
from employees e
join (
  select c.salesRepEmployeeNumber, sum(p.amount) as totalAmount
  from customers c
  join payments p ON c.customerNumber = p.customerNumber
  group by c.salesRepEmployeeNumber
  order by totalAmount desc
  limit 1
) maxAmount on e.employeeNumber = maxAmount.salesRepEmployeeNumber
union
select concat(e.lastName, e.firstName) as NamaKaryawan, totalAmount as Pendapatan
from employees e
join (
  select c.salesRepEmployeeNumber, sum(p.amount) as totalAmount
  from customers c
  join payments p on c.customerNumber = p.customerNumber
  group by c.salesRepEmployeeNumber
  order by totalAmount asc
  limit 1
) minAmount on e.employeeNumber = minAmount.salesRepEmployeeNumber

#3
use world

select c.name, (c.population * cl.percentage / 100) as 'Pengguna Bahasa'
from country c
join countrylanguage cl on c.code = cl.CountryCode 
where cl.language = (select cl.language
from countrylanguage cl
join country c on cl.countrycode = c.code
where c.continent = 'Asia'
group by cl.language
order by count(cl.language) desc
limit 1)

#4
use classicmodels

SELECT
    c.customerName,
    SUM(p.amount) AS 'Total Pembayaran',
    SUM(od.quantityOrdered) AS 'Banyak Barang',
    GROUP_CONCAT(p1.productName SEPARATOR ', ') AS 'Produk Yang Dibeli'
FROM
    customers c
    JOIN payments p ON c.customerNumber = p.customerNumber
    JOIN orders o ON c.customerNumber = o.customerNumber
    JOIN orderdetails od ON o.orderNumber = od.orderNumber
    JOIN products p1 ON od.productCode = p1.productCode
GROUP BY
    c.customerName
HAVING
    SUM(p.amount) > (SELECT AVG(sum_amount) AS avg
                     FROM (SELECT SUM(amount) AS sum_amount
                           FROM payments
                           GROUP BY customerNumber) AS orang)
ORDER BY
    SUM(p.amount) DESC

#Soal Tambahan 
SELECT customers.customerName AS 'Nama Pembeli', CONCAT(employees.firstName,' ', employees.lastName) AS 'Nama Karyawan',orders.orderNumber AS 'Nomor Pesanan', SUM(orderdetails.quantityOrdered * orderdetails.priceEach) AS 'Total Pembelian'
FROM customers 
INNER JOIN employees
ON customers.salesRepEmployeeNumber = employees.employeeNumber
INNER JOIN orders
ON orders.customerNumber = customers.customerNumber
INNER JOIN orderdetails
ON orders.orderNumber = orderdetails.orderNumber
GROUP BY orders.orderNumber
HAVING SUM(orderdetails.quantityOrdered * orderdetails.priceEach) =
(SELECT MAX(`Total Pembelian`) FROM (SELECT SUM(orderdetails.priceEach * orderdetails.quantityOrdered) AS 'Total Pembelian' from orderdetails GROUP BY orderNumber) as a)



