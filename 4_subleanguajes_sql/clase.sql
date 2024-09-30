-- CLASE 4
USE coderhouse_gamers;


-- ORDENAMIENTO DE DATOS
-- ORDER BY

SELECT  [ * | COLS ]
    FROM SCHEMA.TABLE
WHERE
    CONDITIONS
ORDER BY COL | ...COLS
-- always ASC es el valor por default
-- EJEMPLO SOBRE CODERHOUSE DATABASE

SELECT
	*
FROM
	GAME
WHERE
	1 = 1
ORDER BY
	name DESC
	-- como un slicer de lo que estaria
	-- entregando
LIMIT 10;

-- ALIAS ES UNA MANERA DE RENOMBRAR DE MANERA MAS
-- AMIGABLE DE LEER CIERTAS ACCIONES
-- EJEMPLO DE COMO SE PODRIA OTORGAR MAS AMIGABLE EN "ESPAÑOL"

SELECT 
    * 
FROM 
    GAME
LIMIT 10
;

-- NO ES LO MAS FACIL DE ENTENDER POR QUE POR AHI NO ENTIENDO EL IDIOMA
-- +---------+----------------------------------+-----------------------------------+----------+----------+
-- | id_game | name         245 |
-- |       5 | Age of Empires IV                |                                   |        2 |       50 |                         | description                       | id_level | id_class |
-- +---------+----------------------------------+-----------------------------------+----------+----------+
-- |       1 | Forza Horizon 5                  | odio donec                        |        2 |      143 |
-- |       2 | Call of Duty: Vanguard           | morbi non                         |        6 |      153 |
-- |       3 | Shin Megami Tensei 5             | turpis integer aliquet massa id   |        3 |      243 |
-- |       4 | Marvels Guardianes de la Galaxia | lobortis sapien sapien non mi     |        4 | 
-- |       6 | Football Manager 22              | nulla suspendisse potenti         |        8 |      236 |
-- |       7 | Football Manager 22              | mauris lacinia sapien quis libero |       11 |      173 |
-- |       8 | Blue Reflection: Second Light    | libero rutrum ac lobortis         |        2 |       18 |
-- |       9 | Darkest Dungeon II               | erat nulla                        |       11 |       90 |
-- |      10 | Voice of Cards                   | parturient montes nascetur        |        2 |      275 |
-- +---------+----------------------------------+-----------------------------------+----------+----------+
-- 10 rows in set (0.00 sec)



SELECT
        id_game AS identificacion_juego
    ,   name AS nombre_juego
    ,   description AS comentario_del_juego
FROM 
    GAME
LIMIT 10
;

-- MAS AMIGABLE AL USUARIO
-- +----------------------+----------------------------------+-----------------------------------+
-- | identificacion_juego | nombre_juego                     | comentario_del_juego              |
-- +----------------------+----------------------------------+-----------------------------------+
-- |                    1 | Forza Horizon 5                  | odio donec                        |
-- |                    2 | Call of Duty: Vanguard           | morbi non                         |
-- |                    3 | Shin Megami Tensei 5             | turpis integer aliquet massa id   |
-- |                    4 | Marvels Guardianes de la Galaxia | lobortis sapien sapien non mi     |
-- |                    5 | Age of Empires IV                |                                   |
-- |                    6 | Football Manager 22              | nulla suspendisse potenti         |
-- |                    7 | Football Manager 22              | mauris lacinia sapien quis libero |
-- |                    8 | Blue Reflection: Second Light    | libero rutrum ac lobortis         |
-- |                    9 | Darkest Dungeon II               | erat nulla                        |
-- |                   10 | Voice of Cards                   | parturient montes nascetur        |
-- +----------------------+----------------------------------+-----------------------------------+
-- 10 rows in set (0.01 sec)

-- FUNCIONES DE AGREGACION
-- LINK:    https://dev.mysql.com/doc/refman/8.0/en/aggregate-functions.html
-- LINK:    https://www.freecodecamp.org/news/sql-aggregate-functions-how-to-group-by-in-mysql-and-postgresql/


-- EJEMPLO DE FUNCIONES DE AGREGACION

-- TABLE :: COMMENTARY
-- mysql> SHOW COLUMNS FROM COMMENTARY;
-- +----------------+--------------+------+-----+---------+-------+
-- | Field          | Type         | Null | Key | Default | Extra |
-- +----------------+--------------+------+-----+---------+-------+
-- | id_commentary  | int          | NO   | PRI | NULL    |       |
-- | id_game        | int          | NO   | PRI | NULL    |       |
-- | id_system_user | int          | NO   | PRI | NULL    |       |
-- | comment_date   | date         | NO   |     | NULL    |       |
-- | commentary     | varchar(200) | NO   |     | NULL    |       |
-- +----------------+--------------+------+-----+---------+-------+

--COUNT

SELECT
        id_game
    ,   COUNT(id_game) AS TOTAL_COMMENT_BY_GAME
FROM 
    COMMENTARY
-- CARACTERISTICA DE AGREGACION
GROUP BY 
    id_game
ORDER BY TOTAL_COMMENT_BY_GAME DESC

;


-- MIN
SELECT
    MIN(id_game) AS MIN_TOTAL_COMMENT_BY_GAME
FROM 
    COMMENTARY
;


-- GROUP CONCAT
SELECT 
        id_level
    ,   GROUP_CONCAT(description)
FROM CLASS
GROUP BY id_level;

-- UN POCO MAS COMPLICADO PERO ESTA BUENO VERLO COMO ALGO EXTRA
-- UNA COSA MUY LOCA QUE ME PIDIERON EN EL TRABAJO

SELECT
    id_level,
    JSON_OBJECTAGG(id_level, CAST(DESCRIPTION_CONCAT AS CHAR(100)))
FROM
    ( -- ESTO ES UNA SUBQUERY, QUE LO VEREMOS MAS ADELANTE
        SELECT
            id_level,
            JSON_ARRAYAGG(description) AS DESCRIPTION_CONCAT
        FROM
            CLASS
        GROUP BY
            id_level
    ) AS DATA
GROUP BY
    id_level
;

--  EJEMPLOS Y RESULTADOS

SELECT
    *
FROM
    commentary
ORDER BY
    id_system_user desc;



SELECT
    *
FROM
    commentary
ORDER BY
    id_system_user
LIMIT
    3;

SELECT
    COUNT(id_system_user) AS comments,
    id_system_user
FROM
    commentary
GROUP BY
    id_system_user;

SELECT
    COUNT(id_system_user) AS comments,
    id_system_user
FROM
    commentary
GROUP BY
    id_system_user
HAVING
    comments > 2;


-- JOINS (son concatenaciones de tablas del tipo matricial y coincidencia de col)
-- REALIZAN UN MERGE O UNION POR MEDIO DE UN CAMPO EN PARTICULAR
   -- LINK:  https://www.mysqltutorial.org/mysql-basics/mysql-join/
-- EJEMPLO: 
   
   CREACION 
   
   
   SELECT
   -- COLUMNAS DE LA TABLA1
   	TABLA1.[COL|COLS]
   -- COLUMNAS DE LA TABLA2
   	TABLA2.[COL|COLS]
   -- N-TABLAS...
   	FROM 
   		TABLA1 [AS ALIAS_TABLA]
   	[LEFT|RIGHT|INNER] N-TABLAS 
   	ON TABLA1.PK = TABLA2.PK [AND ] 
   	-- USING(NOMBRE_PK) SIEMPRE Y CUANDO EL NOMBRE DE LA PK COINCIDAN
   	
SELECT
*
FROM
`SYSTEM_USER`
LIMIT 10 ;


SELECT
	*
FROM
	USER_TYPE
LIMIT 10;
   
-- MOSTRAR LAS DESCRIPCIONES DE LOS TYPOS DE USUARIO

SELECT
		su.first_name
	,	su.last_name
	,	su.id_user_type
	,	ut.description 
	
	FROM `SYSTEM_USER` AS su  
	LEFT JOIN USER_TYPE AS ut 	
	ON su.id_user_type = ut.id_user_type 
	
ORDER BY ut.description ;

	
-- EJEMPLO MAS DETALLADO
-- Create USERS table

DROP DATABASE IF EXISTS joins_db_sample
CREATE DATABASE joins_db_sample;

USE joins_db_sample;

CREATE TABLE USERS (
    user_id INT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    age INT
);

-- Insert data into USERS table
INSERT INTO USERS (user_id, username, email, age)
VALUES (1, 'JohnDoe', 'john.doe@example.com', 25),
       (3, 'BobJohnson', 'bob.johnson@example.com', 22),
       (20, 'DarthVader', 'darth.sith@force.com.mx', 56),
       (2, 'JaneSmith', 'jane.smith@example.com', 30);

-- Create PRODUCTS table
CREATE TABLE PRODUCTS (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    category VARCHAR(50)
);

-- Insert data into PRODUCTS table
INSERT INTO PRODUCTS (product_id, product_name, price, category)
VALUES (101, 'Laptop', 1200.00, 'Electronics'),
       (102, 'Smartphone', 500.00, 'Electronics'),
       (103, 'Coffee Maker', 80.50, 'Appliances');

-- Create PURCHASE table
CREATE TABLE PURCHASE (
    purchase_id INT PRIMARY KEY,
    user_id INT,
    product_id INT,
    purchase_date DATE,
    quantity INT,
    total_price DECIMAL(10, 2),
    FOREIGN KEY (user_id) REFERENCES USERS(user_id),
    FOREIGN KEY (product_id) REFERENCES PRODUCTS(product_id)
);

-- Insert data into PURCHASE table
INSERT INTO PURCHASE (purchase_id, user_id, product_id, purchase_date, quantity, total_price)
VALUES (1, 1, 101, '2024-01-15', 2, 2400.00),
       (2, 2, 102, '2024-01-20', 1, 500.00),
       (3, 3, 103, '2024-02-01', 3, 241.50),
       (4, NULL, 103, '2024-02-01', 10, 2410.50),
       (5, NULL, 103, '2024-02-01', 20, 6610.50);


-- NOMBRE DE LOS USUARIOS CON SUS RESPECTIVAS COMPRAS
SELECT
  P.PURCHASE_ID
, P.USER_ID
, P.PRODUCT_ID
, P.TOTAL_PRICE
, U.EMAIL

FROM
	PURCHASE AS P
LEFT JOIN USERS AS U
ON P.USER_ID = U.USER_ID
-- USING(USER_ID)
LIMIT 10
;
      
-- RIGHT JOIN



SELECT
  P.PURCHASE_ID
, P.USER_ID
, P.PRODUCT_ID
, P.TOTAL_PRICE
, U.EMAIL

FROM
	PURCHASE AS P
RIGHT JOIN USERS AS U
ON P.USER_ID = U.USER_ID
-- USING(USER_ID)
LIMIT 10
;


SELECT
  P.PURCHASE_ID
, P.USER_ID
, P.PRODUCT_ID
, P.TOTAL_PRICE
, U.EMAIL

FROM
	PURCHASE AS P
JOIN USERS AS U
ON P.USER_ID = U.USER_ID

LIMIT 10
;


-- FULL JOIN NO EXISTE EN MYSQL SIN EMBARGO CON ESTE
-- PEQUEÑO TWEAK LO PODRIAMOS EMULAR PERFECTAMENTE


SELECT
	*
FROM
	PURCHASE AS P
LEFT  JOIN USERS AS U
ON P.USER_ID = U.USER_ID

UNION ALL

SELECT
 *
FROM
	PURCHASE AS P
RIGHT  JOIN USERS AS U
ON P.USER_ID = U.USER_ID

-- FILTRO PARA ELIMINAR NULLS INNECESARIOS

WHERE P.USER_ID IS NULL
;