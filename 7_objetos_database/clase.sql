-- Crear la base de datos
DROP DATABASE IF EXISTS CLASE7;
CREATE DATABASE CLASE7;

USE CLASE7;


-- [troops] 1 -- *[ friends]

-- Crear la tabla TROOP
CREATE TABLE TROOP (
	ID INT NOT NULL AUTO_INCREMENT,
	DESCRIPCION VARCHAR(100),

	PRIMARY KEY (ID)
);

-- Crear la tabla FRIENDS
CREATE TABLE FRIENDS (
	ID INT NOT NULL AUTO_INCREMENT,
	FIRST_NAME VARCHAR(50),
	LAST_NAME VARCHAR(50),
	TROOP INT,-- FK

	PRIMARY KEY(ID)
);

-- Agregar la restricción de clave externa usando ALTER TABLE
ALTER TABLE FRIENDS
ADD CONSTRAINT fk_troop_id
FOREIGN KEY (TROOP) REFERENCES TROOP(ID);



-- INSERCION DE 20 REGISTROS PARA FRIENDS 
-- INSERCION DE 5 REGISTROSS PARA TROOPS

-- Insertar registros en la tabla TROOP
INSERT INTO TROOP (DESCRIPCION)
VALUES
    ('Troop Air'),
    ('Troop Attack'),
    ('Troop Naive'),
    ('Troop Ground'),
    ('Troop War');

-- Insertar registros en la tabla FRIENDS
-- Insertar 10 registros con TROOP = 1
INSERT INTO FRIENDS (FIRST_NAME, LAST_NAME, TROOP)
VALUES
    ('John', 'Doe', 1),
    ('Jane', 'Smith', 1),
    ('Alice', 'Johnson', 1),
    ('Bob', 'Williams', 1),
    ('William', 'Garcia', 1),
    ('Sophia', 'Lopez', 1),
    ('Ethan', 'Adams', 1),
    ('Charlotte', 'Rivera', 1),
    ('Daniel', 'King', 1),
    ('David', 'Evans', 1);

-- Insertar 10 registros con TROOP = 2
INSERT INTO FRIENDS (FIRST_NAME, LAST_NAME, TROOP)
VALUES
    ('Michael', 'Brown', 2),
    ('Olivia', 'Martinez', 2),
    ('Alexander', 'Scott', 2),
    ('Mia', 'Baker', 2),
    ('Matthew', 'Hall', 2),
    ('Liam', 'Wright', 2),
    ('Jane', 'Smith', 2),
    ('Michael', 'Brown', 2),
    ('Olivia', 'Martinez', 2),
    ('Alexander', 'Scott', 2);

-- Insertar 10 registros con TROOP = 3
INSERT INTO FRIENDS (FIRST_NAME, LAST_NAME, TROOP)
VALUES
    ('Emma', 'Jones', 3),
    ('James', 'Hernandez', 3),
    ('Ava', 'Green', 3),
    ('Amelia', 'Lee', 3),
    ('Emma', 'Jones', 3),
    ('James', 'Hernandez', 3),
    ('Ava', 'Green', 3),
    ('Amelia', 'Lee', 3),
    ('Jane', 'Smith', 3),
    ('Michael', 'Brown', 3);

-- Insertar 20 registros con TROOP = NULL
INSERT INTO FRIENDS (FIRST_NAME, LAST_NAME, TROOP)
VALUES
    ('John', 'Doe', NULL),
    ('Jane', 'Smith', NULL),
    ('Alice', 'Johnson', NULL),
    ('Bob', 'Williams', NULL),
    ('William', 'Garcia', NULL),
    ('Sophia', 'Lopez', NULL),
    ('Ethan', 'Adams', NULL),
    ('Charlotte', 'Rivera', NULL),
    ('Daniel', 'King', NULL),
    ('David', 'Evans', NULL),
    ('Michael', 'Brown', NULL),
    ('Olivia', 'Martinez', NULL),
    ('Alexander', 'Scott', NULL),
    ('Mia', 'Baker', NULL),
    ('Matthew', 'Hall', NULL),
    ('Liam', 'Wright', NULL),
    ('Emma', 'Jones', NULL),
    ('James', 'Hernandez', NULL),
    ('Ava', 'Green', NULL),
    ('Amelia', 'Lee', NULL);

-- VISTAS 

-- EJEMPLO DE UNA VISTA EN MYSQL

-- ENCABEZADO DE CREACION
CREATE VIEW VW_FRIEND AS
	-- CUERPO O QUERY DE LA CREACION DE LA VIEW
	SELECT	F.*
		,	COALESCE(
				T.DESCRIPCION
			,	'TROOP NO DETERMINADA ^.^'		
			) AS DESCRIPCION
	FROM FRIENDS AS F
	LEFT JOIN TROOP AS T
	ON F.TROOP =  T.ID
	WHERE	TRUE
	AND F.LAST_NAME LIKE 'D%' ;



INSERT INTO FRIENDS (FIRST_NAME, LAST_NAME, TROOP)
VALUES
    ('JACK', 'DANIELS', NULL);
    
SELECT 
	*
FROM VW_FRIEND;

-- 
-- > NOMBRE , APELLDIO , 'SOY: NOMBRE, APELLIDO'
DROP FUNCTION IF EXISTS func_concat ; 
DELIMITER //
CREATE FUNCTION func_concat
( 		EXTRA_VALUE VARCHAR(20)
	,	SEP_CHAR VARCHAR(10)
	, 	NAME VARCHAR(100) 
	,	LAST_NAME VARCHAR(100)
) RETURNS VARCHAR(255)
DETERMINISTIC
	BEGIN
		SET @total = CONCAT_WS(
				SEP_CHAR
			,	EXTRA_VALUE
			,	NAME
			,	LAST_NAME
		) ;
		RETURN @total;
	END//
DELIMITER ;   


-- USABILIDAD
CREATE VIEW VW_DATA_CONCAT_FIRE AS
SELECT func_concat(
	CONCAT ('usuario # ' , F.ID ,  ' :')
,	' '
,	F.FIRST_NAME 
,	F.LAST_NAME 
) AS concatenacion ,
T.DESCRIPCION
FROM CLASE7.FRIENDS AS F
JOIN CLASE7.TROOP AS T ON F.TROOP = T.ID;


SELECT * FROM CLASE7.VW_DATA_CONCAT_FIRE;



DELIMITER //

CREATE TRIGGER before_insert_trigger
BEFORE INSERT ON TROOP
FOR EACH ROW
BEGIN
    -- Realizar alguna acción, como validar los datos antes de la inserción
    IF NEW.DESCRIPCION NOT LIKE 'TROOP %' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'NO SE PERMITEN NOMBRES DE TROOPS VACIAS';
    END IF;
END//

DELIMITER ;



INSERT INTO TROOP
	(DESCRIPCION)
	VALUES
	('NO VA A FUNCIONAR');	

INSERT INTO TROOP
	(DESCRIPCION)
	VALUES
	('TROOP SI VA A FUNCIONAR');
	
SELECT *
FROM TROOP;




SHOW CREATE TRIGGER before_insert_trigger;





-- EJEMPLO
DELIMITER //

CREATE PROCEDURE InsertFriendWithTroop (
    IN p_first_name VARCHAR(50),
    IN p_last_name VARCHAR(50),
    IN p_troop_id INT
)
BEGIN
    DECLARE troop_count INT;

    -- Verificar si existe una tropa con el ID proporcionado
    SELECT COUNT(*) INTO troop_count FROM TROOP WHERE ID = p_troop_id;

    IF troop_count > 0 THEN
        -- Insertar el amigo en la tabla FRIENDS
        INSERT INTO FRIENDS (FIRST_NAME, LAST_NAME, TROOP)
        VALUES (p_first_name, p_last_name, p_troop_id);
    ELSE
        -- Mostrar un mensaje de advertencia si no hay una tropa disponible
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se puede insertar el amigo porque no existe una tropa con el ID proporcionado.';
    END IF;
END//

DELIMITER ;



CALL InsertFriendWithTroop('Nico','Bueti', 2);
CALL InsertFriendWithTroop('Dario','Ponce', 10);
