-- DROP TRIGGER IF EXISTS nombre_trigger;

-- CREATE
--     TRIGGER trigger_name
--     trigger_time trigger_event
--     ON tbl_name FOR EACH ROW

--     trigger_body

-- trigger_time: { BEFORE | AFTER }
-- trigger_event: { INSERT | UPDATE | DELETE }

-- triggers -> validador  -> checkers

USE coderhouse_gamers;

-- validacion

-- validar ciertas propiedades del password


-- TRIGGERS DE VALIDACION

DELIMITER //

DROP TRIGGER IF EXISTS coderhouse_gamers.trigger_bi_pwd //

CREATE
    TRIGGER coderhouse_gamers.trigger_bi_pwd 
    BEFORE INSERT 
    ON coderhouse_gamers.SYSTEM_USER FOR EACH ROW
BEGIN
    SET @msg = "Minimum eight characters, at least one letter and one number";

    IF  NOT REGEXP_LIKE(NEW.password,"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$") THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @msg;
    END IF;

END //

-- 

-- EJEMPLO DE QUE NO SE PERMITE RECURSIVIDAD DE MODIFICACION POR MEDIO DE UN TRIGGER
DROP TRIGGER IF EXISTS coderhouse_gamers.trigger_au_pwd //

CREATE
    TRIGGER coderhouse_gamers.trigger_au_pwd
    AFTER UPDATE
    ON coderhouse_gamers.SYSTEM_USER FOR EACH ROW
BEGIN

-- NO ESTA PERMITIDO
    SET @default_value = "NO DECLARADO";

    IF NEW.last_name = '' THEN
        
        UPDATE coderhouse_gamers.SYSTEM_USER (last_name)
            SET last_name = @default_value 
        WHERE
            id_system_user = OLD.id_system_user;

    END IF;

END //

DELIMITER ;







INSERT INTO `coderhouse_gamers`.`SYSTEM_USER`
(
`id_system_user`,
`first_name`,
`last_name`,
`email`,
`password`,
`id_user_type`)
VALUES
(200,"pirulo","tomtom","pirulo@mail.com", "HolaMundo71" ,1);


UPDATE `coderhouse_gamers`.`SYSTEM_USER`
	SET first_name = "Jose" , last_name = ''
    WHERE id_system_user = 1400;


-- TRIGGERS PARA AUDITORIA

CREATE TABLE 
    `coderhouse_gamers`.`SYSTEM_USER_PRODUCTIVA`
(
  `id_system_user` INT NOT NULL PRIMARY KEY
, `first_name`  VARCHAR(200)
, `last_name` VARCHAR(200)
, `email` VARCHAR(200)
, `password` VARCHAR(200)
, `id_user_type` INT 
, `fecha_modificacion` DATETIME DEFAULT(CURRENT_TIMESTAMP)
, `usuario_modificador` VARCHAR(200)
);


ALTER TABLE 
    `coderhouse_gamers`.`SYSTEM_USER_PRODUCTIVA`
    ADD COLUMN reason_to_delete VARCHAR(200) DEFAULT 'NO INFO';

ALTER TABLE 
    `coderhouse_gamers`.`SYSTEM_USER_PRODUCTIVA`
    DROP PRIMARY KEY;



DELIMITER //

DROP TRIGGER IF EXISTS coderhouse_gamers.trigger_au_pwd //

CREATE
    TRIGGER coderhouse_gamers.trigger_au_pwd
    AFTER UPDATE
    ON coderhouse_gamers.SYSTEM_USER FOR EACH ROW
BEGIN

-- NO ESTA PERMITIDO
    SET @default_value = "NO DECLARADO";

    IF NEW.last_name = '' THEN
        
        INSERT coderhouse_gamers.SYSTEM_USER_PRODUCTIVA 
        (
            id_system_user,
            first_name,
            last_name,
            email,
            password,
            id_user_type,
            fecha_modificacion,
            usuario_modificador
        )
        VALUES
        (
          NEW.`id_system_user`
        , NEW.`first_name`
        , @default_value
        , NEW.`email`
        , NEW.`password`
        , NEW.`id_user_type`
        , DEFAULT
        , USER()
        );

    END IF;

END //

DELIMITER ;






DELIMITER //

DROP TRIGGER IF EXISTS coderhouse_gamers.trigger_ad_user //

CREATE
    TRIGGER coderhouse_gamers.trigger_ad_user
    AFTER DELETE
    ON coderhouse_gamers.SYSTEM_USER FOR EACH ROW
BEGIN

-- NO ESTA PERMITIDO
    
    SET @reason_to_delete = "BORRADO POR NO PAGO SUSCRIPCION" ;

    INSERT coderhouse_gamers.SYSTEM_USER_PRODUCTIVA 
    VALUES
    (
      OLD.`id_system_user`
    , OLD.`first_name`
    , OLD.`last_name`
    , OLD.`email`
    , OLD.`password`
    , OLD.`id_user_type`
    , DEFAULT
    , USER()
    , @reason_to_delete
    );

END //

DELIMITER ;



DELETE FROM  `coderhouse_gamers`.`SYSTEM_USER`
WHERE id_system_user = 1400;






--- 


-- TABLAS REPLICAS

CREATE TABLE coderhouse_gamers.SYSTEM_USER_REPLICA AS 
    SELECT * FROM `coderhouse_gamers`.`SYSTEM_USER`;


DELIMITER //
DROP TRIGGER IF EXISTS coderhouse_gamers.ai_tabla_replica //
CREATE TRIGGER coderhouse_gamers.ai_tabla_replica
    AFTER INSERT
    ON coderhouse_gamers.SYSTEM_USER FOR EACH ROW
BEGIN
    INSERT INTO
        coderhouse_gamers.SYSTEM_USER_REPLICA
    VALUES
        (
    NEW.`id_system_user`
    , NEW.`first_name`
    , NEW.`last_name`
    , NEW.`email`
    , NEW.`password`
    , NEW.`id_user_type`
    );

END //

DROP TRIGGER IF EXISTS coderhouse_gamers.au_tabla_replica //
CREATE TRIGGER coderhouse_gamers.au_tabla_replica
    AFTER UPDATE
    ON coderhouse_gamers.SYSTEM_USER FOR EACH ROW
    FOLLOWS trigger_au_pwd
BEGIN
    UPDATE coderhouse_gamers.SYSTEM_USER_REPLICA
    SET 
        first_name = NEW.first_name,
        last_name = NEW.last_name,
        email = NEW.email,
        password = NEW.password,
        id_user_type = NEW.id_user_type
    WHERE id_system_user = NEW.id_system_user;

END //


DROP TRIGGER IF EXISTS coderhouse_gamers.ad_tabla_replica //
CREATE TRIGGER coderhouse_gamers.ad_tabla_replica
    AFTER DELETE
    ON coderhouse_gamers.SYSTEM_USER FOR EACH ROW
BEGIN

    DELETE FROM coderhouse_gamers.SYSTEM_USER_REPLICA
    WHERE id_system_user = OLD.id_system_user;

END //
