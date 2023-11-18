USE sakila;
/* NOMOR 1 MAP_063 */
SELECT
    c.email,
    c.first_name 'Nama Depan',
    c.last_name 'Nama Belakang',
    c.active
FROM customer c
WHERE c.last_name LIKE 'L%' AND c.active = 1;

/* NOMOR 2 ARZ_057 */
SELECT
    CONCAT(c.first_name,' ',c.last_name) 'Nama Pelanggan',
    ci.city,
    co.country,
    SUM(p.amount) total_pembayaran
FROM country co
JOIN city ci USING (country_id)
JOIN address ad USING (city_id)
JOIN customer c USIng (address_id)
JOIN payment p ON c.customer_id = p.customer_id
WHERE co.country = 'Japan'
GROUP BY c.customer_id;

/* NOMOR 3 VJ_019 */
SELECT
    f.title 'Judul Film',
    c.name Kategori,
    f.length 'Durasi Film',
    f.rating Rating,
    CASE f.rating
        WHEN 'G' THEN 'Cocok Untuk Semua Usia'
        WHEN 'NC-17' THEN 'Tidak Cocok Untuk Anak-Anak'
        ELSE 'Perlu Pengawasan Orang Tua'
    END AS Keterangan
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
WHERE f.title LIKE 'C%' AND
      (c.name = 'Family' OR c.name = 'Animation') AND
      f.length < (SELECT AVG(f2.length)
                  FROM film f2
                  JOIN film_category fc2 ON f2.film_id = fc2.film_id
                  JOIN category c2 ON fc2.category_id = c2.category_id
                  WHERE c2.name = c.name);
