-- CLASE 5 
-- EJEMPLOS DE JOINS
DROP DATABASE IF EXISTS joins_schema;
CREATE DATABASE joins_schema; 

USE joins_schema;

-- [pais] 1 --> * [ciudad]

CREATE TABLE pais (
	nombre_pais VARCHAR(100) PRIMARY KEY,
    area_total INT
);

CREATE TABLE ciudad(
	nombre_ciudad VARCHAR(100) PRIMARY KEY,
    pais_pertenece VARCHAR(100)
);


INSERT INTO joins_schema.pais VALUES
("argentina" , 600),
("mexico", 12000) ;

INSERT INTO joins_schema.ciudad VALUES
("lima", "peru"),
("chaco","argentina"),
("tilcara","argentina"),
("bogota","colombia");




SELECT *
FROM joins_schema.pais ;

SELECT *
FROM joins_schema.ciudad;


SELECT 
-- importante el uso de los alias --> AS !important -> los alias sirven para evitar colpaso por ambiguedad.
	p.nombre_pais AS nombre_pais_tabla_pais,
	c.pais_pertenece AS nombre_pais_tabla_ciudad,
    c.nombre_ciudad	
FROM joins_schema.pais  AS p -- izq
-- INNER JOIN joins_schema.ciudad AS c  -- >> default de un join es  INNER JOIN
-- LEFT JOIN joins_schema.ciudad AS c  -- der
RIGHT JOIN joins_schema.ciudad AS c
	ON p.nombre_pais = c.pais_pertenece
;

-- 
-- UNION => 
USE coderhouse_gamers;
SELECT * FROM coderhouse_gamers.SYSTEM_USER LIMIT 10;
-- OBTENER TODOS LOS USUARIOS QUE TENGAN A_C COMO NOMBRES TODO EN MAYUSCULAS
-- Y EN LA MISMA TABLA TENER LOS DE F-Z PERO TODO EN MINUS

EXPLAIN 
SELECT 
	DISTINCT
	UPPER(email) AS 'ema@il'
--    12 AS email
,	UPPER(CONCAT_WS(", ",last_name,first_name)) AS nombre

-- ,	'campo_raro' AS campo_nuevo -- no va funcionar, pues debe tener la misma cantidad de cols
FROM coderhouse_gamers.SYSTEM_USER
WHERE first_name REGEXP '^[a-c]'
-- ORDER BY first_name 
UNION ALL
SELECT 
	LOWER(CONCAT_WS(", ",last_name,first_name)) AS nombre
,	LOWER(email) as 'ema@il'
FROM coderhouse_gamers.SYSTEM_USER
WHERE first_name REGEXP '^[f-z]'
-- ORDER BY first_name DESC
UNION -- ALL
SELECT 
	UPPER(email) AS 'ema@il'
--    12 AS email
,	UPPER(CONCAT_WS(", ",last_name,first_name)) AS nombre

-- ,	'campo_raro' AS campo_nuevo -- no va funcionar, pues debe tener la misma cantidad de cols
FROM coderhouse_gamers.SYSTEM_USER
WHERE first_name REGEXP '^[a-c]' ;


--  NUMERICS - STRING - BOOL - DATE - UUID(string) - NULL -> SON TAMBIEN TIPO DE DATOS

-- -> FLOAT(6,2)    9999,99

-- STRING:
 -- CHAR, VARCHAR, --> BINARY, VARBINARY, BLOB, TEXT.., ENUM.., and SET.

-- DATE YYYY-MM-DD--> ISO 8601 'YYYY-MM-DD hh:mm:ss'  TIMESTAMP (UNIX) -> DATETIME == YYYY-MM-DD hh:mm:ss

-- BOOL - TRUE/FALSE  analogo -> TINY INT 1 - 0 ;


-- CAST :: SQL - NO SQL - BACK END FRONT


-- GROUP BY || => LAS SUBQUERIES -> solamente cuando no tengo FK's Mejoran la performance de toda query que 
-- no tenga indices per se


EXPLAIN ANALYZE 
SELECT 
	DISTINCT
	UPPER(email) AS 'ema@il'
--    12 AS email
,	UPPER(CONCAT_WS(", ",last_name,first_name)) AS nombre

-- ,	'campo_raro' AS campo_nuevo -- no va funcionar, pues debe tener la misma cantidad de cols
FROM coderhouse_gamers.SYSTEM_USER
WHERE first_name REGEXP '^[a-c]'
-- ORDER BY first_name 
UNION ALL
SELECT 
	LOWER(CONCAT_WS(", ",last_name,first_name)) AS nombre
,	LOWER(email) as 'ema@il'
FROM coderhouse_gamers.SYSTEM_USER
WHERE first_name REGEXP '^[f-z]'
-- ORDER BY first_name DESC
UNION -- ALL
SELECT 
	UPPER(email) AS 'ema@il'
--    12 AS email
,	UPPER(CONCAT_WS(", ",last_name,first_name)) AS nombre

-- ,	'campo_raro' AS campo_nuevo -- no va funcionar, pues debe tener la misma cantidad de cols
FROM coderhouse_gamers.SYSTEM_USER
WHERE first_name REGEXP '^[a-c]' ;

/*
'-> Table scan on <union temporary>  (cost=1242..1282 rows=3000) (actual time=3.49..3.57 rows=881 loops=1)\n    
-> Union materialize with deduplication  (cost=1242..1242 rows=3000) (actual time=3.49..3.49 rows=881 loops=1)\n        
-> Table scan on <temporary>  (cost=332..347 rows=1000) (actual time=1.64..1.66 rows=219 loops=1)\n            
-> Temporary table with deduplication  (cost=332..332 rows=1000) (actual time=1.63..1.63 rows=219 loops=1)\n                -> Filter: regexp_like(SYSTEM_USER.first_name,\'^[a-c]\')  (cost=102 rows=1000) (actual time=0.3..0.807 rows=219 loops=1)\n                    -> Table scan on SYSTEM_USER  (cost=102 rows=1000) (actual time=0.0524..0.32 rows=1000 loops=1)\n        -> Filter: regexp_like(SYSTEM_USER.first_name,\'^[f-z]\')  (cost=102 rows=1000) (actual time=0.102..0.615 rows=662 loops=1)\n            -> Table scan on SYSTEM_USER  (cost=102 rows=1000) (actual time=0.0328..0.266 rows=1000 loops=1)\n        -> Filter: regexp_like(SYSTEM_USER.first_name,\'^[a-c]\')  (cost=102 rows=1000) (actual time=0.0494..0.496 rows=219 loops=1)\n            -> Table scan on SYSTEM_USER  (cost=102 rows=1000) (actual time=0.0241..0.236 rows=1000 loops=1)\n'
*/

-- QUERY(QUERY)
-- <sql> --> coderhouse_gamers.SYSTEM_USER

-- CUANTOS JUEGOS FUERON COMPLETADOS POR TODOS LOS USUARIOS DONDE EL EMAIL contiene .com
SELECT * FROM coderhouse_gamers.PLAY LIMIT 10;

-- QUERY MAIN
SELECT * FROM coderhouse_gamers.PLAY 
WHERE id_system_user IN (
-- SUBQUERY
	SELECT id_system_user
	FROM coderhouse_gamers.SYSTEM_USER
	WHERE email REGEXP '.com$'
);

-- nivel: SYSTEM OF A DOWN
-- OPERADOR EXISTS 
SELECT 
	p.* 
	FROM coderhouse_gamers.PLAY AS p
WHERE EXISTS ( -- existencia nos hace una busqueda boolean -> 0/1 por eso esto es mucho mas rapido
-- SUBQUERY
	-- SELECT id_system_user -- INT
    SELECT 1 -- > Canibal corpse
	FROM coderhouse_gamers.SYSTEM_USER AS u
	WHERE email REGEXP '.com$'
    AND p.id_system_user = u.id_system_user 
)
;

/*
La query que has compartido selecciona todas las columnas de la tabla PLAY (con el alias p), pero solo para las filas donde se cumple una condición establecida mediante la cláusula EXISTS. Vamos a desglosar cada parte:

Descripción de cada sección:
SELECT p.* FROM coderhouse_gamers.PLAY AS p:

Esta parte selecciona todas las columnas (*) de la tabla PLAY, y usa p como alias para referirse a esa tabla. Básicamente, selecciona todas las jugadas o registros de juegos (según lo que almacene la tabla PLAY).
WHERE EXISTS:

La cláusula EXISTS se utiliza para verificar si la subconsulta anidada devuelve algún resultado. Si la subconsulta devuelve al menos una fila, EXISTS será verdadero (1), de lo contrario, será falso (0).
En este caso, la query verifica si existe alguna fila en la tabla SYSTEM_USER que cumpla las condiciones dadas.
Subconsulta (SELECT 1 FROM coderhouse_gamers.SYSTEM_USER AS u):

Aquí está la subconsulta que se ejecuta para cada fila de la tabla PLAY.
La subconsulta selecciona el valor constante 1 (lo que significa que no interesa realmente el contenido de las filas, sino solo si existen o no). Esto es más eficiente que seleccionar una columna innecesaria, como id_system_user, porque solo estamos interesados en la existencia de una coincidencia.
El alias u se le da a la tabla SYSTEM_USER para referirse a ella fácilmente dentro de la subconsulta.
Condiciones de la subconsulta:

WHERE email REGEXP '.com$': Esta condición filtra a los usuarios del sistema cuyo correo electrónico termina en ".com". El operador REGEXP es una expresión regular que busca coincidencias en el campo email. Aquí busca cadenas que terminen con .com.
AND p.id_system_user = u.id_system_user: Esta condición se asegura de que la fila de la tabla PLAY (con p.id_system_user) esté asociada con un usuario del sistema específico (u.id_system_user). Solo se seleccionan las filas de la tabla PLAY que tengan un usuario correspondiente en la tabla SYSTEM_USER que cumpla la condición del correo electrónico.
Resumen:
La consulta selecciona todas las filas de la tabla PLAY en las que el campo id_system_user de la tabla PLAY coincida con un usuario en la tabla SYSTEM_USER, y donde el correo electrónico de ese usuario termine en .com. La subconsulta con EXISTS es más eficiente en términos de rendimiento porque solo verifica la existencia de una coincidencia, sin preocuparse por devolver los datos reales de la tabla SYSTEM_USER.

*/

-- cuantos usuarios completaron cada juego
SELECT 
	universo.id_game AS juego
,	COUNT(universo.completed) AS total_usuarios
FROM (
    SELECT * FROM coderhouse_gamers.PLAY 
	WHERE id_system_user IN (
	-- SUBQUERY
		SELECT id_system_user
		FROM coderhouse_gamers.SYSTEM_USER
		WHERE email REGEXP '.com$'
	)
)AS universo 
WHERE universo.completed = 1
GROUP BY universo.id_game
HAVING total_usuarios > 6
ORDER BY total_usuarios DESC
;

