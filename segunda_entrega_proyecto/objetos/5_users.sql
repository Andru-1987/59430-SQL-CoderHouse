USE donaton;

DROP USER IF EXISTS 
"usuario_1"@"%" ,
"usuario_2"@"%" ,
"usuario_3"@"%" ;

CREATE USER "usuario_1"@"%" IDENTIFIED BY "pass_123!";
GRANT SELECT ON donaton.vw_donaciones_por_periodo  TO "usuario_1"@"%";
GRANT SELECT ON donaton.vw_donaciones_por_categoria TO "usuario_1"@"%";

CREATE USER "usuario_2"@"%" IDENTIFIED BY "pass_123!";
GRANT SELECT ON donaton.*  TO "usuario_2"@"%";

CREATE USER "usuario_3"@"%" IDENTIFIED BY "pass_123!";
GRANT ALL PRIVILEGES ON donaton.* TO "usuario_3"@"%";


-- SELECT USER FROM mysql.user;





