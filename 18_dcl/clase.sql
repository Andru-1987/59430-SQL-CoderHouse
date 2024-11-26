SELECT * FROM mysql.user;
-- te regeenrar el pwd pero con la posibilidad de que no sos vos >> dfespues del 2 intento Kapoot!
CREATE USER
	'alvaro'@'%'
    -- username @ DOMAIN 
    ; 

ALTER USER
	'alvaro'@'%'
    IDENTIFIED BY 'change.me.1234'
	PASSWORD EXPIRE INTERVAL 2 DAY
    FAILED_LOGIN_ATTEMPTS 2 PASSWORD_LOCK_TIME 2;
    
-- 

CREATE USER
	'mauro'@'%'
    IDENTIFIED BY RANDOM PASSWORD;

ALTER USER
	'mauro'@'%'
    IDENTIFIED BY RANDOM PASSWORD;

-- mauro --> atjSc}LyVHk:[bzJA}sW
-- CON EL USUARIO CREADO E INGRESADO AL SISTEMA PUEDO CAMBIAR MI PWD-- 
SET PASSWORD = 'cambiado.password';

-- PERMISOS -> NOS VAN A DAR LA MIRADA SOBRE LOS CAMPOS DE TABLAS Y EN QUE BASES DE DATOS PUEDO YO MIRAR.

SHOW GRANTS FOR 'mauro'@'%';

GRANT ALL PRIVILEGES ON donaton.* TO 'mauro'@'%';
FLUSH PRIVILEGES;

REVOKE ALL PRIVILEGES ON donaton.* FROM 'mauro'@'%';

GRANT SELECT ON donaton.beneficiario TO 'mauro'@'%';
GRANT SELECT,INSERT ON donaton.donacion TO 'mauro'@'%';



-- ROLES --> 
-- production
CREATE ROLE 
	'production';
GRANT ALL PRIVILEGES ON coderhouse_gamers.* TO 'production' ;

CREATE ROLE 
	'dev';
GRANT SELECT ON coderhouse_gamers.CLASS TO 'dev';
GRANT SELECT ON coderhouse_gamers.GAME TO 'dev';

CREATE ROLE 
	'qa';
GRANT SELECT,INSERT ON coderhouse_gamers.CLASS TO 'qa';
GRANT SELECT, DELETE ON coderhouse_gamers.GAME TO 'qa';

SHOW GRANTS FOR 'qa';

-- otorgar permisos

DROP USER IF EXISTS 'alvaro'@'%', 'martin'@'%' ,'pablo'@'%';

CREATE USER 'alvaro'@'%'
IDENTIFIED BY 'production';

CREATE USER 'martin'@'%'
IDENTIFIED BY 'dev';

CREATE USER 'pablo'@'%'
IDENTIFIED BY 'qa';

GRANT 'qa' TO 'pablo'@'%';
GRANT 'production' TO 'pablo'@'%';
SET DEFAULT ROLE 'qa' TO 'pablo'@'%';
FLUSH PRIVILEGES;
-- 

CREATE ROLE admin_role ;

GRANT ALL PRIVILEGES ON *.* TO admin_role WITH GRANT OPTION;



CREATE USER 'dario'@'%'
IDENTIFIED BY 'production';

GRANT 'production' TO 'dario'@'%' ;
GRANT admin_role TO 'dario'@'%' ;

GRANT ALL ON coderhouse.* TO 'dario'@'%' WITH GRANT OPTION;

SHOW GRANTS FOR dario;


CREATE USER 'raton_perez'@'%' IDENTIFIED BY 'raton';
GRANT production TO 'raton_perez'@'%';
SET DEFAULT ROLE production TO 'raton_perez'@'%';




DROP USER 'raton_perez'@'%';











