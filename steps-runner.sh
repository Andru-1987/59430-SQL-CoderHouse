# para levantar este contenedor con el servidor de mysql:


docker compose up --build -d

# acceder a ese contenedor para ver que data tiene

docker exec -it mysql-server bash

# crear la base de datos desdde el codigo sql creado

docker exec -it -e MYSQL_PWD="coderhouse" mysql-server mysql -u root -e "source /proyecto_sql/estructura.sql;"

# ver las tablas 
docker exec -it  -e MYSQL_PWD="coderhouse" mysql-server mysql -u root -p -e "SHOW TABLES FROM donaton;"

# popular la base datos
docker exec -it -e MYSQL_PWD="coderhouse" mysql-server mysql --verbose -u root -e "source /proyecto_sql/population.sql;"

# borrar todo y poner de cero

docker exec -it -e MYSQL_PWD="coderhouse" mysql-server mysql --verbose -u root -e "DROP DATABASE IF EXISTS donaton;"


docker exec -it -e MYSQL_PWD="coderhouse" mysql-server \
mysql \
--verbose \
-u root \
-e "\
DROP DATABASE IF EXISTS donaton;
source proyecto_sql/estructura.sql; \
source proyecto_sql/population.sql; \
source proyecto_sql/objetos/1_vistas.sql; \
source proyecto_sql/objetos/2_funciones.sql; \
source proyecto_sql/objetos/3_procedimientos.sql; \
source proyecto_sql/objetos/4_triggers.sql; "
