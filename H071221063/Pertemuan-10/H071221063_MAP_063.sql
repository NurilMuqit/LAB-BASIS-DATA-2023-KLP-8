#1_MRW_096
SELECT address_id, `address` AS 'alamat', postal_code AS 'kode_pos'
FROM address
WHERE address_id BETWEEN 200 AND 300 AND postal_code > 50000
ORDER BY postal_code DESC
LIMIT 5

#2_MKMB_058
SELECT a.actor_id AS 'Id_Aktor', CONCAT(a.first_Name, ' ' , a.last_Name) AS 'Nama_Aktor', SUM(py.amount) AS 'Total_Biaya_Penyewaan'
FROM actor AS a
JOIN film_actor AS fa
ON a.actor_id = fa.actor_id
JOIN film AS f
ON fa.film_id = f.film_id
JOIN inventory AS inv
ON f.film_id = inv.film_id
JOIN rental AS rn
ON inv.inventory_id = rn.inventory_id
JOIN payment AS py
ON rn.rental_id = py.rental_id
WHERE CONCAT(a.first_Name, ' ' , a.last_Name) LIKE 'PEN%NESS'
GROUP BY a.actor_id


#3_AS_095
SELECT * FROM category;
SELECT * FROM film_category 
SELECT f.title, f.LENGTH, c.name AS 'kategori',
CASE 
	WHEN c.name = 'Horror' AND f.length > (SELECT AVG(fl.`length`) FROM film AS fl HAVING AVG(fl.`length`) > 120)
	THEN 'Durasi Panjang'
	WHEN c.name = 'Horror' AND f.length > (SELECT AVG(fl.`length`) FROM film AS fl HAVING AVG(fl.`length`) <= 120)
	THEN 'Durasi Normal'
	ELSE '-' AS 'label_durasi'
END 
FROM film AS f
JOIN film_category AS fc
ON f.film_id = fc.film_id
JOIN category AS c
ON f.category_id = c.category_id
ORDER BY f.`length`


	