DELIMITER //

-- Procedure 1: Validation of existence
DROP PROCEDURE IF EXISTS procedures.sp_validacion //
CREATE PROCEDURE procedures.sp_validacion(
    IN _name VARCHAR(100),
    IN _last_name VARCHAR(200),
    IN _email VARCHAR(200),
    IN _pais VARCHAR(30),
    IN _ciudad VARCHAR(30),
    INOUT existencia_usuario INT,
    INOUT existencia_pais INT,
    INOUT existencia_ciudad INT
)
BEGIN
    SET existencia_usuario = 0;
    SET existencia_pais = 0;
    SET existencia_ciudad = 0;

    -- Validate user existence
    SELECT id_system_user INTO existencia_usuario
    FROM coderhouse_gamers.SYSTEM_USER
    WHERE email = _email
        AND last_name = _last_name
        AND first_name = _name
    LIMIT 1;

    -- Validate city and country existence
    SELECT c.id_ciudad, p.id_pais INTO existencia_ciudad, existencia_pais
    FROM funciones.ciudad AS c
    INNER JOIN funciones.pais AS p USING(id_pais)
    WHERE c.nombre = _ciudad 
        AND p.nombre = _pais;
END //

-- Procedure 2: User Creation
DROP PROCEDURE IF EXISTS procedures.sp_ciudadano //
CREATE PROCEDURE procedures.sp_ciudadano(
    IN _name VARCHAR(100),
    IN _last_name VARCHAR(200),
    IN _email VARCHAR(200),
    INOUT existencia_usuario INT
)
BEGIN
    DECLARE id INT;

    IF existencia_usuario = 0 THEN
        SELECT id_system_user INTO id
        FROM coderhouse_gamers.SYSTEM_USER
        ORDER BY id_system_user DESC
        LIMIT 1;
        
        SET id = id + 1;
        
        INSERT INTO coderhouse_gamers.SYSTEM_USER
        VALUE(id, _name, _last_name, _email, "change_me!", 1);
        
        SET existencia_usuario = id;
    END IF;
END //

-- Procedure 3: City and Country Creation
DROP PROCEDURE IF EXISTS procedures.sp_pais //
CREATE PROCEDURE procedures.sp_pais(
    IN _pais VARCHAR(30),
    INOUT existencia_pais INT
)
BEGIN
    IF existencia_pais = 0 THEN

        SELECT _pais  AS pais;

        INSERT INTO funciones.pais (nombre)
        VALUE(_pais);

        SELECT LAST_INSERT_ID() INTO existencia_pais;
    END IF;
    

END //

-- Procedure 3: City and Country Creation
DROP PROCEDURE IF EXISTS procedures.sp_ciudad //
CREATE PROCEDURE procedures.sp_ciudad(
    IN _ciudad VARCHAR(30),
    INOUT existencia_ciudad INT,
    INOUT existencia_pais INT
)
BEGIN

    IF existencia_ciudad = 0 THEN

        SELECT _ciudad AS ciudad;

        INSERT INTO funciones.ciudad (nombre, id_pais)
        VALUE(_ciudad, existencia_pais);
        
        SELECT LAST_INSERT_ID() INTO existencia_ciudad;
    END IF;

END //





-- Procedure 4: User Data Loading
DROP PROCEDURE IF EXISTS procedures.load_user //
CREATE PROCEDURE procedures.load_user(
    INOUT existencia_usuario INT,
    INOUT existencia_ciudad INT
)
BEGIN
    INSERT INTO `procedures`.`usuarios_nuevos_productiva` 
        (first_name, last_name, email, ciudad)
    SELECT
        s.first_name,
        s.last_name,
        s.email,
        c.nombre
    FROM coderhouse_gamers.SYSTEM_USER AS s,
         funciones.ciudad AS c
    WHERE id_system_user = existencia_usuario
        AND c.id_ciudad = existencia_ciudad;
END //

-- Main Procedure
DROP PROCEDURE IF EXISTS procedures.main_proc //
CREATE PROCEDURE procedures.main_proc(
    IN _name VARCHAR(100),
    IN _last_name VARCHAR(200),
    IN _email VARCHAR(200),
    IN _pais VARCHAR(30),
    IN _ciudad VARCHAR(30),
    INOUT existencia_usuario INT,
    INOUT existencia_pais INT,
    INOUT existencia_ciudad INT
)
BEGIN 
    CALL procedures.sp_validacion(
        _name,
        _last_name,
        _email,
        _pais,
        _ciudad,
        @existencia_usuario,
        @existencia_ciudad,
        @existencia_pais
    );
    
    SELECT 
        @existencia_usuario AS existencia_usuario,
        @existencia_ciudad AS existencia_ciudad,
        @existencia_pais  AS existencia_pais;

    CALL procedures.sp_pais(
        _pais,
        @existencia_pais
  
    );


    CALL procedures.sp_ciudad(
        _ciudad,
        @existencia_ciudad,
        @existencia_pais
    );


    SELECT 
        @existencia_ciudad AS existencia_ciudad,
        @existencia_pais AS existencia_pais;

    CALL procedures.sp_ciudadano(
        _name,
        _last_name,
        _email,
        @existencia_usuario
    );
    
    SELECT @existencia_usuario AS existencia_usuario;
    
    CALL procedures.load_user(
        @existencia_usuario,
        @existencia_ciudad
    );
END //

DELIMITER ;

-- Example Usage
SET @existencia_usuario = 0;
SET @existencia_ciudad = 0;
SET @existencia_pais = 0;

CALL procedures.main_proc(
    'Jorge',
    'Amancio',
    'mail@mail.com',
    'Francia',
    'París',
    @existencia_usuario,
    @existencia_ciudad,
    @existencia_pais
);

-- Check Results
SELECT 
    @existencia_usuario AS existencia_usuario,
    @existencia_ciudad AS existencia_ciudad,
    @existencia_pais AS existencia_pais;