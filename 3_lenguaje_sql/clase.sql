-- presentacion --> https://docs.google.com/presentation/d/1e-s_pMK8YbkTSCsRxs2ko9e7rjGjdGjfTJC5FTEgvu4/preview?slide=id.g1196d1e3985_0_1282
USE coderhouse_gamers;


-- CONCEPTOS BASICOS DE QUE ES UNA QUERY:
-- ES UNA FORMA IMPERATIVA DE OBTENER DATOS AL SERVIDOR
-- SIEMPRE SE MANEJAN BAJO SENTENCIAS IMPERATIVAS
-- NO EXISTE EL CTRL + Z  

SELECT *
    FROM
    <SCHEMA.TABLE>
;

-- FILTRADO DE DATOS
-- SENTENCIA WHERE :: AYUDA POR MEDIO DE COMPARADPRES Y OPERADORES 
-- A REALIZAR UNA OPERACION DE FILTRADO DE DATOS

SELECT [* | ...COLUMNS]
    FROM
    <SCHEMA.TABLE>

WHERE   
    COL_NAME = VALUE 
;


-- PRACTICA CON EL WHERE Y VERIFICAR QUE ES LO QUE ENTREGA EN LOS REGISTROS
-- EJEMPLOAS PARA VER EN CLASE
SELECT
    *
FROM
    SYSTEM_USER
WHERE
    FIRST_NAME = 'Gillie';

-- RECOMENDACION SOBRE IDENTACION Y TRAILING COMAS

SELECT
        FIRST_NAME
    ,   LAST_NAME
FROM
    SYSTEM_USER
WHERE
    id_user_type = 334;

SELECT
        FIRST_NAME
    ,   LAST_NAME
FROM
    SYSTEM_USER
WHERE
    id_SYSTEM_USER = 56;

SELECT
    *
FROM
    SYSTEM_USER
WHERE
    FIRST_NAME = 'Reinaldos';

-- 

-- DQL: DATA QUERY LANGUAGE
-- hola mundo; Esto es un comentario!! 
-- DROP DATABASE coderhouse_gamers;

USE coderhouse_gamers;


SELECT  -- --> SELECCIONA ALGO
	* -- --> TODAS LAS COLS
FROM coderhouse_gamers.SYSTEM_USER -- --> Esto le indica de donde va a tomar esto
;


-- UN POCO MAS DECLARATIVO

SELECT 
	LOWER(first_name) AS nombre
,	LOWER(last_name) AS apellido
,	email AS correo_electronico
FROM
    coderhouse_gamers.SYSTEM_USER;

--

SELECT DISTINCT
	first_name AS nombre
FROM
    coderhouse_gamers.SYSTEM_USER;
    
    
SELECT 
	-- COUNT(first_name) -- 100 ROWS
    COUNT(DISTINCT first_name) -- 954 ROWS
FROM
    coderhouse_gamers.SYSTEM_USER;



-- NUEVA COLUMNA QUE ME DIGA SI ES ALGO VEDADERO
SELECT 
	first_name AS nombre
,	first_name = 'Tam' AS 'es_tam?'  
FROM
    coderhouse_gamers.SYSTEM_USER
-- WHERE Nos permite a nosotros hacer unas validacions que se los conoce  como filtros
;


SELECT 
	first_name AS nombre,
    last_name ,
    email
FROM
    coderhouse_gamers.SYSTEM_USER
WHERE 
	first_name = 'Tam';
    
-- 

-- buscar user = Tyson
-- id_user_type > 334
-- id_system_user = 56 y 88
-- todos los first_name que arranquen con M

SELECT 
	*
FROM
    coderhouse_gamers.SYSTEM_USER
WHERE 
	first_name = 'Tyson';

SELECT 
	*
FROM
    coderhouse_gamers.SYSTEM_USER
WHERE 
	id_user_type > 334 ; -- "String" 'Sting' `String`


    
SELECT 
	*
FROM
    coderhouse_gamers.SYSTEM_USER
WHERE 
	id_system_user = 56 OR id_system_user = 88 ;
	-- id_system_user = 56 AND id_system_user = 88 ;



SELECT 
	first_name
,	email

FROM
    coderhouse_gamers.SYSTEM_USER
WHERE 
		first_name LIKE 'M%'
    AND	email LIKE '%.com' 
    ;


SELECT 
	first_name
,	email

FROM
    coderhouse_gamers.SYSTEM_USER
WHERE 
		first_name LIKE 'M%'
    AND	email LIKE '%.com' 

ORDER BY first_name DESC;
    


