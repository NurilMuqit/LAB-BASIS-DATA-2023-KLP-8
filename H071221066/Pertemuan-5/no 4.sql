-- praktikum pekan 5
USE world;

-- no 4
SELECT *
FROM country
WHERE Code LIKE 'C%K' AND LifeExpectancy IS NOT NULL;