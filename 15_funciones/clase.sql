USE funciones;

-- me devuelva la cantidad de ciudadanos que tengo en un pais
-- siempre y cuando exista ese pais

-- VARIABLES -> 

SET @pais = "%almania%";


SELECT 
    COUNT(ci.id_ciudadano) AS total_ciudadanos
FROM funciones.pais AS p
LEFT JOIN funciones.ciudad AS c 
	ON p.id_pais = c.id_pais
LEFT JOIN funciones.ciudadano AS ci
	ON c.id_ciudad = ci.id_ciudad
WHERE p.nombre LIKE @pais 
GROUP BY p.id_pais
;


DROP FUNCTION IF EXISTS funciones.fx_total_ciudadanos;

DELIMITER //
CREATE FUNCTION funciones.fx_total_ciudadanos(_pais VARCHAR(200))
	RETURNS INT
    READS SQL DATA
BEGIN
	
    DECLARE valor_retorno INT DEFAULT 0;
    
	SELECT 
		COUNT(ci.id_ciudadano) INTO valor_retorno
	FROM funciones.pais AS p
	LEFT JOIN funciones.ciudad AS c 
		ON p.id_pais = c.id_pais
	LEFT JOIN funciones.ciudadano AS ci
		ON c.id_ciudad = ci.id_ciudad
	WHERE p.nombre LIKE _pais
	GROUP BY p.id_pais;

	-- If no citizens are found, raise an error
    IF valor_retorno = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No citizens found for the specified country', MYSQL_ERRNO = 1000;
    END IF;


	RETURN valor_retorno;

END  //
DELIMITER ;




SELECT 
	p.*,
	fx_total_ciudadanos(p.nombre)
FROM funciones.pais AS p;




SELECT 
	'Peru' AS pais,
	fx_total_ciudadanos('Peru') AS total_ciudadanos
FROM DUAL

;

SHOW WARNINGS;


INSERT INTO funciones.ciudadano_doc (id_doc, num_doc, id_ciudadano) VALUES
(1, '28456789', 1),
(2, '29567834', 2),
(3, '30789123', 3),
(4, '31234567', 4),
(5, '32456789', 5),
(6, '33567890', 6),
(7, '34678912', 7),
(8, '35789023', 8),
(9, '36890134', 9),
(10, '37901245', 10),
(11, '38012356', 11),
(12, '39123467', 12),
(13, '40234578', 13),
(14, '41345689', 14),
(15, '42456790', 15),
(16, '43567801', 16),
(17, '44678912', 17),
(18, '45789023', 18),
(19, '46890134', 19),
(20, '47901245', 20),
(21, '28901256', 21),
(22, '29012367', 22),
(23, '30123478', 23),
(24, '31234589', 24),
(25, '32345690', 25),
(26, '33456701', 26),
(27, '34567812', 27),
(28, '35678923', 28),
(29, '36789034', 29),
(30, '37890145', 30),
(31, '38901256', 31),
(32, '39012367', 32),
(33, '40123478', 33),
(34, '41234589', 34),
(35, '42345690', 35),
(36, '43456701', 36),
(37, '44567812', 37),
(38, '45678923', 38),
(39, '46789034', 39),
(40, '47890145', 40),
(41, '28901267', 41),
(42, '29012378', 42),
(43, '30123489', 43),
(44, '31234590', 44),
(45, '32345601', 45);


-- una funcion que dependiendo del pais
-- del documento del cuidadano de mayor edad

DROP FUNCTION IF EXISTS funciones.fx_calculo_edad;

DELIMITER //
CREATE FUNCTION funciones.fx_calculo_edad(_doc VARCHAR(8))
RETURNS INT
DETERMINISTIC
BEGIN
	
	DECLARE primeros_dos_digitos INT;
    DECLARE anio_aproximado INT;
    DECLARE edad_aproximada INT;

    -- Extraer los primeros dos dígitos del DNI
    SET primeros_dos_digitos = CAST(LEFT(_doc, 2) AS UNSIGNED);
    
    -- Determinar el año aproximado de nacimiento
    -- DNIs que empiezan con 4-5: nacidos después de 2000
    -- DNIs que empiezan con 2-3: nacidos entre 1970-1999
    CASE
		WHEN primeros_dos_digitos >= 45 THEN
			SET anio_aproximado = 2000 + primeros_dos_digitos - 45;
		WHEN primeros_dos_digitos >= 40 THEN
			SET anio_aproximado = 2000 + primeros_dos_digitos - 40;
		WHEN primeros_dos_digitos >= 30 THEN
			SET anio_aproximado = 1900 + primeros_dos_digitos;
		WHEN primeros_dos_digitos >= 20 THEN
			SET anio_aproximado = 1900 + primeros_dos_digitos;
    ELSE
        SET anio_aproximado = 2000 + primeros_dos_digitos;
        
    END CASE;
    
    -- Calcular la edad aproximada
    SET edad_aproximada = YEAR(CURRENT_DATE()) - anio_aproximado;
    
    RETURN edad_aproximada;
END //

DELIMITER ;



SELECT 
	fx_calculo_edad('32345601')
FROM DUAL;



DROP FUNCTION IF EXISTS funciones.fx_get_senior_citizen;

DELIMITER //
CREATE FUNCTION funciones.fx_get_senior_citizen(_pais VARCHAR(100))
RETURNS VARCHAR(100)
DETERMINISTIC
COMMENT 'Esta funcion es para quemarles el bocho a los alumnos'
BEGIN

DECLARE nombre_retorno VARCHAR(100) DEFAULT 'No existe';
DECLARE existe_pais BOOL DEFAULT TRUE; 

SELECT COUNT(*) > 0 INTO existe_pais
FROM funciones.pais AS p
WHERE p.nombre LIKE _pais;


IF existe_pais != TRUE THEN
	SET nombre_retorno = "No existe pais";
    RETURN nombre_retorno ;
END IF;


SELECT 
	nombre INTO nombre_retorno
FROM (

SELECT 
		p.id_pais,
		ci.nombre,
		fx_calculo_edad(cd.num_doc) AS edad
	FROM funciones.pais AS p
	LEFT JOIN funciones.ciudad AS c 
		ON p.id_pais = c.id_pais
	LEFT JOIN funciones.ciudadano AS ci
		ON c.id_ciudad = ci.id_ciudad
	LEFT JOIN funciones.ciudadano_doc AS cd
		ON ci.id_ciudadano = cd.id_ciudadano
	WHERE p.nombre LIKE _pais) AS tabla_edades
		ORDER BY edad DESC LIMIT 1;

RETURN nombre_retorno;

END //

DELIMITER ;




SELECT 
	p.*,
	fx_get_senior_citizen(p.nombre) AS ciudadano_mayor
FROM funciones.pais AS p;




