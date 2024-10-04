USE coderhouse_gamers;

-- Todos los comentarios sobre juegos desde 2019 en adelante.

SELECT
	commentary AS comentario
,	comment_date AS fecha
FROM coderhouse_gamers.COMMENTARY
WHERE 
-- comment_date > '2019-12-31'
   YEAR(comment_date) > 2019
   -- ISO 8601 -> 
ORDER BY comment_date DESC--  default siempre ordena ASC
;



SELECT
	commentary AS comentario
,	comment_date AS fecha
FROM coderhouse_gamers.COMMENTARY
WHERE 
-- comment_date > '2019-12-31'
   YEAR(comment_date) > 2019
   -- ISO 8601 -> 
ORDER BY 2 --  default siempre ordena ASC
;


-- Todos los comentarios sobre juegos anteriores a 2011.
-- Los usuarios y texto de aquellos comentarios sobre juegos cuyo código de juego (id_game) sea 73
-- Los usuarios y texto de aquellos comentarios sobre juegos cuyo id de juego no sea 73.


SELECT * FROM coderhouse_gamers.GAME LIMIT 10; -- TOP -MS Server
-- TRAER TODOS LOS JUEGOS QUE NO empiecen con F

-- VIEWS -> CONSUMIDAS POR UNA HERRAMIENTA DE VIZ O TABLA PARA UN MODELO PARA UN SERVER BACK
SELECT
	*
FROM coderhouse_gamers.GAME 
WHERE 
	name NOT LIKE 'F%'
-- AND id_level = 11 
-- OR id_level = 13
-- OR id_level = 1 
AND id_level IN (1,11,13)
AND id_class != 195
AND id_game BETWEEN 20 AND 50
ORDER BY id_level , id_class
;


SELECT 
* FROM coderhouse_gamers.SYSTEM_USER;

-- CONCAT 
-- LOWER 
-- ADD COLS 


SELECT
	LOWER(CONCAT(last_name, ', ', first_name ))AS nombre_completo
, CONCAT('Bienvenido: ', email) AS mensaje_bienvenida
, 'Password: changeme123!' AS password_user
FROM coderhouse_gamers.SYSTEM_USER;


-- FUCNIONES DE AGREGADO 


SELECT 
	id_user_type
,	COUNT(DISTINCT id_system_user) AS TOTAL_DE_USUARIOS
 FROM coderhouse_gamers.SYSTEM_USER
 GROUP BY id_user_type
 HAVING TOTAL_DE_USUARIOS > 5
 ;

-- que juego tuvo mas cantidad de comentarios

SELECT
	c.id_game
, 	COUNT(c.commentary) AS total_comentario_por__juego
,	g.name
FROM (coderhouse_gamers.COMMENTARY AS c
JOIN  coderhouse_gamers.GAME AS g -- un join por default siempre es inner
	ON c.id_game = g.id_game)
GROUP BY c.id_game
ORDER BY total_comentario_por__juego DESC
LIMIT 10
;






-- Used SQLite3 for this example

-- table PEOPLE: containing unique ID and corresponding names.
CREATE TABLE PEOPLE (id INT, name CHAR);

INSERT INTO PEOPLE VALUES(1, "A");
INSERT INTO PEOPLE VALUES(2, "B");
INSERT INTO PEOPLE VALUES(3, "C");
INSERT INTO PEOPLE VALUES(4, "D");

-- ADDRESS: containing the history of address information of each ID.
CREATE TABLE ADDRESS (id INTEGER, address VARCHAR(100), updatedate date);

INSERT INTO ADDRESS VALUES(1, "address-1-1", "2016-01-01");
INSERT INTO ADDRESS VALUES(1, "address-1-2", "2016-09-02");
INSERT INTO ADDRESS VALUES(2, "address-2-1", "2015-11-01");
INSERT INTO ADDRESS VALUES(3, "address-3-1", "2016-12-01");
INSERT INTO ADDRESS VALUES(3, "address-3-2", "2014-09-11");
INSERT INTO ADDRESS VALUES(3, "address-3-3", "2015-01-01");
INSERT INTO ADDRESS VALUES(4, "address-4-1", "2010-05-21");
INSERT INTO ADDRESS VALUES(4, "address-4-2", "2012-02-11");
INSERT INTO ADDRESS VALUES(4, "address-4-3", "2015-04-27");
INSERT INTO ADDRESS VALUES(4, "address-4-4", "2014-01-01");


-- 10.1 Join table PEOPLE and ADDRESS, but keep only one address information for each person (we don't mind which record we take for each person). 
    -- i.e., the joined table should have the same number of rows as table PEOPLE


SELECT
	*
FROM coderhouse_gamers.PEOPLE AS p
LEFT JOIN coderhouse_gamers.ADDRESS AS a
	ON p.id = a.id;


