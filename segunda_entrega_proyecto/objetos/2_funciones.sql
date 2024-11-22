USE donaton;

-- GENERAR UNA FUNCION QUE ME PERMITA VALIDAR SI EL VOLUNTARIO ES MAYOR A 18


DELIMITER //
DROP FUNCTION IF EXISTS donaton.fx_mayor_edad //

CREATE FUNCTION donaton.fx_mayor_edad( dob DATE )
	RETURNS BOOLEAN
	READS SQL DATA
BEGIN
	RETURN (DATEDIFF( current_date (), dob ) / 365 ) > 18;
END //

DELIMITER ;


SELECT 
    v.*,
    fx_mayor_edad(v.fecha_nacimiento) AS es_mayor_edad
FROM 
    donaton.voluntario    AS v

