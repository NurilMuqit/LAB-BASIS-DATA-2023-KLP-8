# nomor 1 = MKMB_058
SELECT film_id, title AS 'Judul_film', rental_rate AS 'RATING'
FROM film
WHERE rental_rate < 3.00
ORDER BY rental_rate DESC;

# nomor 2 = NA_009
SELECT CONCAT(a.first_name, ' ', a.last_name) AS nama_aktor, 
	f.title AS Judul_film, 
	c.name AS kategori_film,
	f.rating AS rating
FROM actor a
JOIN film_actor fa USING (actor_id)
JOIN film f USING (film_id)
JOIN film_category fc USING (film_id)
JOIN category c USING (category_id)
WHERE c.name IN ('Drama', 'Action', 'Comedy') AND f.rating LIKE 'G%'
GROUP BY nama_aktor
ORDER BY nama_aktor ASC;

# nomor 3 = ZA_066  
SELECT title AS 'Judul film', 
	rental_rate AS 'Harga sewa', 
	CASE 
		WHEN rental_rate >= 3.5 THEN 'Mahal'
		ELSE 'Murah'
	END AS 'Label Harga Sewa'
FROM film
WHERE rental_rate > (
	SELECT AVG(f2.rental_rate)
	FROM film f2
	JOIN film_category fc2 USING (film_id)
	JOIN category c2 USING (category_id)
	WHERE c2.name IN ('Comedy', 'Action')
	)
ORDER BY rental_rate DESC;



