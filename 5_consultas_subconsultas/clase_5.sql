-- CLASE 5 
-- EJEMPLOS DE JOINS
DROP DATABASE IF EXISTS joins_schema;
CREATE DATABASE joins_schema; 

USE joins_schema;

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
	c.pais_pertenece
FROM joins_schema.pais  AS p -- izq
-- INNER JOIN joins_schema.ciudad AS c
-- LEFT JOIN joins_schema.ciudad AS c  -- der
RIGHT JOIN joins_schema.ciudad AS c
	ON p.nombre_pais = c.pais_pertenece
;


-- UNION
-- TIPOS DE DATOS
-- USO COMBINADO DE LIKE Y COMODINES
-- EXPRESIONES REGULARES
-- SUBCONSULTAS SQL --> SUBQUERIES
-- COMBINACION DE SUBCONSULTAS Y FUNCIONES ESCALARES

-- EJEMPLOS EN VIVO:
-- UNION
	SELECT
			id_game
		,	name
		,	description
	FROM
		coderhouse_gamers.GAME
	WHERE TRUE
		AND name LIKE 'A%' 
	
	UNION  -- VERTICAL CONCATENATION

	SELECT
			id_game
		,	name
		,	description
	FROM
		coderhouse_gamers.GAME
	WHERE TRUE
		AND name LIKE 'D%'
		AND id_class > 200 
	;

-- CHECK THE DATATYPES OF THE CREATED TABLES: 
SHOW COLUMNS
		FROM coderhouse_gamers.GAME
;


-- OPCION MAS ADECUADA
SELECT 
    COLUMN_NAME AS Field,
    DATA_TYPE AS Type
FROM 
    INFORMATION_SCHEMA.COLUMNS
WHERE 
    TABLE_SCHEMA = 'coderhouse_gamers'
    AND TABLE_NAME = 'GAME';


-- LIKE OPERATOR AND REGEXP 
-- LINK ABOUT REGEXP : https://www.youtube.com/watch?v=de_7k4SHEO0&pp=ygUNUkVHRVhQIEhFQ1RPUg%3D%3D
-- LINK  MYSQL REGEXP : https://dev.mysql.com/doc/refman/8.0/en/regexp.html


SELECT 
	*
FROM coderhouse_gamers.SYSTEM_USER
WHERE TRUE	
	AND email REGEXP '^[a-d]'
;

-- UN POQUITO MAS DIFICIL PERO LAS FACULTADES QUE TIENE REGEXP

SELECT 
	*
FROM coderhouse_gamers.SYSTEM_USER
WHERE TRUE	
	AND email REGEXP '^j[a-zA-Z]+[0-9]+@[a-zA-Z]+.com$'
;

SELECT
	*
FROM coderhouse_gamers.SYSTEM_USER
WHERE TRUE
	AND BINARY email LIKE 'A%.com'
;

SELECT
	*
FROM coderhouse_gamers.SYSTEM_USER
WHERE TRUE
	AND BINARY first_name LIKE 'a%'
;


-- DESAFIO :: ACTIVIDAD EN CLASE

SELECT 
	*
FROM coderhouse_gamers.SYSTEM_USER
WHERE TRUE
	AND first_name 	LIKE 'J%'
	/*
	AND last_name 	LIKE '%W%'
	AND first_name 	LIKE '_I%'
	AND first_name 	LIKE '%K'
	AND first_name 	NOT LIKE '%CH%'
	AND first_name 	LIKE '%CH%'
	*/
;

-- BREAK

-- SUBQUERY

SELECT 
	
		id_game
	,	name
	,	id_class

FROM
	coderhouse_gamers.GAME
WHERE TRUE
	-- PRIMER CAPA DE FILTRADO
	AND id_level = 1
	AND id_game IN 
		(
			-- SUBQUERY
			-- JUEGOS DONDE TUVIERAN MAS DE 14 VOTOS
			-- SIEMPRE QUE SE REALIZA UNA SUBQUERY SE PIENSE DESDE ADENTRO HACIA AFUERA

			SELECT 
				id_game
			-- ,	COUNT(1) AS TOTAL_VOTES
			FROM coderhouse_gamers.VOTE
			GROUP BY id_game
			HAVING COUNT(1) > 10
		)
;




-- OTRA FORMA MAS EFICIENTE
-- EL USO DEL OPERADOR EXISTS



SELECT 
		id_game
	,	name
	,	id_class
FROM
	coderhouse_gamers.GAME AS G
WHERE 
	EXISTS
		(	SELECT 
				id_game
			FROM coderhouse_gamers.VOTE AS V
			WHERE V.id_game = G.id_game 
			GROUP BY id_game	
			HAVING COUNT(1) > 10
		)
	AND id_level = 1
;



-- EJERCITACION EN CLASE DE SUBQUERIES

-- JUEGOS JUGADOS POR JUGADOR
-- CONDICIONALES EN EL NOMBRE DE LOS USUARIOS :: EJEMPLO QUE EMPIECEN CON 'B'
-- INTEGRACION DE HAVING
-- FUNCIONES DE AGREGACION Y GROUP BY
-- GRANULAR POR CUALES FUERON COMPLETADOS Y CUANTOS NO

BUSQUEMOS EN LA TABLA PLAY : 
	
USER:: NOMBRE - EMAIL - APELLIDO
CANTIDAD DE JUEGOS COMPLETOS
CANTIDAD DE JUEGOS INCOMPLETOS



	SELECT 
		id_system_user
	, 	SUM( IF (completed = 1, 1, 0)) AS TOTAL_COMPLETOS 
	, 	SUM( IF (completed = 0, 1, 0)) AS TOTAL_INCOMPLETOS 
	FROM coderhouse_gamers.PLAY
	GROUP BY 
	    id_system_user
	;


-- EJERCICIO DE SUBQUERY UN POCO MAS INTERESANTE 
-- QUIERO UN RANKING DE TOP 10 LOS VOTOS MAS ALTOS CON LOS USUARIOS QUE  LOS VOTARON

-- sql_mode=only_full_group_by




-- PODRIA HACER UN JOIN? 
SELECT 
        U.first_name
    ,   U.email
--  ,   S_CORE.id_game
    ,   G.name
FROM 
    coderhouse_gamers.SYSTEM_USER AS U
INNER JOIN  
(
    SELECT 
        MAX(value) AS MAX_VALUE,
        id_system_user,
        (
            SELECT id_game
            FROM coderhouse_gamers.VOTE AS V2
            WHERE V2.id_system_user = V1.id_system_user
            ORDER BY value DESC
            LIMIT 1
        ) AS id_game
    FROM
        coderhouse_gamers.VOTE AS V1
    GROUP BY
        id_system_user
    HAVING
        MAX_VALUE IN (
            SELECT MAX(value) AS MAX_VALUE
            FROM coderhouse_gamers.VOTE
        )
) AS S_CORE
ON U.id_system_user = S_CORE.id_system_user

INNER JOIN coderhouse_gamers.GAME AS G
ON S_CORE.id_game = G.id_game
;



/*
1. **UNION:**
   - **Explicación:** UNION se utiliza para combinar resultados de dos o más consultas SQL en un único conjunto de resultados.
   - **Ejemplo:**
     ```sql
     SELECT nombre FROM empleados
     UNION
     SELECT nombre FROM clientes;
     ```
     Este ejemplo devuelve una lista de nombres que incluye tanto empleados como clientes.


2. **TIPOS DE DATOS:**
   - **Explicación:** MySQL tiene diversos tipos de datos para almacenar diferentes tipos de información, como INT para números enteros o VARCHAR para cadenas de texto.
   - **Ejemplo:**
     ```sql
     CREATE TABLE estudiantes (
       id INT,
       nombre VARCHAR(50),
       edad INT,
       promedio FLOAT
     );
     ```
     En este caso, se crea una tabla "estudiantes" con columnas de diferentes tipos de datos.

	Link de informacion adicional: https://blog.hubspot.es/website/tipos-de-datos-mysql


3. **USO COMBINADO DE LIKE Y COMODINES:**
   - **Explicación:** LIKE se utiliza para buscar patrones en los datos. Puedes combinarlo con comodines como '%' para representar cualquier cadena de caracteres.
   - **Ejemplo:**
     ```sql
     SELECT nombre FROM productos
     WHERE nombre LIKE 'Camiseta%';
     ```
     Esto recuperará todos los productos cuyo nombre comience con "Camiseta".

4. **EXPRESIONES REGULARES:**
   - **Explicación:** Las expresiones regulares son patrones de búsqueda más avanzados. Puedes usarlas para realizar búsquedas más flexibles y complejas.
   - **Ejemplo:**
     ```sql
     SELECT nombre FROM empleados
     WHERE nombre REGEXP '^M[a-z]+';
     ```
     Esto devuelve empleados cuyos nombres comienzan con "M" seguido de letras minúsculas.

5. **SUBCONSULTAS SQL (SUBQUERIES):**
   - **Explicación:** Las subconsultas son consultas anidadas dentro de otras consultas.
   - **Ejemplo:**
     ```sql
     SELECT nombre FROM clientes
     WHERE id IN (SELECT id_cliente FROM pedidos WHERE total > 1000);
     ```
     Aquí, se seleccionan clientes que hayan realizado pedidos con un total superior a 1000.

6. **COMBINACIÓN DE SUBCONSULTAS Y FUNCIONES ESCALARES:**
   - **Explicación:** Puedes utilizar funciones escalares junto con subconsultas para obtener resultados más específicos.
   - **Ejemplo:**
     ```sql
     SELECT nombre, (SELECT AVG(edad) FROM estudiantes) AS promedio_edad
     FROM profesores;
     ```
     En este caso, se obtiene el promedio de edad de los estudiantes y se muestra junto con el nombre de cada profesor.
*/