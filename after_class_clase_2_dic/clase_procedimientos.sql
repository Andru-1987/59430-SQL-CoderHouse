DROP DATABASE IF EXISTS mauro_test;
CREATE DATABASE mauro_test;

USE mauro_test;

-- 10 empleados
CREATE TABLE mauro_test.empleados(
    id_empleado INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(200)

);

INSERT INTO mauro_test.empleados (email)
VALUES
    ('empleado1@example.com'),
    ('empleado2@example.com'),
    ('empleado3@example.com'),
    ('empleado4@example.com'),
    ('empleado5@example.com'),
    ('empleado6@example.com'),
    ('empleado7@example.com'),
    ('empleado8@example.com'),
    ('empleado9@example.com'),
    ('empleado10@example.com');

-- 
CREATE TABLE mauro_test.stage_empleados_no_presentes(
    fecha DATE DEFAULT(CURRENT_DATE),
    empleado_id INT NOT NULL,
    motivo TEXT,
    PRIMARY KEY(fecha,empleado_id),
    FOREIGN KEY (empleado_id) REFERENCES mauro_test.empleados(id_empleado)
);

INSERT INTO mauro_test.stage_empleados_no_presentes (fecha, empleado_id, motivo)
VALUES
    -- Fecha 1: Dos empleados
    ('2024-12-01', 1, 'Motivo: Enfermedad'),
    ('2024-12-01', 2, 'Motivo: Emergencia familiar'),

    -- Fecha 2: Cuatro empleados
    ('2024-12-04', 3, 'Motivo: Retraso en el transporte'),
    ('2024-12-04', 4, 'Motivo: Licencia programada'),
    ('2024-12-04', 5, 'Motivo: Asunto personal'),
    ('2024-12-04', 6, 'Motivo: Viaje de trabajo'),

    -- Fecha 3: Dos empleados
    ('2024-12-03', 7, 'Motivo: Reunión externa'),
    ('2024-12-03', 8, 'Motivo: Día libre');


--  PROCEDIMIENTO DE
DELIMITER //

DROP PROCEDURE IF EXISTS mauro_test.sp_ingesta_presentismo //
CREATE PROCEDURE mauro_test.sp_ingesta_presentismo(IN periodo_asistencia DATE)
BEGIN

    DELETE FROM mauro_test.asistencia
        WHERE fecha = periodo_asistencia;


    INSERT INTO mauro_test.asistencia(
        fecha , empleado_id , status
    ) SELECT
        periodo_asistencia,
        a.id_empleado,
        (np.empleado_id IS NULL)
        
        FROM mauro_test.empleados AS a
		LEFT JOIN 
        (SELECT empleado_id
        FROM mauro_test.stage_empleados_no_presentes 
			WHERE fecha = periodo_asistencia) AS np
        
            ON a.id_empleado = np.empleado_id ;
		
END //

DELIMITER ;




-- todos los dias se debe tomar la asistencia
CREATE TABLE mauro_test.asistencia(
    fecha DATE DEFAULT(CURRENT_DATE),
    empleado_id INT,
    status BOOLEAN,
    PRIMARY KEY(fecha,empleado_id),
    FOREIGN KEY (empleado_id) REFERENCES mauro_test.empleados(id_empleado)
);


-- EVENTO QUE SE CORRE TODOS LOS DIAS
CREATE EVENT presentismo
    ON SCHEDULE
      EVERY 1 DAY
    COMMENT 'PASA EL PRESENTISMO DIARIO'
    DO
		CALL mauro_test.sp_ingesta_presentismo( CURRENT_DATE());


-- INGESTA DE HOY
CALL mauro_test.sp_ingesta_presentismo(CURRENT_DATE());

--  CUANDO LO QUERES HACER MANUAL
CALL mauro_test.sp_ingesta_presentismo('2024-12-01');