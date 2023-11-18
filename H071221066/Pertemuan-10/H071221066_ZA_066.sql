-- ZABRYNA ANDINY - H071221066

USE sakila;

-- no 1 > NA_009 
SELECT first_name, last_name, address_id
FROM customer
WHERE address_id BETWEEN 10 AND 50 
ORDER BY first_name;

-- no 2 > VJ_019
SELECT f.title AS 'Judul Film', 
		COUNT(a.actor_id) AS 'Jumlah Aktor', 
		GROUP_CONCAT(CONCAT(a.first_name, ' ', a.last_name)) AS 'Nama Aktor'
FROM film f
JOIN film_actor fa USING(film_id)
JOIN actor a USING(actor_id)
WHERE f.title LIKE 'S%' 
GROUP BY f.title
HAVING COUNT(a.actor_id) > 10;

-- no 3 > MAP_063
(SELECT CONCAT(c.first_Name, ' ' ,c.last_name) AS 'Nama Lengkap', 
			cr.country AS Negara,
			ad.address AS Alamat, 
			DATEDIFF(rt.return_date, rt.rental_date) AS 'Durasi Rental',
			SUM(p.amount) AS 'Total Pembelian',
CASE
	WHEN DATEDIFF(rt.return_date, rt.rental_date) >= 7 AND
			(SELECT SUM(p2.amount) 
			FROM payment p2
         JOIN rental r ON p2.rental_id = r.rental_id
         JOIN customer c2 ON r.customer_id = c2.customer_id
         WHERE c2.customer_id = c.customer_id
         GROUP BY c2.customer_id) > 100 THEN 'Priority Customer'
ELSE 'Not Priority'
END Keterangan
FROM payment p
JOIN rental rt ON p.rental_id = rt.rental_id
JOIN customer c ON rt.customer_id = c.customer_id
JOIN address ad ON c.address_id = ad.address_id
JOIN city ct ON ad.city_id = ct.city_id
JOIN country AS cr ON ct.country_id = cr.country_id
WHERE cr.country LIKE 'I%' AND cr.country != 'Israel'
GROUP BY CONCAT(c.first_Name, ' ', c.last_name)
ORDER BY Keterangan DESC
LIMIT 15)

UNION 

(SELECT CONCAT(c.first_Name, ' ' ,c.last_name), 
			cr.country,
			ad.address, 
			DATEDIFF(rt.return_date, rt.rental_date),
			SUM(p.amount),
CASE
	WHEN cr.country = 'Israel' THEN 'BANNED'
	ELSE '-'
END Keterangan
FROM payment p
JOIN rental rt ON p.rental_id = rt.rental_id
JOIN customer c ON rt.customer_id = c.customer_id
JOIN address ad ON c.address_id = ad.address_id
JOIN city ct ON ad.city_id = ct.city_id
JOIN country AS cr ON ct.country_id = cr.country_id
WHERE cr.country = 'Israel'
GROUP BY CONCAT(c.first_Name, ' ', c.last_name)
ORDER BY Keterangan DESC
);