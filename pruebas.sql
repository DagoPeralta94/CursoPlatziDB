SELECT name, email, gender FROM clients WHERE gender = 'F';

select year(birthdate)
from clients;

SELECT YEAR(NOW()) - YEAR(birthdate) from clients;

SELECT name, email, YEAR(NOW()) - YEAR(birthdate) AS Edad, gender FROM clients WHERE 
gender = 'F' AND name LIKE '%Lop%';

SELECT b.book_id, a.name, a.author_id, b.title
FROM books as b
JOIN authors as a 
on a.author_id = b.author_id
WHERE a.author_id between 1 and 5;

INSERT INTO transactions(transaction_id, book_id, client_id, `type`,`finished`)
VALUES(1,12,34,'sell',1),
(2,54,87,'lend',1),
(3,3,14,'sell',1),
(4,1,54,'sell',1),
(5,12,81,'lend',1),
(6,12,81,'return',1),
(7,87,29,'sell',1);

ALTER TABLE transactions MODIFY COLUMN `type` enum(
    'sell','lend','return')
    NOT NULL AFTER client_id;
)

SELECT c.name, b.title, a.name, t.type FROM transactions as t 
join books as b 
on t.book_id = b.book_id
join clients as c 
on t.client_id = c.client_id
join authors as a 
on b.author_id = a.author_id
where c.gender = 'M' and t.type IN  ('sell', 'lend');

--Estamos relacionando las tablas!

SELECT b.title, a.name FROM authors as a, books as b
WHERE a.author_id = b.author_id limit 10; --Tolerable pero se está quedando
--Obsoleta

SELECT b.title, a.name
FROM books as b 
inner join authors as a 
on a.author_id = b.author_id 
limit 10; 

select a.author_id, a.name, a.nationality, COUNT(b.book_id) AS Numero_de_Libros
FROM authors as a 
left join books as b 
    on b.author_id = a.author_id
WHERE a.author_id between 1 and 5
GROUP BY a.author_id
order by a.author_id asc;


--¿Cuantas nacionalidades hay?
SELECT DISTINCT nationality FROM authors ORDER BY nationality;

--¿Cuantos escritores hay de cada nacionalidad?
SELECT nationality, COUNT(author_id) AS c_authors
FROM authors 
WHERE nationality IS NOT NULL 
    AND nationality NOT IN('RUS','AUT')
GROUP BY nationality
ORDER BY c_authors DESC, nationality ASC;

--¿Cúal es el promedio/desviación standard del precio de los libros?
SELECT title, price FROM books 
WHERE price IS NOT NULL
ORDER BY price LIMIT 10;

SELECT nationality,
COUNT(book_id) as libros,
AVG(price) AS Promedio, STDDEV(price) AS Desviacion
FROM books as b 
JOIN authors  as a 
ON a.author_id = b.author_id
GROUP BY nationality
ORDER BY libros DESC;

--¿Cúal es el precio máximo y minimo de un libro?
SELECT nationality, MAX(price), MIN(price) 
FROM books as b 
JOIN authors AS a 
ON a.author_id = b.author_id
GROUP BY nationality ;

--Reporte Final
SELECT c.name, t.type, b.title, 
    CONCAT(a.name, " (", a.nationality, ")") as autor,
    TO_DAYS(NOW()) - TO_DAYS(t.created_at) AS ago
FROM transactions AS t 
LEFT JOIN clients AS c 
    ON c.client_id = t.client_id
LEFT JOIN books AS b 
    ON b.book_id = t.book_id
LEFT JOIN authors AS a 
    ON b.author_id = a.author_id;

--Actualizar datos
UPDATE tabla
SET
    [columna = valor, ]
WHERE 
    [condiciones]
LIMIT 1;


--Condicionales y SuperQuerys
select nationality, count(book_id), 
sum(if(year < 1950, 1, 0)) as `<1950`, 
sum(if(year >= 1950 and year < 1990, 1, 0)) as `>1950`,
sum(if(year >= 1990 and year < 2000, 1, 0)) as `<2000`,
sum(if(year >= 2000, 1, 0)) as `<hoy`
from books as b
join authors as a 
on a.author_id = b.author_id 
where 
    a.nationality is not null 
    GROUP BY nationality;

--MySql Dump
