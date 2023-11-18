USE sakila

-- NO1 AS_095
-- NO2 AS_095
-- NO3 ARZ_057

-- Nomor1
SELECT * FROM city
SELECT city_id, city, country_id 
FROM city
WHERE country_id > 50
ORDER BY country_id ASC
LIMIT 7;

-- Nomor2
SELECT c.name AS 'Kategori', f.title AS 'Judul Film', ROUND(AVG(f.length), 1) AS 'Rata-rata Durasi Film'
FROM film AS f
JOIN film_category AS fc
USING (film_id)
JOIN category AS c
USING (category_id)
WHERE f.title LIKE "C%"
GROUP BY film_id
HAVING AVG(f.length) > 100
ORDER BY AVG(f.length) DESC 


-- Nomor3
SELECT f.title AS 'judu_film', COUNT(i.film_id) AS 'jumlah_salinan', case 
when COUNT(i.film_id) >= 1 then 'ada'
ELSE 'tidak ada'
END AS 'status_inventaris',
c.name AS 'kategori'
FROM inventory AS i
JOIN film AS f
USING (film_id)
JOIN film_category AS fc
USING (film_id)
JOIN category AS c
USING (category_id)
GROUP BY film_id
UNION 
SELECT f.title AS 'judu_film', COUNT(i.film_id) AS 'jumlah_salinan', case 
when COUNT(i.film_id) >= 1 then 'ada'
ELSE 'tidak ada'
END AS 'status_inventaris',
c.name AS 'kategori'
FROM inventory AS i
JOIN film AS f
USING (film_id)
JOIN film_category AS fc
USING (film_id)
JOIN category AS c
USING (category_id)
GROUP BY film_id 