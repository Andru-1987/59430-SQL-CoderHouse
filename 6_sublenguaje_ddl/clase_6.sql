-- CLASE 6 
-- DATA DEFINITION LANGUAGE
-- SENTENCIAS PRINCIPALES
	-- CREATE
	-- ALTER
		-- ALTER MODIFY
		-- ALTER DROP
		-- ALTER RENAME
	-- DROP
	-- TRUNCATE

-- CREATE TABLE  LIKE
-- TRUNCATE TABLE

-- FUNCIONES ESCALARES MY
	-- FUNCIONES DE CADENA
	-- FUNCIONES NUMERICAS
	-- FUNCIONES DE FECHA
	-- FUNCIONES DE AGREGACION

-- < SAMPLES> --

### DATA DEFINITION LANGUAGE (DDL)

-- Crear una tabla
CREATE TABLE Empleados (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    edad INT,
    salario DECIMAL(10, 2)
);

-- Modificar la estructura de la tabla (añadir una columna)
ALTER TABLE Empleados
ADD COLUMN departamento VARCHAR(50);

-- Cambiar el nombre de la tabla
ALTER TABLE Empleados
RENAME TO Trabajadores;

-- Eliminar la tabla
DROP TABLE Trabajadores;

-- Vaciar la tabla (eliminar todos los registros)
TRUNCATE TABLE Empleados;


### CREATE TABLE LIKE


-- Crear una nueva tabla basada en la estructura de otra tabla existente
CREATE TABLE EmpleadosCopiados LIKE Empleados;


### TRUNCATE TABLE


-- Vaciar una tabla sin eliminar su estructura
TRUNCATE TABLE Empleados;


### FUNCIONES ESCALARES MY

#### FUNCIONES DE CADENA


-- Concatenar dos cadenas
SELECT CONCAT(nombre, ' ', apellido) AS nombre_completo FROM Empleados;

-- Convertir texto a mayúsculas
SELECT UPPER(nombre) AS nombre_mayusculas FROM Empleados;

-- Buscar y reemplazar parte de una cadena
SELECT REPLACE(descripcion, 'viejo', 'nuevo') AS nueva_descripcion FROM Productos;


#### FUNCIONES NUMÉRICAS


-- Calcular el promedio de los salarios
SELECT AVG(salario) AS salario_promedio FROM Empleados;

-- Redondear un número decimal
SELECT ROUND(salario, 2) AS salario_redondeado FROM Empleados;


#### FUNCIONES DE FECHA


-- Obtener la fecha y hora actual
SELECT NOW() AS fecha_actual;

-- Sumar 7 días a una fecha
SELECT DATE_ADD(fecha_inicio, INTERVAL 7 DAY) AS nueva_fecha_inicio FROM Proyectos;


#### FUNCIONES DE AGREGACIÓN


-- Calcular la suma de los salarios
SELECT SUM(salario) AS total_salarios FROM Empleados;

-- Contar el número de empleados por departamento
SELECT departamento, COUNT(*) AS num_empleados FROM Empleados GROUP BY departamento;


-- <SQL EJERCICITACION EN CLASE> --

*	concatena tu nombre completo (respetando los espacios)
	SELECT 
		CONCAT_WS(', ','ANDERSON', 'OCANA') AS NOMBRE_CONCATENADO
	FROM DUAL;

*	convierte tu nombre completo a minúsculas, luego a mayúsculas

	SELECT
	    LOWER(CONCAT_WS(', ','ANDERSON', 'OCANA')) AS LOWER_NAME
	,	UPPER(CONCAT_WS(', ','ANDERSON', 'OCANA')) AS UPPER_NAME
	FROM DUAL;


*	Divide tu año de nacimiento por tu día y mes (ej: 1975 / 2103)
	SELECT
		YEAR(CUMPLE) / 
		CAST(
			CONCAT( DAY(CUMPLE) , MONTH(CUMPLE) ) AS UNSIGNED
		) AS DIVISION_DIA_MES

	FROM ( SELECT CAST('1987-10-19' AS DATE) AS CUMPLE FROM DUAL) AS CUMPLE
	;


*	Convierte en un entero absoluto el resultado anterior

	SELECT
	    ABS(YEAR(CUMPLE) / CAST(CONCAT(DAY(CUMPLE), MONTH(CUMPLE)) AS UNSIGNED)) AS AbsoluteValue
	FROM (
	    SELECT CAST('1987-10-19' AS DATE) AS CUMPLE FROM DUAL
	) AS CUMPLE;


*	Calcula los días que pasaron desde tu nacimiento hasta hoy
	-- SET VARIABLES
	SET @FECHA_NACIMIENTO='1987-10-19';

	SELECT CONCAT(DATEDIFF(NOW(), @FECHA_NACIMIENTO),' DIAS')  AS DIAS_DIFF_NACIMIENTO;

*	Averiguar qué día de semana era cuando naciste

	SELECT 
			DAYNAME(@fecha_nacimiento) AS DiaDeLaSemana
		,	CASE DAYNAME(@fecha_nacimiento)
           		WHEN 'Monday' THEN 'Lunes'
           		WHEN 'Tuesday' THEN 'Martes'
           		WHEN 'Wednesday' THEN 'Miércoles'
           		WHEN 'Thursday' THEN 'Jueves'
           		WHEN 'Friday' THEN 'Viernes'
           		WHEN 'Saturday' THEN 'Sábado'
           		WHEN 'Sunday' THEN 'Domingo'
       		END AS DiaDeLaSemanaEnEspañol
    FROM DUAL
    ;