USE world;
-- NO3 >> Bahasa yang paling umum digunakan di benua asia dan banyak penggunanya serta nama negara

SELECT c.Name AS Nama_Negara, (c.Population * (cl.percentage / 100)) AS Pengguna_Bahasa
FROM country c
JOIN countrylanguage cl ON c.Code = cl.CountryCode
WHERE cl.language = 
	(SELECT cl1.language
	FROM countrylanguage cl1
	JOIN country c1 ON c1.Code = cl1.CountryCode
	WHERE c1.Continent = 'Asia'
	GROUP BY cl1.language
	ORDER BY COUNT(cl1.language) DESC
	LIMIT 1);