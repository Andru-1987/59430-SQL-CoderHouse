-- OBJETOS DE UNA BASE DE DATOS

-- TABLAS
	-- TIPOS DE CLAVES (KEYS)
	-- CREACION DE TABLAS: FRIENDS && TROOPS
	


/*

	DER SOBRE FRIENDS Y TROOP
	+---------------+           +---------------+
	|   FRIENDS     |           |     TROOP     |
	+---------------+           +---------------+
	| ID (PK)       | <------   | ID (PK)       |
	| FIRST_NAME    |           | DESCRIPCION   |
	| LAST_NAME     |           +---------------+
	| TROOP (FK)    |
	+---------------+
*/	

	-- Crear la base de datos
	DROP DATABASE IF EXISTS CLASE7;
	CREATE DATABASE CLASE7;

	USE CLASE7;

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


--	FORMAS NORMALES:
-- 		LINK : https://bookdown.org/paranedagarcia/database/normalizacion.html



-- VISTAS
-- Una vista en bases de datos es una consulta almacenada que se comporta como una tabla virtual. En lugar de almacenar datos físicamente, una vista es una representación lógica de los datos que se derivan de una o más tablas en la base de datos. Las vistas permiten a los usuarios o aplicaciones acceder y manipular datos de manera conveniente y segura, sin necesidad de conocer la estructura subyacente de las tablas o la complejidad de las consultas.

-- Aquí hay algunos aspectos clave sobre las vistas en bases de datos:

-- - **Definición Lógica**: Una vista define una consulta SQL que devuelve un conjunto de datos. Esta consulta se almacena en la base de datos y puede ser utilizada como una tabla en consultas posteriores.

-- - **No almacena datos físicamente**: A diferencia de las tablas tradicionales, las vistas no almacenan datos físicamente en disco. En cambio, los datos son generados dinámicamente cuando se realiza una consulta a la vista.

-- - **Seguridad y Abstracción**: Las vistas proporcionan una capa de abstracción sobre las tablas subyacentes, lo que puede mejorar la seguridad al limitar el acceso directo a las tablas base y permitir un control más preciso sobre los datos que pueden ser consultados o modificados por los usuarios.

-- - **Facilita la Simplificación de Consultas**: Las vistas pueden simplificar consultas complejas al encapsular lógica de negocio o consultas frecuentes en una única vista, que luego puede ser consultada de manera sencilla en lugar de repetir la misma lógica en múltiples consultas.

-- ### Tipos de Vistas:

-- 1. **Vistas Básicas**: Son vistas que están basadas en una única tabla o en la combinación de varias tablas mediante operaciones de JOIN.

-- 2. **Vistas Indexadas**: Son vistas que tienen un índice creado en la base de datos. Estos índices mejoran el rendimiento de las consultas a la vista, similar a como lo hacen los índices en las tablas.
-- 	-- NO LO SOPORTA MYSQL >> SE PUEDE EMULAR CREANDO INDICES

-- 3. **Vistas Materializadas**: Son vistas que almacenan físicamente los resultados de la consulta en disco, permitiendo un acceso más rápido a los datos. Estos resultados se actualizan periódicamente para reflejar los cambios en las tablas base.
-- 	--  NO LO SOPORTA  MYSQL >> SE PUEDE EMULAR CREANDO TABLAS TEMPORALES

-- 4. **Vistas Actualizables**: Son vistas que pueden ser utilizadas para realizar operaciones de inserción, actualización y eliminación de datos, siempre y cuando las reglas de actualización de la vista lo permitan y estén correctamente definidas.


-- EJEMPLO DE UNA VISTA EN MYSQL

-- ENCABEZADO DE CREACION
CREATE VIEW VW_FRIEND AS
	-- CUERPO O QUERY DE LA CREACION DE LA VIEW
	SELECT	F.*
		,	COALESCE(
				T.DESCRIPCION
			,	'TROPA NO DETERMINADA :s'		
			) AS DESCRIPCION
	FROM FRIENDS AS F
	LEFT JOIN TROOP AS T
	ON F.TROOP =  T.ID
	WHERE	TRUE
	AND F.LAST_NAME LIKE 'D%' ;


SELECT 
	*
FROM VW_FRIEND;



-- FUNCIONES EN MYSQL
-- Funciones en Bases de Datos

-- Las funciones en bases de datos son bloques de código reutilizables que realizan una tarea específica y devuelven un resultado. Estas funciones pueden aceptar parámetros de entrada, procesar datos y producir un resultado basado en la lógica definida dentro de la función. Las funciones son una característica fundamental en la mayoría de los sistemas de gestión de bases de datos (DBMS) y proporcionan una forma de modularizar y reutilizar la lógica de negocio dentro de la base de datos.

-- ### Características de las funciones:

-- 1. **Modularidad**: Las funciones permiten encapsular lógica de negocio compleja en unidades de código más pequeñas y manejables. Esto facilita el mantenimiento y la depuración del código, ya que la lógica se puede dividir en funciones más pequeñas y específicas.

-- 2. **Reutilización**: Una vez que se define una función, puede ser invocada en múltiples lugares dentro de la base de datos. Esto promueve la reutilización del código y evita la duplicación de lógica.

-- 3. **Parámetros de entrada y salida**: Las funciones pueden aceptar parámetros de entrada que se utilizan como datos de entrada para realizar cálculos o procesos. También pueden devolver valores como resultado de su ejecución.

-- 4. **Tipos de funciones**:
--    - **Funciones escalares**: Devuelven un solo valor basado en los parámetros de entrada.
--    - **Funciones de tabla**: Devuelven un conjunto de filas como resultado.  -- NO EN MYSQL
--    - **Funciones de agregado**: Realizan cálculos en un conjunto de valores y devuelven un solo valor resumido (por ejemplo, SUM, AVG, COUNT).
--    - **Funciones de ventana**: Realizan cálculos sobre un conjunto de filas relacionadas en una ventana definida. -- NO SE VERA EN ESTA COMISION, PERO LES RECOMIENDO VERLO

-- 5. **Lenguajes de programación**: Las funciones pueden estar escritas en diferentes lenguajes de programación, como SQL, PL/SQL (para Oracle), T-SQL (para SQL Server), PL/pgSQL (para PostgreSQL), etc. Estos lenguajes pueden incluir características avanzadas como bucles, condicionales y manejo de excepciones.

-- Las funciones son una parte integral de la mayoría de los sistemas de gestión de bases de datos y se utilizan ampliamente para implementar la lógica de negocio y realizar operaciones complejas en los datos almacenados en la base de datos.

-- LINK : https://www.mysqltutorial.org/mysql-functions/
-- LINK : https://dev.mysql.com/doc/refman/8.0/en/create-procedure.html



-- Crear la función
-- SEA EL CASO QUE TENGA CASO DE NECESIDAD DE REALIZAR UN TRUST EN EL CREADOR DE LA FUNCION
-- SET GLOBAL log_bin_trust_function_creators = 1;


DROP FUNCTION IF EXISTS func_concat ; 

DELIMITER //
CREATE FUNCTION IF NOT EXISTS func_concat
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


-- VERIFICAR LA CREACION DE LA FUNCION
SELECT ROUTINE_NAME
FROM INFORMATION_SCHEMA.ROUTINES
WHERE ROUTINE_TYPE = 'FUNCTION'
  AND ROUTINE_SCHEMA = 'CLASE7';


-- USABILIDAD
SELECT func_concat(
	CONCAT ('usuario # ' , ID ,  ' :')
,	' '
,	FIRST_NAME 
,	LAST_NAME 
) AS concatenacion
FROM CLASE7.FRIENDS;


-- PROCEDURES: 

-- TRIGGERS: ES UN OBJETO QUE SE DISPARA EN EVENTOS QUE SE PRODUCEN EN TABLAS RELACIONADAS A UNA BASE DE DATOS TALES COMO INSERT | UPDATE | DELETE
-- URL : https://www.mysqltutorial.org/mysql-triggers/

-- TRIGGER

## Triggers en Bases de Datos

Los triggers son objetos de base de datos que se activan automáticamente cuando ocurren ciertos eventos en la base de datos. Estos eventos pueden ser operaciones de manipulación de datos (INSERT, UPDATE, DELETE) en tablas específicas, o incluso cambios en la estructura de la base de datos. Los triggers se utilizan para realizar acciones automáticas en respuesta a estos eventos, lo que puede incluir la ejecución de código SQL o la llamada a funciones personalizadas.

### Funcionamiento de los Triggers:

- Los triggers se definen a nivel de base de datos y están asociados a tablas específicas.
- Se activan automáticamente cuando se ejecutan ciertos comandos SQL en la tabla asociada.
- Pueden ejecutar código SQL o llamar a funciones personalizadas.
- Los triggers pueden ser útiles para garantizar la integridad de los datos, auditar cambios, aplicar reglas de negocio y automatizar tareas repetitivas.

### Tipos de Triggers:

- **BEFORE Triggers**: Se ejecutan antes de que se realice la operación en la tabla. Pueden utilizarse para validar o modificar los datos antes de que se inserten, actualicen o eliminen.
  
- **AFTER Triggers**: Se ejecutan después de que se haya realizado la operación en la tabla. Se utilizan principalmente para realizar acciones posteriores a la operación, como auditoría de cambios o actualización de otras tablas.
  
- **INSTEAD OF Triggers**: Se utilizan principalmente en vistas y tablas virtuales. Permiten reemplazar la operación original con una nueva operación definida por el trigger. Por ejemplo, se pueden utilizar para permitir operaciones de escritura en una vista que normalmente sería de solo lectura.  -- NO SOPORTADO POR MYSQL



* VERIFICACION DE VALIDACION DE DATOS 

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



* CALCULO DE VALORES DE ATRIBUTOS PREVIOS A ALGUNA MANIPULACION DE DATOS

DELIMITER //

CREATE TRIGGER before_insert_trigger_troop_amount
BEFORE INSERT ON TROOP
FOR EACH ROW
BEGIN
    -- Contar el número de registros en la tabla
    DECLARE num_rows INT;
    SELECT COUNT(*) INTO num_rows FROM TROOP;
    
    -- Verificar si el número de registros es mayor que 8
    IF num_rows >= 8 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'NO SE PERMITE INSERTAR MÁS DE 8 REGISTROS EN LA TABLA TROOP';
    END IF;
END//

DELIMITER ;


* MOVIMIENTOS Y LOGS

CREATE TABLE LOGS_FRIENDS (
    log_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    action_type VARCHAR(10) NOT NULL,
    log_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);

-- COSA LOCA QUE TIENE MYSQL >> SOLO SE PUEDE CREAR UN SOLO TRIGGER POR EVENTO

DELIMITER //
CREATE TRIGGER friends_log_trigger_insert
AFTER 
	INSERT ON FRIENDS
FOR EACH ROW
BEGIN
    IF NEW.TROOP IS NULL THEN
        IF EXISTS (
        	SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
        		WHERE 
        		TABLE_NAME = 'FRIENDS' 
        		AND TABLE_SCHEMA = DATABASE()
        	) THEN
        INSERT INTO LOGS_FRIENDS (action_type, user_id, first_name, last_name)
            VALUES ('INSERT', NEW.ID, NEW.FIRST_NAME, NEW.LAST_NAME);
        END IF;
    END IF;
END//

DELIMITER ;


DELIMITER //
CREATE TRIGGER friends_log_trigger_update
AFTER 
	UPDATE ON FRIENDS
FOR EACH ROW
BEGIN
    IF NEW.TROOP IS NULL THEN
        IF EXISTS (
        	SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
        		WHERE 
        		TABLE_NAME = 'FRIENDS' 
        		AND TABLE_SCHEMA = DATABASE()
        	) THEN
        INSERT INTO LOGS_FRIENDS (action_type, user_id, first_name, last_name)
            VALUES ('UPDATE', NEW.ID, NEW.FIRST_NAME, NEW.LAST_NAME);
        END IF;
    END IF;
END//

DELIMITER ;

-- MOSTRAR TRIGGERRS 
SHOW TRIGGERS
FROM CLASE7
;

-- INSERT VALUE

INSERT INTO FRIENDS (FIRST_NAME, LAST_NAME, TROOP)
VALUES
    ('ANDRU', 'Doe', NULL),
    ('Michel', 'Smith', NULL);

UPDATE FRIENDS
SET 
		FIRST_NAME 	= 	'Anderson'
	,	LAST_NAME	=	'Ocana'
WHERE TRUE
	AND FIRST_NAME	=	'ANDRU'
;

-- VERIFICAMOS

SELECT 
	*
FROM CLASE7.LOGS_FRIENDS
; 


-- STORED PROCEDURES


## Stored Procedures en Bases de Datos

Los stored procedures son conjuntos de instrucciones SQL que se almacenan en la base de datos y se pueden llamar y ejecutar cuando sea necesario. Proporcionan una forma conveniente de encapsular lógica de negocio compleja y repetitiva en la base de datos, lo que puede mejorar el rendimiento, la seguridad y la mantenibilidad de una aplicación.

### Funcionamiento de los Stored Procedures:

- Los stored procedures se definen una vez y se pueden llamar repetidamente desde cualquier parte de la aplicación.
- Pueden aceptar parámetros de entrada y devolver valores de salida.
- Se pueden utilizar para realizar operaciones complejas que involucran varias consultas SQL, transacciones y lógica de control.
- Los stored procedures se almacenan en la base de datos y se ejecutan en el servidor de base de datos, lo que puede reducir la cantidad de datos transferidos entre la aplicación y el servidor.

### Tipos de Stored Procedures:

1. **Stored Procedures de Selección (Select Procedures)**: Realizan operaciones de consulta y devuelven conjuntos de resultados. Son útiles para recuperar datos de la base de datos.

2. **Stored Procedures de Modificación (Modification Procedures)**: Realizan operaciones de inserción, actualización o eliminación en la base de datos. Se utilizan para modificar datos en las tablas.

3. **Stored Procedures de Utilidad (Utility Procedures)**: Realizan tareas útiles como crear, modificar o eliminar objetos de la base de datos, gestionar permisos de usuario, etc.

4. **Stored Procedures de Negocio (Business Procedures)**: Encapsulan la lógica de negocio compleja y repetitiva en la base de datos. Pueden realizar cálculos, validaciones y aplicar reglas de negocio.



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




-- TIPOS DE TABLA

1. **MyISAM**:
   - Es el motor de almacenamiento predeterminado en versiones antiguas de MySQL.
   - Ofrece una alta velocidad y eficiencia en las operaciones de lectura.
   - No soporta transacciones ACID (Atomicidad, Consistencia, Aislamiento, Durabilidad) ni claves foráneas.
   - Es adecuado para aplicaciones que requieren un alto rendimiento en operaciones de lectura, como sitios web estáticos o aplicaciones de análisis de datos.

2. **MEMORY**:
   - Almacena toda la tabla en la memoria RAM del servidor.
   - Es extremadamente rápido para operaciones de lectura y escritura, ya que no implica acceso a disco.
   - Ideal para tablas temporales o pequeñas tablas de caché que necesitan un acceso rápido a los datos.

3. **InnoDB y BDB**:
   - Son motores de almacenamiento transaccionales que cumplen con el estándar ACID.
   - Soportan claves foráneas y ofrecen características como bloqueo a nivel de fila para mejorar la concurrencia.
   - InnoDB es el motor de almacenamiento predeterminado en MySQL desde la versión 5.5.
   - BDB (BerkeleyDB) fue otro motor transaccional disponible en versiones anteriores, pero ha sido descontinuado en versiones recientes.

4. **EXAMPLE**:
   - Es un motor de almacenamiento simple que se utiliza principalmente para propósitos de prueba o demostración.
   - No es adecuado para entornos de producción debido a su falta de funcionalidades avanzadas y su bajo rendimiento.

5. **NDB Cluster**:
   - Es un motor de almacenamiento diseñado para MySQL Cluster, una solución de base de datos distribuida y altamente disponible.
   - Proporciona escalabilidad horizontal y alta disponibilidad al distribuir los datos en varios nodos.

6. **ARCHIVE**:
   - Está optimizado para tablas de tipo de registro, donde la mayoría de las operaciones son de lectura y escritura se realiza de forma esporádica.
   - Ofrece una compresión eficiente de datos para ahorrar espacio en disco.
   - No es adecuado para tablas con muchas operaciones de actualización o eliminación.

7. **CSV**:
   - Almacena los datos en formato CSV (valores separados por comas), lo que permite importar y exportar fácilmente datos desde y hacia archivos CSV.
   - Es útil para integrar datos de MySQL con otras aplicaciones que trabajan con archivos CSV.

8. **FEDERATED**:
   - Permite acceder y manipular datos en una base de datos remota como si estuvieran en una tabla local.
   - Facilita la integración y la federación de datos entre múltiples servidores de bases de datos MySQL.

Cada tipo de motor de almacenamiento tiene sus propias características y casos de uso específicos, por lo que es importante elegir el más adecuado según los requisitos y el diseño de la aplicación.


-- FACT TABLES
-- TRANSAC TABLES
-- DIMENSION TABLES

-- FOREIGN KEY
-- CANDIDATE AND CONCATENATE KEYS


**Temario: Tablas en Bases de Datos**

**1. Tipos de Tabla:**
   - Tablas Temporales
   - Tablas Permanentes
   - Tablas Virtuales

**2. Fact Tables (Tablas de Hechos):**
   - Definición
   - Características
   - Ejemplos de Uso
   - Relación con el Modelo de Estrella y Copo de Nieve

**3. Transac Tables (Tablas de Transacciones):**
   - Definición
   - Propósito
   - Ejemplos de Uso
   - Relación con el Seguimiento de Transacciones y Auditorías

**4. Dimension Tables (Tablas de Dimensiones):**
   - Definición
   - Características
   - Ejemplos de Dimensiones Comunes (Tiempo, Producto, Ubicación)
   - Relación con el Modelo de Estrella y Copo de Nieve

**5. Foreign Key (Clave Externa):**
   - Definición
   - Propósito
   - Ejemplos de Implementación
   - Relación con la Integridad Referencial

**6. Candidate and Concatenate Keys (Claves Candidatas y Concatenadas):**
   - Definición de Clave Candidata
   - Definición de Clave Concatenada
   - Diferencias entre Claves Candidatas y Concatenadas
   - Ejemplos de Uso

---

**Explicación de los Puntos:**

**Tipos de Tabla:**
Las tablas en bases de datos pueden clasificarse en temporales, que se crean y eliminan durante la ejecución de un programa o proceso; permanentes, que persisten en la base de datos incluso después de cerrar la conexión; y virtuales, que son el resultado de una consulta o cálculo y no se almacenan físicamente en la base de datos.

**Fact Tables (Tablas de Hechos):**
Son tablas que almacenan datos cuantificables y específicos que se pueden medir, generalmente en el contexto de un proceso de negocio o un evento. Son centrales en un modelo de datos dimensional, como el modelo de estrella y copo de nieve, y contienen métricas clave que se analizan en conjunto con las dimensiones.

**Transac Tables (Tablas de Transacciones):**
Estas tablas registran eventos individuales o transacciones que ocurren en un sistema. Son fundamentales para el seguimiento de cambios y la auditoría, ya que contienen información detallada sobre quién hizo qué y cuándo en la base de datos.

**Dimension Tables (Tablas de Dimensiones):**
Son tablas que contienen descripciones textuales o contextuales de los datos en las fact tables. Por lo general, contienen atributos que proporcionan contexto a las métricas almacenadas en las fact tables y son utilizadas para filtrar, agrupar o agregar datos.

**Foreign Key (Clave Externa):**
Una foreign key es un campo (o campos) en una tabla que hace referencia a la primary key de otra tabla. Se utiliza para establecer una relación entre dos tablas y garantizar la integridad referencial en la base de datos. La foreign key garantiza que los valores en la columna referenciada existan en la tabla principal.

**Candidate and Concatenate Keys (Claves Candidatas y Concatenadas):**
Una clave candidata es un conjunto de uno o más campos que pueden ser claves primarias potenciales para una tabla. Una clave concatenada es una clave primaria que consta de la combinación de dos o más campos. Las claves candidatas son candidatas a ser claves primarias, mientras que las claves concatenadas son claves primarias compuestas.


-- 

Ejemplo de tablas dimensionales 
Ejemplo de tablas de hechos

Identificar en el modelo de una applicacion de reservas las tablas que serían de hecho y las que son dimensionales: 

-- Presentar el modelo en el respositorio
-- LINK: https://github.com/Andru-1987/53175-sql/blob/main/proyecto_reservas_db/ddl_reservas_app.sql

-- Dar informacion sobre la relacion cardinal de RESTAURANTE -- DUEÑO

-- Data extra: 
La integridad relacional en MySQL se refiere a la garantía de que las relaciones entre las tablas en una base de datos se mantienen consistentes y que no se producen acciones que puedan comprometer la integridad de los datos. MySQL proporciona varias herramientas y mecanismos para implementar y mantener la integridad relacional en una base de datos:

    Constraints (Restricciones): MySQL permite definir diferentes tipos de restricciones para mantener la integridad de los datos, incluyendo:
        PRIMARY KEY: Define un campo o conjunto de campos como clave primaria, asegurando que los valores sean únicos e indexados.
        FOREIGN KEY: Establece una relación entre dos tablas, garantizando que los valores en la columna referenciada existan en la tabla principal.
        UNIQUE: Asegura que los valores en una columna o conjunto de columnas sean únicos.
        NOT NULL: Evita que los valores en una columna sean nulos, asegurando que siempre contengan datos.

    Triggers (Disparadores): Los triggers son bloques de código SQL que se ejecutan automáticamente cuando ocurren ciertos eventos, como inserciones, actualizaciones o eliminaciones en una tabla. Se pueden utilizar para realizar validaciones adicionales o acciones específicas para mantener la integridad de los datos.

    Transactions (Transacciones): MySQL soporta transacciones, que permiten agrupar una serie de operaciones SQL en una unidad lógica de trabajo. Las transacciones garantizan la atomicidad, consistencia, aislamiento y durabilidad (propiedades ACID), lo que ayuda a mantener la integridad de los datos durante operaciones complejas que afectan a múltiples tablas.

    Foreign Key Constraints (Restricciones de Clave Externa): MySQL permite definir restricciones de clave externa utilizando la sintaxis FOREIGN KEY, lo que garantiza que los valores en una columna de una tabla (clave externa) hagan referencia a los valores existentes en otra tabla (clave primaria).

    Índices (Indexes): Los índices en MySQL pueden mejorar el rendimiento de las consultas, pero también pueden utilizarse para garantizar la integridad de los datos al imponer restricciones únicas o de clave primaria en una tabla.



-- Integridad referencial:
-- LINK : https://dev.mysql.com/doc/refman/8.0/en/create-table-foreign-keys.html