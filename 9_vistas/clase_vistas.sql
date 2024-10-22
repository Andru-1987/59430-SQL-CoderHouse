
-- UNA VISTA EN SQL ALMACENA UNA QUERY

-- UNA VISTA ALMACENADA ALMACENA UNA QUERY JUNTO A LA DATA

-- LINK https://sqlearning.com/es/elementos-avanzados/view/

-- LINK VIEW https://dev.mysql.com/doc/refman/8.0/en/create-view.html


-- TEORIA ADICIONAL
-- Las vistas en MySQL son consultas almacenadas que se comportan como tablas virtuales. Esto significa que puedes crear una vista que represente una consulta compleja o comúnmente utilizada, y luego consultarla como si fuera una tabla real en tu base de datos. Las vistas proporcionan una capa de abstracción sobre los datos subyacentes, lo que facilita el acceso y la manipulación de los datos.

-- Aquí tienes un ejemplo de cómo crear y utilizar una vista en MySQL:

-- Supongamos que tenemos una base de datos que almacena información sobre empleados, con una tabla llamada `empleados` que tiene las siguientes columnas: `id`, `nombre`, `apellido`, `puesto` y `salario`.

-- Primero, crearemos una vista que muestre los nombres y apellidos de los empleados junto con sus puestos:

-- ```sql
-- CREATE VIEW vista_empleados AS
-- SELECT nombre, apellido, puesto
-- FROM empleados;
-- ```

-- Ahora que hemos creado la vista, podemos consultarla como si fuera una tabla:

-- ```sql
-- SELECT * FROM vista_empleados;
-- ```

-- Esta consulta devolverá los nombres, apellidos y puestos de todos los empleados en la base de datos, pero detrás de escena, MySQL estará ejecutando la consulta definida en la vista.

-- Las vistas son especialmente útiles cuando necesitas acceder a datos complejos o realizar operaciones repetitivas en tu base de datos. Además, proporcionan una capa de seguridad adicional al limitar el acceso directo a las tablas subyacentes y permitir un control más fino sobre quién puede ver qué datos.



-- Ejemplos
--     Creacion de vista
--     Actualizacion de una vista
--     Eliminacion de una vista



-- Un poco de ptractica

    -- Muestre first_name y last_name de los usuarios que tengan mail 'webnode.com'
    SELECT 
            first_name
        ,   last_name
--      ,   email
        FROM coderhouse_gamers.SYSTEM_USER
    WHERE email LIKE '%webnode.com' ; 

    -- Muestre todos los datos de los juegos que han finalizado, los usuarios con email de 'myspace'.


    SELECT 
       G.*
    FROM coderhouse_gamers.PLAY AS P
    RIGHT JOIN coderhouse_gamers.SYSTEM_USER AS SU
        ON P.id_system_user = SU.id_system_user
    RIGHT JOIN coderhouse_gamers.GAME AS G
        ON G.id_game = P.id_game
    WHERE TRUE
    AND P.completed = 1
    AND SU.email LIKE '%@myspace.com';


    -- Muestre los distintos juegos que tuvieron una votación mayor a 9.


    SELECT  
        name
    FROM coderhouse_gamers.GAME
    WHERE id_game IN
        (
            SELECT 
            DISTINCT id_game
            FROM coderhouse_gamers.VOTE
            WHERE
                value > 9
        )
    ;


    -- Muestre nombre, apellido y mail de los usuarios que juegan al juego FIFA 22.

        -- <JOINS VERSION> -- 
            SELECT 
                SU.first_name AS nombre,
                SU.last_name AS apellido,
                SU.email AS mail
            FROM coderhouse_gamers.SYSTEM_USER AS SU
            JOIN coderhouse_gamers.PLAY AS P 
                ON SU.id_system_user = P.id_system_user
            JOIN coderhouse_gamers.GAME AS G 
                ON P.id_game = G.id_game
            WHERE G.name LIKE '%FIFA 22%';

        -- <SUBQUERY VERSION> -- 
            SELECT 
                SU.first_name   AS  nombre
            ,   SU.last_name    AS  apellido
            ,   SU.email        AS  mail
            FROM coderhouse_gamers.SYSTEM_USER AS SU
            WHERE id_system_user IN
                (
                SELECT 
                    id_system_user
                FROM coderhouse_gamers.PLAY AS P
                WHERE EXISTS
                    (SELECT 
                        id_game
                    FROM coderhouse_gamers.GAME AS G
                    WHERE G.id_game = P.id_game
                    AND G.name like '%FIFA 22%'));


-- PARA  VERIFICAR LA PERFORMANCIA

    -- SET profiling = 1;
    -- SHOW PROFILES;
    -- SHOW PROFILE FOR QUERY <Query_ID>;