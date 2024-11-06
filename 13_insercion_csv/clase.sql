-- CLASE 13
-- INSERCION CON IMPORTACION

## Bases de Datos en MySQL: Importación de Archivos CSV y JSON

-- LINK OFICIAL : https://dev.mysql.com/doc/refman/8.0/en/load-data.html

### Importación de Archivos CSV y JSON en MySQL

MySQL ofrece varias opciones para importar datos desde archivos CSV y JSON. Esto es útil cuando necesitas cargar grandes cantidades de datos desde archivos externos a tu base de datos.

#### Importación de CSV

Una forma común de importar datos desde un archivo CSV a una tabla MySQL es utilizando el comando `LOAD DATA INFILE`. Este comando carga datos desde un archivo en el servidor MySQL directamente a una tabla.

Ejemplo de comando `LOAD DATA INFILE` para importar un archivo CSV:

```sql
LOAD DATA LOCAL INFILE '/ruta/al/archivo.csv' 
INTO TABLE nombre_tabla 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS;
```

- `/ruta/al/archivo.csv`: Ruta al archivo CSV que quieres importar.
- `nombre_tabla`: Nombre de la tabla en la que quieres importar los datos.
- `FIELDS TERMINATED BY ','`: Especifica el delimitador de campo en el archivo CSV.
- `ENCLOSED BY '"'`: Especifica el carácter de encerrado en caso de que los campos estén entre comillas dobles.
- `LINES TERMINATED BY '\n'`: Especifica el delimitador de línea en el archivo CSV.
- `IGNORE 1 ROWS`: Opcional, ignora la primera fila si contiene encabezados.

#### Importación de JSON

Para importar datos desde un archivo JSON a una tabla MySQL, puedes utilizar la sentencia `INSERT INTO`. Sin embargo, necesitas transformar el archivo JSON en un formato compatible con la sentencia `INSERT INTO`.

Ejemplo de inserción de datos JSON en MySQL:

```sql
INSERT INTO nombre_tabla (columna1, columna2, columna3) 
VALUES (valor1, valor2, valor3), (valor4, valor5, valor6), ...;
```

Donde `nombre_tabla` es el nombre de la tabla en la que deseas insertar los datos, y `(columna1, columna2, columna3)` son los nombres de las columnas en la tabla. `valor1`, `valor2`, `valor3`, etc., son los valores que deseas insertar en las respectivas columnas.

### Optimización de Importación en MySQL

Para optimizar la importación de datos en MySQL, especialmente al trabajar con grandes conjuntos de datos, considera las siguientes prácticas:

1. **Índices**: Si es posible, deshabilita los índices antes de la importación y vuelve a habilitarlos después. Esto puede acelerar significativamente la importación.

2. **Commit por Lotes**: En lugar de realizar un solo gran commit al final de la importación, considera realizar commits por lotes más pequeños. Esto puede mejorar la eficiencia y la tolerancia a fallos.

3. **Partitioning**: Si estás importando datos en una tabla particionada, asegúrate de que los datos estén distribuidos equitativamente entre las particiones para evitar cuellos de botella.

4. **Uso de LOAD DATA INFILE**: Utiliza la función `LOAD DATA INFILE` de MySQL en lugar de inserciones individuales cuando sea posible. Esta función es mucho más rápida para importar grandes volúmenes de datos.

### Uso de `LOAD DATA LOCAL INFILE`

La opción `LOCAL` de `LOAD DATA INFILE` permite cargar archivos desde el cliente MySQL en lugar del servidor. Esto puede ser útil cuando el servidor MySQL no tiene acceso directo al archivo que deseas importar.

Es importante tener en cuenta que el uso de `LOAD DATA LOCAL INFILE` puede plantear problemas de seguridad si no se configura adecuadamente. Asegúrate de que solo los usuarios autorizados tengan permiso para cargar archivos locales y que el servidor MySQL esté configurado para permitir esta operación de forma segura.

---

>> Creacion de tablas
>> STEPS 
- creacion de la base de datos y su estructura
- creacion de datasets
- modificacion de manera grafica tales como google sheets (con datos de duenos)


--  recormendaciones : siempre empezar con las tablas dimensionales que no tienen dependencias de FK's
--  ultimo levantar las tablas de hechos
--  The error message you encountered, ERROR 3948 (42000): Loading local data is disabled; this must be enabled on both the client and server sides, indicates that the MySQL server has disabled the ability to load data from local files. This security feature is enabled by default to prevent unauthorized access and potential security risks.

-- Enable local_infile on the Client Side (Your Machine):

-- When running the mysql command to connect to the MySQL server, you need to include the --local-infile=1 option to enable local file loading:


mysql -u username -p --local-infile=1

SET GLOBAL local_infile = true;
-- verificar que este activado desde server y client side
SHOW GLOBAL VARIABLES LIKE 'local_infile';



LOAD    DATA LOCAL INFILE './clientes.json'
        INTO TABLE CLIENTE 
            -- FIELDS TERMINATED   BY ',' 
            -- LINES TERMINATED    BY '\n' 
            (@json)   
            SET 
            IDCLIENTE = JSON_EXTRACT(@json, '$.IDCLIENTE'),
            NOMBRE = JSON_EXTRACT(@json, '$.NOMBRE'),
            TELEFONO = JSON_EXTRACT(@json, '$.TELEFONO'),
            CORREO = JSON_EXTRACT(@json, '$.CORREO');


LOAD    DATA LOCAL INFILE './clientes.csv'
        INTO TABLE CLIENTE 
            FIELDS TERMINATED   BY ',' 
            LINES TERMINATED    BY '\n' 
            IGNORE 1 ROWS