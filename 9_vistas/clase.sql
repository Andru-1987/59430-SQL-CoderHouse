-- QUE TAL SI, GENERAMOS UN KPI PARA SABER 
-- CUAL ES LA CATEGORIA DE USUARIOS

-- >>>>>>>>> BUENAS PRACTICAS <<<<<<<<<<<<<<<<
USE coderhouse_gamers;

-- CREATE 
-- 	OR REPLACE 
--     VIEW coderhouse_gamers.vw_total_juegos_completados_by_user 
-- 	AS
-- 		SELECT
-- 			id_system_user
-- 		,	COUNT(id_game) AS total_juegos_completados
-- 		FROM coderhouse_gamers.PLAY
-- 		WHERE completed = 1
-- 		GROUP BY id_system_user
-- 		ORDER BY total_juegos_completados ASC
-- 		;

CREATE
	OR REPLACE
    VIEW coderhouse_gamers.vw_super_tabla_categorica
	AS	SELECT 
		total_juegos_completados AS categoria
	, 	COUNT(id_system_user) As total_per_categoria

	FROM coderhouse_gamers.vw_total_juegos_completados_by_user 
	GROUP BY categoria
;

INSERT INTO coderhouse_gamers.PLAY VALUES
(2,21,1),
(10,21,1),
(22,21,1),
(77,21,1),
(78,21,1),
(66,21,1);


SELECT * 
FROM coderhouse_gamers.vw_super_tabla_categorica;

--  TEMP  --> 
CREATE 
	TEMPORARY TABLE
    coderhouse_gamers.temp_categorias
    AS
		SELECT * 
		FROM coderhouse_gamers.vw_super_tabla_categorica
        WHERE total_per_categoria > 50
        ;
-- solo vive en la session de creacion
SELECT * 
FROM coderhouse_gamers.temp_categorias;

-- --

CREATE 
	OR REPLACE
	VIEW coderhouse_gamers.vw_vista_con_subquery
    AS
	SELECT 
		SU.first_name   AS  nombre
	,   SU.last_name    AS  apellido
	,   SU.email        AS  mail
	FROM coderhouse_gamers.SYSTEM_USER AS SU
	WHERE id_system_user IN
		(
		SELECT 
			id_system_user
		FROM coderhouse_gamers.PLAY AS P
		WHERE EXISTS
			(SELECT 
				id_game
			FROM coderhouse_gamers.GAME AS G
			WHERE G.id_game = P.id_game
			AND G.name like '%FIFA 22%'));
		
        
CREATE 
	OR REPLACE
	VIEW coderhouse_gamers.vw_vista_con_joins
    AS
	SELECT 
		SU.first_name AS nombre,
		SU.last_name AS apellido,
		SU.email AS mail
	FROM coderhouse_gamers.SYSTEM_USER AS SU
	JOIN coderhouse_gamers.PLAY AS P 
		-- ON SU.id_system_user = P.id_system_user
		USING(id_system_user)
	JOIN coderhouse_gamers.GAME AS G 
		-- ON P.id_game = G.id_game
		USING(id_game)
	WHERE G.name LIKE '%FIFA 22%';
    
    
-- PARA  VERIFICAR LA PERFORMANCIA

SET profiling = 1;
SHOW PROFILES;

SELECT *
FROM coderhouse_gamers.vw_vista_con_subquery;

-- SHOW PROFILE FOR QUERY <Query_ID>;

SELECT *
FROM coderhouse_gamers.vw_vista_con_joins;

SHOW PROFILE FOR QUERY 3;


-- 

DESCRIBE coderhouse_gamers.VOTE;

CREATE 
	OR REPLACE
    VIEW coderhouse_gamers.vw_juegos_gt_nueve
	AS
	SELECT
		DISTINCT g.name AS nombre_juego
	FROM coderhouse_gamers.VOTE
	LEFT JOIN coderhouse_gamers.GAME AS g
		USING(id_game)
	WHERE 
		value > 9 
	ORDER BY nombre_juego
	;


CREATE 
	OR REPLACE
    VIEW coderhouse_gamers.vw_usuario_si_cumple_condicion
	AS
	SELECT 
		CONCAT(first_name, ", ", last_name) AS full_name ,
		IF (CHAR_LENGTH(password) >=8 ,"cumple criterio :) ", "no cumple criterio :(") strong_password
	FROM coderhouse_gamers.SYSTEM_USER
	WHERE 
		-- email LIKE '%webnode.com%'
        email LIKE '%.com'
        ;

SELECT * 
FROM coderhouse_gamers.vw_usuario_si_cumple_condicion;

SHOW CREATE TABLE  coderhouse_gamers.vw_usuario_si_cumple_condicion;
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`%` 
    SQL SECURITY DEFINER
VIEW `coderhouse_gamers`.`vw_usuario_si_cumple_condicion` AS
    SELECT 
        CONCAT(`coderhouse_gamers`.`SYSTEM_USER`.`first_name`,
                ', ',
                `coderhouse_gamers`.`SYSTEM_USER`.`last_name`) AS `full_name`,
        IF((CHAR_LENGTH(`coderhouse_gamers`.`SYSTEM_USER`.`password`) >= 8),
            'cumple criterio :) ',
            'no cumple criterio :(') AS `strong_password`
    FROM
        `coderhouse_gamers`.`SYSTEM_USER`
    WHERE
        (`coderhouse_gamers`.`SYSTEM_USER`.`email` LIKE '%.com')



