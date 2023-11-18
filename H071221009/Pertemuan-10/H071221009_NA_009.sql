USE sakila;

-- nomor 1 ARZ-057
SELECT title, rating
FROM film
WHERE title LIKE '%action%' AND rating = 'G';

-- nomor 2 MAP_063
SELECT f.title AS'judul',
		 f.description AS 'sinopsis',
		 CONCAT(a.first_name, ' ', a.last_name) AS 'pemeran'
FROM category c
JOIN film_category fc
USING(category_id)
JOIN film f
USING(film_id)
JOIN film_actor fa
USING(film_id)
JOIN actor a
USING(actor_id)
WHERE f.rating = 'PG-13'
AND c.name = 'Documentary' 
AND a.first_name LIKE 'Jennifer%'

-- nomor 3 MRW_096
SELECT c.customer_id,
		 DATEDIFF(r.return_date, r.rental_date) AS 'durasi peminjaman',
		 f.rental_duration AS 'batas peminjaman',
		 CASE
		 	  WHEN DATEDIFF(r.return_date, r.rental_date) > f.rental_duration
		 	  THEN 'terlambat'
		 	  WHEN DATEDIFF(r.return_date, r.rental_date) = f.rental_duration
		 	  THEN 'tepat waktu'
		 	  WHEN DATEDIFF(r.return_date, r.rental_date) < f.rental_duration
		 	  THEN 'cepat kembali'
		 	  ELSE 'belum dikembalikan'
		 END AS 'status pengembalian'
FROM customer c
JOIN rental r
USING(customer_id)
JOIN inventory i
USING(inventory_id)
JOIN film f
USING(film_id)
WHERE f.replacement_cost = (SELECT MAX(f.replacement_cost)
									 FROM film f
									 )
UNION
SELECT c.customer_id,
		 DATEDIFF(r.return_date, r.rental_date) AS 'durasi peminjaman',
		 f.rental_duration AS 'batas peminjaman',
		 CASE
		 	  WHEN DATEDIFF(r.return_date, r.rental_date) > f.rental_duration
		 	  THEN 'terlambat'
		 	  WHEN DATEDIFF(r.return_date, r.rental_date) = f.rental_duration
		 	  THEN 'tepat waktu'
		 	  WHEN DATEDIFF(r.return_date, r.rental_date) < f.rental_duration
		 	  THEN 'cepat kembali'
		 	  ELSE 'belum dikembalikan'
		 END AS 'status pengembalian'
FROM customer c
JOIN rental r
USING(customer_id)
JOIN inventory i
USING(inventory_id)
JOIN film f
USING(film_id)
WHERE f.replacement_cost = (SELECT MIN(f.replacement_cost)
									 FROM film f
									 )	 