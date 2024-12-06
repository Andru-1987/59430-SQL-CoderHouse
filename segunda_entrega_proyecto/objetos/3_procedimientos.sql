USE donaton;


-- PROCEDIMIENTO QUE ME REPORTE DONDE PUEDA VER LOS NUEVOS DONADORES DE ESA FECHA.

DELIMITER //
DROP PROCEDURE IF EXISTS donaton.sp_donadores_segun_fecha //
CREATE PROCEDURE donaton.sp_donadores_segun_fecha(IN periodo DATE ) -- 2024- 10- 01
BEGIN

    -- validar que existan donadores en esa temporada
    DECLARE existen_donadores BOOLEAN DEFAULT FALSE;
    SELECT 

        COUNT(1) > 0  INTO existen_donadores
    FROM donaton.donacion
    WHERE fecha_donacion BETWEEN periodo AND DATE_ADD(periodo, INTERVAL 1 MONTH);

    IF existen_donadores THEN
        DROP TABLE IF EXISTS donaton.donadores_fecha;

        SELECT 'Se generara la tabla';

        CREATE TABLE donaton.donadores_fecha
            AS
            SELECT  nombre,
                    total_donaciones,
                    periodo AS fecha_muestreo,
                    DATE_ADD(periodo, INTERVAL 1 MONTH) AS fecha_cierre
            FROM (
                SELECT 
                    do.nombre,
                    COUNT(1) AS total_donaciones
                FROM donaton.donador AS do
                LEFT JOIN donaton.donacion AS don
                    USING(id_donador)
                WHERE don.fecha_donacion BETWEEN periodo AND DATE_ADD(periodo, INTERVAL 1 MONTH)
                GROUP BY id_donador) AS data_proc;


        ELSE
        -- Mensaje si no hay donadores en el período
        SELECT CONCAT('No se encontraron donaciones para el período: ', 
                     DATE_FORMAT(periodo, '%Y-%m-%d'), 
                     ' al ', 
                     DATE_FORMAT(DATE_ADD(periodo, INTERVAL 1 MONTH), '%Y-%m-%d')) 
        AS mensaje;

    END IF;
        

END //

DELIMITER ;



CALL donaton.sp_donadores_segun_fecha('1998-10-03');

