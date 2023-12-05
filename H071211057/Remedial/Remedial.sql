#1
select f.title as Judul_Film, count(fa.actor_id) as Jumlah_Aktor
from film f
join film_actor fa on f.film_id = fa.film_id 
join actor a on fa.actor_id = a.actor_id 
group by f.title
having count(fa.actor_id) >=10
order by f.title desc

#2
SELECT f.title, f.description, COUNT(r.rental_id) AS jumlah_sewa
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN actor a ON fa.actor_id = a.actor_id
WHERE f.description LIKE '%Dog%' AND f.description LIKE '%Chef%'
GROUP BY f.film_id
ORDER BY jumlah_sewa ASC;

#3
SELECT 
	CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
	p.amount AS amount,
	CONCAT(s.first_name, ' ', s.last_name) AS staff_name,
	a.address AS staff_address
FROM payment p
JOIN customer c USING(customer_id)
JOIN staff s USING(staff_id)
JOIN address a ON s.address_id = a.address_id
WHERE 
	p.amount > (SELECT AVG(amount) * 1.1 FROM payment) AND
	a.address = '1411 Lillydale Drive' AND
	LEFT(c.first_name, 1) = RIGHT(c.last_name, 1)
ORDER BY p.amount DESC
LIMIT 1;

#4
SELECT
	c.first_name AS nama_depan,
	ct.country AS negara,
	f.title AS judul_film
FROM customer c
JOIN address ad USING(address_id)
JOIN city cy USING(city_id)
JOIN country ct USING(country_id)
JOIN rental r USING(customer_id)
JOIN inventory i USING(inventory_id)
JOIN film f USING(film_id)
WHERE f.rating = 'G' AND YEAR(CURRENT_DATE) - YEAR(r.rental_date) = 17;









