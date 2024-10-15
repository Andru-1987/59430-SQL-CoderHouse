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

