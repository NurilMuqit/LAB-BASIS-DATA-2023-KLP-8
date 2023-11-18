USE sakila

-- 1 (ZA_066)
SELECT customer_id, first_name, store_id 
FROM customer 
WHERE store_id != 1
ORDER BY customer_id DESC 
LIMIT 2,10;

-- 2 (MRW_096)
SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) 'nama_pelanggan',
		COUNT(c.customer_id) 'jumlah_peminjaman',
		GROUP_CONCAT(f.title) 'film_yang_dipinjam'
FROM customer c
JOIN rental r USING(customer_id)
JOIN inventory i USING(inventory_id)
JOIN film f USING(film_id)	
GROUP BY customer_id
HAVING COUNT(customer_id) > 30
ORDER BY COUNT(customer_id) DESC;

-- 3 (MKMB_058)
(SELECT s.staff_id  'ID Staff/Actor',
		CONCAT(s.first_name,' ', s.last_name) 'Nama Staff/Actor',
		CASE
			WHEN COUNT(py.payment_id) < 50 THEN 'Sedikit'
			WHEN COUNT(py.payment_id) >= 50 THEN 'Banyak'
		END AS 'Status'
FROM staff s
JOIN payment py USING(staff_id)
GROUP BY s.staff_id)

UNION

(SELECT a.actor_id, CONCAT(a.first_name,' ',a.last_name),
		CASE
			WHEN COUNT(fa.film_id) >= (SELECT AVG(jumlah) 
												FROM (SELECT actor_id, COUNT(film_id) AS jumlah
														FROM film_actor
														GROUP BY actor_id) AS d)
			THEN 'Terkenal'
			ELSE 'Tidak terkenal'
		END AS 'Status'
FROM actor a
JOIN film_actor fa USING(actor_id)
GROUP BY a.actor_id)

