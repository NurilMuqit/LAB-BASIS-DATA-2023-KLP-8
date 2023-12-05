USE sakila;

-- nomor 1
SELECT film.title AS 'Judul_Film',
       COUNT(actor.actor_id) AS 'Jumlah_Aktor'
FROM film 
JOIN film_actor
USING(film_id)
JOIN actor
USING(actor_id)
GROUP BY film.title
HAVING `Jumlah_Aktor` >= 10
ORDER BY film.title ASC;

-- nomor 2
SELECT film.title AS 'Judul_Film',
    	 film.description AS 'Deskripsi_Film',
    	 COUNT(rental.rental_id) AS 'Jumlah_Rental'
FROM film
JOIN inventory 
USING(film_id)
JOIN rental 
USING(inventory_id)
WHERE film.description LIKE '%Dog%'
    	AND film.description LIKE '%Chef%'
GROUP BY film.description
ORDER BY `Jumlah_Rental` ASC;

-- nomor 3
SELECT CONCAT(customer.first_name, ' ', customer.last_name) AS 'customer_name',
    	 max(payment.amount) AS 'amount',
    	 CONCAT(staff.first_name, ' ', staff.last_name) AS 'staff_name',
    	 ad.address AS 'staff_address'
FROM customer
JOIN payment 
USING(customer_id)
JOIN staff 
ON staff.staff_id = payment.staff_id
JOIN address ad 
ON staff.address_id = ad.address_id
WHERE
    ad.address = '1411 Lillydale Drive'
    AND LEFT(customer.first_name, 1) = RIGHT(customer.last_name, 1)
    AND payment.amount > 0.1 * (SELECT AVG(amount)
	 									  FROM payment)
	 AND LENGTH(customer.first_name) = 5 AND LENGTH(customer.last_name) = 7
	 AND customer.first_name LIKE 'T%'
GROUP BY customer.customer_id
HAVING MAX(payment.amount);


-- nomor 4
SELECT customer.first_name AS 'nama_depan',
		 country.country AS 'negara',
		 film.title AS 'judul_film'
FROM country
JOIN city
USING(country_id)
JOIN address 
USING(city_id)
JOIN customer
USING(address_id)
JOIN rental
USING(customer_id)
JOIN inventory
USING(inventory_id)
JOIN film
USING(film_id)
WHERE film.rating LIKE 'G%'
		AND YEAR(rental.rental_date) = 2006;