USE sakila;

-- 1
SELECT f.title 'Judul_Film',
		COUNT(a.actor_id) 'Jumlah_Aktor'
FROM film f
JOIN film_actor USING(film_id)
JOIN actor a USING(actor_id)
GROUP BY f.title
HAVING COUNT(a.actor_id) >= 10
ORDER BY f.title ASC;

-- 2
SELECT f.title 'Judul_Film',
		f.description 'Deskripsi_Film',
		COUNT(r.rental_id) 'Jumlah_Rental'
FROM film f
JOIN inventory USING(film_id)
JOIN rental r USING(inventory_id)
WHERE f.description LIKE '%Dog%' AND
		f.description LIKE '%Chef%'
GROUP BY f.title
ORDER BY COUNT(r.rental_id) ASC;

-- 3
SELECT CONCAT(c.first_name,' ',c.last_name) 'customer_name',
		SUM(p.amount) 'amount',
		CONCAT(s.first_name,' ',s.last_name) 'staff_name',
		ad.address 'staff_address'
FROM customer c
JOIN payment p USING(customer_id)
JOIN staff s USING(staff_id)
JOIN address ad ON s.address_id = ad.address_id
WHERE ad.address = '1411 Lillydale Drive' AND 
		LEFT(c.first_name,1) = RIGHT(c.last_name,1)
GROUP BY c.customer_id
HAVING SUM(p.amount) > 10/100 * (SELECT AVG(total)
											FROM (SELECT SUM(amount) AS 'total'
													FROM payment
													JOIN customer USING(customer_id)
													GROUP BY customer_id) AS a)
ORDER BY SUM(p.amount) DESC
LIMIT 1;

-- 4
SELECT c.first_name 'nama_depan',
		co.country 'negara',
		f.title 'judul_film'
FROM customer c
JOIN address USING(address_id)
JOIN city USING(city_id)
JOIN country co USING(country_id)
JOIN rental r USING(customer_id)
JOIN inventory USING(inventory_id)
JOIN film f USING(film_id)
WHERE f.rating = 'G' AND YEAR(r.rental_date) = 2023 - 17
GROUP BY c.first_name;

