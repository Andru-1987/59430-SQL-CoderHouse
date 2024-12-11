-- CREACION DE UN DATAMART EN BASE A DATATON

DROP DATABASE IF EXISTS audiencia;
DROP DATABASE IF EXISTS voluntarios;
DROP DATABASE IF EXISTS etl_py;

CREATE DATABASE audiencia;
CREATE DATABASE voluntarios;
CREATE DATABASE etl_py;


-- PROCEDIMIENTO! -> STORED PROCEDURE

CREATE TABLE IF NOT EXISTS audiencia.donaciones_mensuales(
    periodo VARCHAR(10),
    total_donaciones INT,
    monto_total DECIMAL(10,2),
    promedio_donacion DECIMAL(10,2)
);


DELIMITER //
DROP PROCEDURE IF EXISTS audiencia.sp_donaciones_por_periodo //

CREATE PROCEDURE audiencia.sp_donaciones_por_periodo(fecha_donacion)
BEGIN

-- INGESTA O CARGA EN UNA BASE O DATAMART ESPECIFICO
INSERT INTO audiencia.donaciones_mensuales
SELECT 
    -- EXTRACCION DE DATA
    -- AGRUPANDO Y GENERANDO TRANSFORMACION DE LA DATA CRUDA
    DATE_FORMAT(fecha_donacion, '%Y-%m') as periodo,
    COUNT(1) as total_donaciones,
    SUM(cantidad) as monto_total,
    AVG(cantidad) as promedio_donacion
FROM donaton.donacion
GROUP BY
    DATE_FORMAT(fecha_donacion, '%Y-%m');
END //

DELIMITER ;

