-- ETL
DROP DATABASE IF EXISTS procedures;
CREATE DATABASE procedures;

USE procedures;

-- SELECT * FROM coderhouse_gamers.SYSTEM_USER;
-- ME TRANSFORME DATOS DE USUARIOS DE coderhouse_gamers y que le anexe 
-- bajo ciertos criterios de negocio una ciudad.

-- EXTRACT --> 2 bases de datos
-- 	usuarios + ciudades que le agregar
--     
-- TRANSFORM -> estos usuarios agregarle data y adaptarlo a la necesidad del negocio

-- LOAD --> tabla dentro de una base de datos que maneje cierto negocio

-- que tengan .edu .pl .gov --> munich
-- .com --> paris
-- .org que el resto

DELIMITER //
DROP FUNCTION IF EXISTS procedures.fx_search_city //

CREATE FUNCTION 
	procedures.fx_search_city( _mail VARCHAR(200)) 
RETURNS VARCHAR(200)
    READS SQL DATA
BEGIN
	
    DECLARE _id_ciudad INT ;
	DECLARE nombre_ciudad VARCHAR(200) DEFAULT 'ciudad no reconocida';
    
    CASE 
		WHEN _mail LIKE '%.com' THEN 
			SET _id_ciudad = 3;
		WHEN _mail REGEXP '\\.(edu|pl|gov)$' THEN 
			SET _id_ciudad = 8;
        ELSE
			SET _id_ciudad = 10 ;
	END CASE ;
	
    SELECT nombre INTO nombre_ciudad
		FROM funciones.ciudad
	WHERE id_ciudad = _id_ciudad;
	
	RETURN nombre_ciudad;

END //
DELIMITER ;


DELIMITER //
DROP PROCEDURE IF EXISTS procedures.sp_transform_load_users //
CREATE PROCEDURE procedures.sp_transform_load_users( 
	IN first_char VARCHAR(2)
)
BEGIN
	
	
    INSERT INTO `procedures`.`usuarios_nuevos_productiva` 
    (first_name,last_name,email,ciudad)
    SELECT
		s.first_name,
		s.last_name,
		s.email,
		procedures.fx_search_city(s.email) AS ciudad
	FROM
	coderhouse_gamers.SYSTEM_USER AS s
    WHERE 
		s.first_name LIKE CONCAT( first_char ,'%');
END //

DELIMITER ;

CREATE TABLE `procedures`.`usuarios_nuevos_productiva` (
  `usuario_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(30) NOT NULL,
  `ciudad` varchar(200) DEFAULT NULL,
  stamp_upload DATETIME DEFAULT (CURRENT_TIMESTAMP)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CALL procedures.sp_transform_load_users('z');
























