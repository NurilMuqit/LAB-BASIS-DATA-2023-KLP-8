USE sakila;

# No 3
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


# No 4
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