USE sakila;

-- 3
SELECT CONCAT(c.first_name,' ',c.last_name) 'customer_name',
		MAX(p.amount) 'amount',
		CONCAT(s.first_name,' ',s.last_name) 'staff_name',
		ad.address 'staff_address'
FROM customer c
JOIN payment p USING(customer_id)
JOIN staff s USING(staff_id)
JOIN address ad ON s.address_id = ad.address_id
WHERE ad.address = '1411 Lillydale Drive' AND 
		LEFT(c.first_name,1) = RIGHT(c.last_name,1) AND
		p.amount > 10/100 * (SELECT AVG(amount) FROM payment)
GROUP BY c.customer_id
ORDER BY MAX(p.amount) DESC
LIMIT 1;
