USE coderhouse_gamers;

DELIMITER //
DROP FUNCTION IF EXISTS coderhouse_gamers.fx_descuento_perc //
CREATE FUNCTION coderhouse_gamers.fx_descuento_perc(
	precio DECIMAL(10,2),
    porcentaje DECIMAL(5,2)
) RETURNS DECIMAL(10,2)
DETERMINISTIC
RETURN precio * (1 - ABS(porcentaje)/100) //
DELIMITER ;

SELECT fx_descuento_perc(100, -10) AS valor_descuento FROM DUAL;

SELECT ABS(-10);

-- 
SET AUTOCOMMIT = FALSE ;
SET SQL_SAFE_UPDATES = FALSE;

DELETE FROM donaton.centro_recepcion_beneficiario

ROLLBACK;

INSERT INTO donaton.voluntario
VALUES
(NULL,'dobbie', DATE_SUB(CURRENT_DATE(), INTERVAL 19 YEAR) );

COMMIT;


-- soy un boliche | discoteca | bolera | coca cola bailable

CREATE TABLE donaton.bolichito
AS
SELECT * FROM donaton.voluntario;

SHOW CREATE TABLE donaton.bolichito;

DELETE FROM donaton.bolichito
WHERE id_voluntario >= 10;

SET AUTOCOMMIT = FALSE ;

SELECT COUNT(1) FROM donaton.bolichito;

INSERT INTO donaton.`bolichito` (`nombre`, `fecha_nacimiento`) VALUES
('Andrés García', '1985-04-23'),
('María López', '1990-08-15'),
('Juan Pérez', '1978-11-05');
SAVEPOINT primera_tanda;

INSERT INTO donaton.`bolichito` (`nombre`, `fecha_nacimiento`) VALUES
('Lucía González', '1995-02-20'),
('Carlos Mendoza', '1982-06-18'),
('Sofía Rodríguez', '2000-09-12');
SAVEPOINT segunda_tanda;

INSERT INTO donaton.`bolichito` (`nombre`, `fecha_nacimiento`) VALUES
('Miguel Torres', '1987-03-30'),
('Ana Martínez', '1992-07-08'),
('Javier Fernández', '1980-01-25'),
('Laura Ramírez', '1998-10-14');
SAVEPOINT tercera_tanda;

ROLLBACK;

ROLLBACK TO SAVEPOINT segunda_tanda;

COMMIT;





DELIMITER //
DROP PROCEDURE IF EXISTS donaton.ingesta_personas //
CREATE PROCEDURE donaton.ingesta_personas(IN cuota INT)
BEGIN
	DECLARE MAX_PERSONAS INT DEFAULT 150;
    DECLARE total_personas INT DEFAULT 0;
    DECLARE identificacion VARCHAR(200);
    DECLARE fecha_nacimiento DATE;

    -- Obtener el número actual de personas en la tabla
    SELECT COUNT(1) INTO total_personas FROM donaton.bolichito; -- 119

    -- Iniciar transacción
    START TRANSACTION;

    WHILE total_personas < cuota DO
        -- Aquí puedes personalizar los valores de ejemplo para insertar
        SET identificacion = CONCAT('Persona ', total_personas + 1);
        SET fecha_nacimiento = DATE_SUB(CURDATE(), INTERVAL (20 + total_personas MOD 30) YEAR);

        -- Insertar la nueva persona
        INSERT INTO donaton.bolichito (`nombre`, `fecha_nacimiento`) 
        VALUES (identificacion, fecha_nacimiento);

        -- Incrementar el contador
        SET total_personas = total_personas + 1;
    END WHILE;

	SELECT COUNT(*) INTO total_personas FROM bolichito;
    
    IF total_personas > MAX_PERSONAS  THEN
		ROLLBACK ;
		SELECT 'NO SE PUEDE INGRESAR ESTAS PERSONAS, SE LLENO EL BOLICHE';
	
    ELSE    
		SELECT 
			'NO SE HA LLENADO EL BOLICHE' AS msg,
			(MAX_PERSONAS - total_personas)  AS cupo_disponible
		;
		COMMIT;
	END IF;
END //

DELIMITER ;
