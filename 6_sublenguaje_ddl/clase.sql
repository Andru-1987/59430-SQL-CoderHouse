DROP DATABASE 
	IF EXISTS 
	ddl_class;
    
    
CREATE DATABASE ddl_class;
USE ddl_class ;


-- CREACION DE TABLAS
/*
id_area PK
nombre
turnos
lugar
*/

CREATE TABLE ddl_class.area(
	id_area INT NOT NULL AUTO_INCREMENT 
,   nombre VARCHAR(200)
,   turnos ENUM ('day','afternoon','night') DEFAULT 'day'
,   lugar VARCHAR(254)
-- DEFINICION DE PK
,	PRIMARY KEY(id_area )
) COMMENT = 'TABLA ENCARGADA DE ALMACENAR AREAS DEL TRABAJO' ;


DESCRIBE ddl_class.area;
SHOW CREATE TABLE ddl_class.area;
/*
CREATE TABLE `area` (
   `id_area` int NOT NULL AUTO_INCREMENT,
   `nombre` varchar(200) DEFAULT NULL,
   `turnos` enum('day','afternoon','night') DEFAULT 'day',
   `lugar` varchar(254) DEFAULT NULL,
   PRIMARY KEY (`id_area`)
 ) ENGINE=InnoDB 
 DEFAULT CHARSET=utf8mb4 
 COLLATE=utf8mb4_0900_ai_ci 
 COMMENT='TABLA ENCARGADA DE ALMACENAR AREAS DEL TRABAJO';
*/ 
 
-- MOSTRART META DATA DE LA TABLA
SELECT * 
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE table_schema='ddl_class' 
        AND table_name='area';

-- ALTERACION DE UNA TABLA

ALTER TABLE ddl_class.area
	MODIFY COLUMN turnos ENUM('day','afternoon','night','death-time') DEFAULT 'night';

ALTER TABLE ddl_class.area
	ADD COLUMN pepito INT;
    
ALTER TABLE ddl_class.area
	DROP COLUMN pepito;


/* categoria_empleado
	id_categoria
	nombre_categoria
	sueldo
*/

CREATE TABLE ddl_class.categoria_empleado (
	id_categoria INT NOT NULL AUTO_INCREMENT
,	nombre_categoria VARCHAR(200) NOT NULL DEFAULT 'cocina'
,	sueldo DECIMAL(8,2) DEFAULT 500000.01
,	PRIMARY KEY(id_categoria)
) COMMENT='TABLA DE CATEGORIA DE EMPLEADOS' ;





/*
	id_empleado
	dni
	nombre
	apellido
	nombre_full
	fecha_nacimiento
	id_area  FK
	id_categoria FK
*/

CREATE TABLE ddl_class.empleado(
	
	id_empleado INT NOT NULL AUTO_INCREMENT
,	dni VARCHAR(8)
,	dni_calculado BIGINT AS (CAST(dni AS UNSIGNED))
,	nombre VARCHAR(254)
,	apellido VARCHAR(254)
,	nombre_full VARCHAR(254) AS (CONCAT(nombre,' ',apellido))
,	fecha_nacimiento DATE
,	id_area  INT
, 	id_categoria INT
,	PRIMARY KEY(id_empleado)
,	FOREIGN KEY(id_area) REFERENCES ddl_class.area(id_area)
,	FOREIGN KEY(id_categoria) REFERENCES ddl_class.categoria_empleado(id_categoria)
) COMMENT='TABLA DE EMPLEADOS DIMENSIONALES';


-- OTRA PERSPECTIVA

CREATE TABLE ddl_class.empleado(
	id_empleado INT NOT NULL AUTO_INCREMENT
,	dni VARCHAR(8)
,	dni_calculado BIGINT AS (CAST(dni AS UNSIGNED))
,	nombre VARCHAR(254)
,	apellido VARCHAR(254)
,	nombre_full VARCHAR(254) AS (CONCAT(nombre,' ',apellido))
,	fecha_nacimiento DATE
,	id_area  INT
, 	id_categoria INT
,	PRIMARY KEY(id_empleado)
) COMMENT='TABLA DE EMPLEADOS DIMENSIONALES';


CREATE TABLE ddl_class.area(
	id_area INT NOT NULL AUTO_INCREMENT 
,   nombre VARCHAR(200)
,   turnos ENUM ('day','afternoon','night') DEFAULT 'day'
,   lugar VARCHAR(254)
-- DEFINICION DE PK
,	PRIMARY KEY(id_area )
) COMMENT = 'TABLA ENCARGADA DE ALMACENAR AREAS DEL TRABAJO' ;


CREATE TABLE ddl_class.categoria_empleado (
	id_categoria INT NOT NULL AUTO_INCREMENT
,	nombre_categoria VARCHAR(200) NOT NULL DEFAULT 'cocina'
,	sueldo DECIMAL(8,2) DEFAULT 500000.01
,	PRIMARY KEY(id_categoria)
) COMMENT='TABLA DE CATEGORIA DE EMPLEADOS' ;


ALTER TABLE ddl_class.empleado
	ADD CONSTRAINT fk_empleado_area
    FOREIGN KEY(id_area) REFERENCES ddl_class.area(id_area);
    
ALTER TABLE ddl_class.empleado
	ADD CONSTRAINT fk_empleado_categoria
    FOREIGN KEY(id_categoria) REFERENCES ddl_class.categoria_empleado(id_categoria);



DROP TABLE 
	ddl_class.categoria_empleado;
    
CREATE TABLE ddl_class.empleado_bk
	LIKE ddl_class.empleado;


-- CREAR UNA BASE DE DATOS DE MINIMO 3 ENTIDADES Y LEVANTARLO


SELECT CURDATE() 
FROM DUAL; -- ORACLE

SELECT DATEDIFF('2021-10-10','2024-10-10')
FROM DUAL; -- ORACLE


SELECT DATE_ADD(NOW(), INTERVAL 2 YEAR) AS dos_year_later
FROM DUAL; -- ORACLE


