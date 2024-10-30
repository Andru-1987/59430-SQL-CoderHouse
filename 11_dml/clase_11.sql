USE donaton;

-- INSERT STATEMENT

-- INSERT
-- 	INTO <table>
--     (cols ...)
--     VALUES
--     (),(),();

DESCRIBE donaton.beneficiario;

INSERT 
	INTO	donaton.beneficiario
    (id_beneficiario, direccion,nombre_encargado,fecha_creacion)
    VALUES
    (1,'La plata 100','Pepito',CURRENT_DATE());
    

ALTER TABLE 
	donaton.beneficiario
    ADD COLUMN antiguedad_1980 DECIMAL(10,2) 
    AS ( DATEDIFF(fecha_creacion, '1980-01-01' ) / 365) ;

ALTER TABLE 
	donaton.beneficiario
    DROP COLUMN antiguedad_1980;

SELECT 
* FROM donaton.beneficiario;

INSERT 
	INTO	donaton.beneficiario
--    (id_beneficiario, direccion,nombre_encargado,fecha_creacion)
    VALUES
    (2,'Rivadavia 3600','Jose Luis','2010-10-10');

INSERT 
	INTO	donaton.beneficiario
    VALUES
    (NULL,'Rivadavia 3600','Jose Luis','2010-10-10');

INSERT 
	INTO	donaton.beneficiario
    VALUES
    (-10,'Rivadavia 3600','Jose Luis','2010-10-10');
    
    
INSERT 
	INTO	donaton.beneficiario
	(direccion,nombre_encargado,fecha_creacion)
    VALUES
    ('Rivadavia 1980','Jose Luis','2010-10-10');
    
INSERT 
	INTO	donaton.beneficiario
    VALUES
    (100,'Rivadavia 3600','Jose Luis','2010-10-10');

SHOW CREATE TABLE  donaton.beneficiario;

ALTER TABLE
	donaton.beneficiario
    MODIFY COLUMN fecha_creacion DATE DEFAULT(CURRENT_DATE);
    
INSERT 
	INTO	donaton.beneficiario
    (direccion,nombre_encargado,fecha_creacion)
    VALUES
    ('Mexico 180','Luis Miguel', DEFAULT);
    
 INSERT 
	INTO	donaton.beneficiario
    (direccion,nombre_encargado)
    VALUES
    ('Francia 2','Mauro Icardi'); 
    
 INSERT 
	INTO	donaton.beneficiario
    (nombre_encargado, direccion)
    VALUES
    ('Guillermo Francella', 'Alcorta 2983');  

INSERT 
	INTO	donaton.beneficiario
    (nombre_encargado, direccion)
    VALUES
    ('Marcelo Tinelli', 'Quinta 987'),
    ('Celia Cruz', 'Cuba 87123');


-- actualiza datos
-- UPDATE
-- 	<table>
--     SET cols = new_value ,......
--     WHERE condicion


SELECT *
FROM donaton.beneficiario
WHERE 
		nombre_encargado LIKE 'Celia%'
    AND	direccion LIKE 'Cuba%';


-- 
SET SQL_SAFE_UPDATES = FALSE;

UPDATE
	donaton.beneficiario
    SET direccion = 'Miami Fort 777'
WHERE 
		nombre_encargado LIKE 'Celia%'
    AND	direccion LIKE 'Cuba%';
    
-- UPDATE
-- 	donaton.beneficiario AS a
--     SET a.direccion = 'Miami Fort 666'
-- WHERE a.id_beneficiario = (
-- 	SELECT d.id_beneficiario FROM donaton.beneficiario AS d
-- 	WHERE a.nombre_encargado LIKE 'Celia%'
-- 	LIMIT 1);

UPDATE donaton.beneficiario AS a
JOIN (
    SELECT d.id_beneficiario
    FROM donaton.beneficiario AS d
    WHERE d.nombre_encargado LIKE 'Celia%'
    LIMIT 1
) AS subquery ON a.id_beneficiario = subquery.id_beneficiario
SET a.direccion = 'Miami Fort 666';

UPDATE
	donaton.beneficiario AS a
    SET a.direccion = 'Miami Fort 555'
WHERE a.id_beneficiario = 105;




-- DELETE

DELETE 
	FROM donaton.beneficiario
WHERE 
		nombre_encargado LIKE 'Celia%'
    AND	direccion LIKE 'Miam%';

SET FOREIGN_KEY_CHECKS = FALSE;
TRUNCATE TABLE donaton.beneficiario;

    