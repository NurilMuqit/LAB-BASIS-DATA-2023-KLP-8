# no.1 vj 019
# no.2 za 066
# no.3 na 009

#1
select actor_id as 'ID Aktor', concat(first_name, ' ', last_name) as 'Nama Aktor' 
from actor
where first_name like 'C%' and actor_id between 50 and 100
order by actor_id desc

#2
select a.actor_id, 
		(select concat(a.first_name,' ', a.last_name) from actor
		where concat(a.first_name, ' ', a.last_name) like 'S%E') as Nama_Aktor, 
		f.film_id, 
		avg(r.rental_date) as avg_rental_duration
from actor a
join film_actor fa on a.actor_id = fa.actor_id
join film f on fa.film_id = f.film_id 
join inventory i on f.film_id = i.film_id 
join rental r on i.inventory_id = r.inventory_id 
where a.actor_id < 50
group by a.actor_id, Nama_Aktor, f.film_id

#3
select concat(c.first_name, ' ', c.last_name) as 'Nama Customer', 
		a.address as daerah,
		concat(a2.first_name, ' ', a2.last_name) as 'Nama Aktor',
		f.title as 'Judul Film',
		day(p.payment_date) as 'Tanggal Pembayaran',
		count(p.amount) as 'Jumlah Pembayaran',
	    case 
	    	when count(p.amount) < 2.99 then 'Film Kurang Direkomendasikan'
	    	else 'Film Direkomendasikan'
	    end 'Keterangan'
from customer c 
join address a on c.address_id = a.address_id
join payment p on c.customer_id = p.customer_id 
join rental r on c.customer_id = p.customer_id
join inventory i on r.inventory_id = i.inventory_id 
join film f on i.film_id = f.film_id 
join film_actor fa on f.film_id = fa.film_id 
join actor a2 on fa.actor_id = a2.actor_id
group by concat(c.first_name, ' ', c.last_name), a.address, concat(a2.first_name, ' ', a2.last_name), f.title,day(p.payment_date); 