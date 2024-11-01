-- UPDATE [LOW_PRIORITY] [IGNORE] table_reference
--     SET assignment_list
--     [WHERE where_condition]

USE donaton;


SET SQL_SAFE_UPDATES = TRUE;

UPDATE 
	donaton.beneficiario
    SET 
		direccion = "Azucar 1987" ,
		nombre_encargado = "Celia Knight",
        fecha_creacion = STR_TO_DATE("10/10/1987", "%d/%m/%Y") -- > RECONOCE ISO 8601 -> YYYY-mm-dd
	WHERE
		nombre_encargado LIKE 'Celia%';

UPDATE 
	donaton.beneficiario
    SET 
		nombre_encargado = "Celia Cruz Azucar" 
	WHERE id_beneficiario = 2;

SELECT 
	* 
    FROM donaton.beneficiario;


-- <SQL clase 12> --
-- INGESTAR DATOS DE VOLUNTARIOS



INSERT INTO
    donaton.voluntario
(nombre,fecha_nacimiento)
VALUES
('Melina Gosnold', null),
('Herbie Call', '2023-12-31'),
('Lori Daniele', '2024-05-20'),
('Natividad Phorsby', '2023-11-06'),
('Justine Ubsdell', '2024-06-19'),
('Demetre MacKill', '2024-04-06'),
('Toiboid Thresher', '2024-05-14'),
('Felita Shwalbe', '2024-07-09'),
('Sharline McCosker', '2024-06-11'),
('Westbrooke Wallen', '2024-07-31'),
('Bronny Mennithorp', '2024-09-02'),
('Myrvyn Dalling', '2024-06-20'),
('Claudian Brownhall', '2024-05-29'),
('Torr Winter', '2024-05-03'),
('Dottie Hankins', '2023-11-23'),
('Shelia Matonin', '2024-10-26'),
('Tybalt Lebbern', '2023-11-23'),
('Annemarie Hugonin', '2023-12-04'),
('Tobi Goreisr', '2024-07-26'),
('Armando Yare', '2024-06-27'),
('Patrick Lithcow', '2024-04-22'),
('Jazmin Guyonnet', '2024-09-26'),
('Kelbee Melhuish', '2023-11-15'),
('Jorie Vines', '2024-09-27'),
('Englebert Forton', '2023-12-15'),
('Aimee Creus', '2024-03-27'),
('Babs Prettejohns', null),
('Orran Jimenez', '2024-01-31'),
('Osbourn Dallywater', '2024-08-16'),
('Reinald Marzella', '2024-04-12'),
('Klara Benham', '2024-06-18'),
('Breanne Thornton-Dewhirst', null),
('Lainey Konzel', '2024-03-28'),
('Ebony Bage', '2024-07-24'),
('Jeniffer Marciskewski', '2024-03-18'),
('Karla McCrea', '2023-11-17'),
('Keene Oxbury', null),
('Brandise Curado', null),
('Josi Smyth', '2024-06-10'),
('Hadleigh Tranmer', '2024-01-26'),
('Florri Gideon', '2024-05-15'),
('Levey Vesque', '2023-11-05'),
('Henriette Berford', null),
('Preston Bascomb', '2024-07-14'),
('Teddie Lissandre', '2024-08-08'),
('Darcey Twinbourne', '2024-02-15'),
('Marje Martellini', '2024-03-13'),
('Vi Trigwell', '2023-11-29'),
('Larina Brameld', '2024-06-08'),
('Agata Simonato', '2024-07-25'),
('Gillie Ausiello', '2023-11-11'),
('Westleigh Pioch', null),
('Rafferty Rosenberger', '2024-09-11'),
('Danila Bick', '2024-03-13'),
('Carmelle Koeppke', '2024-10-05'),
('Alyson Malone', '2023-12-01'),
('Ailee Scrooby', '2024-10-25'),
('Iver Yates', '2023-12-17'),
('Regina Sein', '2024-04-23'),
('Son Radborn', '2023-11-18'),
('Datha Mayor', null),
('Ebonee Fasham', '2024-06-16'),
('Estella Smaridge', '2024-10-05'),
('Jodee Egre', '2023-12-26'),
('Catharine Baltzar', '2024-08-24'),
('Shaun Rousby', null),
('Angelika Winspear', '2023-12-11'),
('Lynnelle Dracksford', '2024-09-29'),
('Daveen Fleis', '2024-03-12'),
('Andres Dutson', null),
('Wandie Sommerland', null),
('Garth Starmont', '2024-07-31'),
('Marybelle Langfat', '2024-02-05'),
('Nissy Trevers', '2024-07-13'),
('Trina Grundy', null),
('Tiphany Hardbattle', null),
('Lenard Royste', '2024-10-22'),
('Inger Walcar', '2024-06-03'),
('Eba Float', null),
('Hastings Baggaley', '2024-09-14'),
('Adolpho Machan', null),
('Sibeal Liddon', '2024-10-18'),
('Jyoti Timoney', '2023-11-19'),
('Donavon Thickpenny', '2023-12-25'),
('Tommie Acres', null),
('Niki Frays', '2024-09-15'),
('Julieta Duprey', '2024-03-07'),
('Rebekkah Calwell', '2024-05-28'),
('Emery Kubala', '2024-02-16'),
('Emmeline Falconbridge', '2024-07-25'),
('Joni De Minico', '2024-04-17'),
('Ulrika Edworthye', '2023-11-18'),
('Winne Staton', '2024-09-06'),
('Gaelan Hewins', '2023-11-21'),
('Charmaine Dudman', null),
('Janette Cobb', '2024-03-19'),
('Dell Flint', '2024-01-27'),
('Amie Messiter', '2024-10-27'),
('Harriott McFadyen', null),
('Tamma Le Grand', null);


SELECT * FROM donaton.voluntario;


-- UPDATE
-- forma de ingesta --> INSERT 
CREATE TEMPORARY TABLE _update_data 
SELECT
		id_voluntario
    ,	nombre
    ,	COALESCE(
			DATE_SUB(fecha_nacimiento, INTERVAL 25 YEAR),
			'1955-01-01') AS fecha_nacimiento
FROM donaton.voluntario;


SELECT * FROM _update_data;

ALTER TABLE	_update_data
	DROP COLUMN id_voluntario;

SET SQL_SAFE_UPDATES = FALSE;

UPDATE
	donaton.voluntario AS v ,
    _update_data AS ud
    -- actualizo fecha de nacimiento desde la tabla temporal -> voluntario 
    SET v.fecha_nacimiento = ud.fecha_nacimiento

WHERE
		v.nombre = ud.nombre 
    AND v.fecha_nacimiento = DATE_ADD(ud.fecha_nacimiento, INTERVAL 25 YEAR);


ALTER TABLE donaton.voluntario
	MODIFY COLUMN fecha_nacimiento DATE DEFAULT '1955-01-01';
    
    
UPDATE donaton.voluntario 
SET fecha_nacimiento ='1955-01-01'
WHERE fecha_nacimiento IS NULL;


CREATE TABLE 
	sectorizado_voluntarios (
    id_rango_etario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    cantidad_voluntarios INT ,
    promedio_edad_voluntarios DECIMAL(10,2)
    );

-- rango-etario

ALTER TABLE
	donaton.sectorizado_voluntarios
    ADD COLUMN rango_etario VARCHAR(50) NOT NULL;


INSERT INTO 
	donaton.sectorizado_voluntarios
    (rango_etario, cantidad_voluntarios, promedio_edad_voluntarios)
	SELECT 
		rango_etario
	,	COUNT(id_voluntario)
	,	AVG(edad_voluntario)
	FROM 
		(
		SELECT 
			id_voluntario,
			CASE 
				WHEN TIMESTAMPDIFF(YEAR,fecha_nacimiento,CURRENT_DATE()) BETWEEN 0 AND 18 THEN "menor de edad"
				WHEN TIMESTAMPDIFF(YEAR,fecha_nacimiento,CURRENT_DATE()) BETWEEN 19 AND 45 THEN "mayor de edad"	
				ELSE "mediana edad"
			END AS rango_etario  ,
			TIMESTAMPDIFF(YEAR,fecha_nacimiento,CURRENT_DATE()) AS edad_voluntario
		
			FROM donaton.voluntario
	) AS data_clean
	GROUP BY rango_etario;


SELECT * FROM 
	donaton.sectorizado_voluntarios;



SELECT * FROM donaton.voluntario;
    
UPDATE donaton.voluntario
	SET fecha_nacimiento = DATE_SUB(fecha_nacimiento, INTERVAL RAND()*(10-5)+5 YEAR)
WHERE
	SUBSTRING_INDEX(nombre,' ',-1)  LIKE 'b%' OR SUBSTRING_INDEX(nombre,' ',-1)  LIKE 'd%'
;    


CREATE TEMPORARY TABLE id_to_delete_b
	SELECT b.id_voluntario
        FROM donaton.voluntario AS b
        WHERE 
	SUBSTRING_INDEX(b.nombre,' ',-1)  LIKE 'c%' OR SUBSTRING_INDEX(b.nombre,' ',-1)  LIKE 'e%';
    
    
    

DELETE FROM donaton.voluntario AS a
WHERE EXISTS (  -- IN 
	SELECT
		-- b.id_voluntario  -> UUID
        1
	FROM id_to_delete_b AS b
    WHERE b.id_voluntario = a.id_voluntario
)

