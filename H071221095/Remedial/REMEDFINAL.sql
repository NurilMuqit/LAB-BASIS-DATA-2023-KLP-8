USE sakila;

# nomor 1
SELECT
    f.title AS Judul_Film,
    COUNT(a.actor_id) AS Jumlah_Aktor
FROM
    film f
JOIN
    film_actor fa USING (film_id)
JOIN
    actor a USING (actor_id)
GROUP BY
    f.film_id
HAVING
    Jumlah_Aktor >= 10
ORDER BY
    Judul_Film ASC;
    
# nomor 2
SELECT 
    f.title AS Judul_Film,
    f.description AS Deskripsi_Film,
    COUNT(r.rental_id) AS Jumlah_Rental
FROM 
    film f
JOIN 
    film_category fc USING (film_id)
JOIN 
    category ca USING (category_id)
JOIN 
    inventory i USING (film_id)
JOIN 
    rental r USING (inventory_id)
WHERE 
    f.description LIKE '%Dog%' AND f.description LIKE '%Chef%'
GROUP BY 
    f.title, f.description
ORDER BY 
    Jumlah_Rental;


# nomor 3        
SELECT CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
		p.amount AS amount,
		CONCAT('s.first_name', ' ', s.last_name) AS staff_name,
		ad.address AS staff_address
FROM customer c
JOIN payment p USING (customer_id)
JOIN staff s USING (staff_id)
JOIN address ad ON s.address_id = ad.address_id
WHERE ad.address = '1411 Lillydale Drive'
	AND LEFT(c.first_name, 1) = RIGHT(c.last_name, 1)
	AND p.amount > 0.1 * (SELECT AVG(amount) 
	 					      FROM payment p
						      JOIN customer c
						      USING(customer_id))
GROUP BY staff_name;

# nomor 4
SELECT c.first_name AS 'nama_depan',
	co.country AS 'negara',
	f.title AS 'judul_film'
FROM country co
JOIN city ci USING (country_id)
JOIN address ad USING (city_id)
JOIN customer c USING (address_id)
JOIN rental r USING (customer_id)
JOIN inventory i USING (inventory_id)
JOIN film f USING (film_id)
WHERE f.rating LIKE 'G%'
	AND YEAR(r.rental_date) = 2006;



