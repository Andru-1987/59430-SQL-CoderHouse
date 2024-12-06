USE donaton;


DELIMITER //
DROP PROCEDURE IF EXISTS donaton.sp_ingestar_donacion //
CREATE PROCEDURE donaton.sp_ingestar_donacion
(
    IN _id_donador INT,
    IN _id_categoria_donacion INT,
    IN _id_centro_recepcion INT,
    IN _cantidad DECIMAL(10,2),
    IN _detalles VARCHAR(200),
    IN periodo DATE 
 ) -- 2024- 10- 01
BEGIN
    START TRANSACTION;

    INSERT INTO donaton.donacion 
    (id_donador, id_categoria_donacion, id_centro_recepcion, cantidad, detalles, fecha_termino_donacion) 
    VALUES
    (
        _id_donador
    ,   _id_categoria_donacion
    ,   _id_centro_recepcion
    ,   _cantidad
    ,   _detalles
    ,   periodo);

    SELECT * FROM  donaton.donacion
    ORDER BY id_donacion DESC;


    IF periodo > '2060-01-01' THEN
        SELECT 'Chango -> la fecha esta mal o hay algo turbio' AS mensaje;
        ROLLBACK;

    ELSE 
        SELECT 'Felicitaciones por la donacion, gracias coderhouse :) ' AS mensaje;
        COMMIT;
    END IF;
    
    SELECT * FROM  donaton.donacion
    ORDER BY id_donacion DESC;


END //

DELIMITER ;


CALL donaton.sp_ingestar_donacion(5, 4, 4, 900.00, 'Donacion que esta todo bien', '2024-08-01');
CALL donaton.sp_ingestar_donacion(5, 4, 4, 900.00, 'Me huele a donacion politica', '2100-08-01');