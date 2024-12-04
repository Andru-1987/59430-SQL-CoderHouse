# SISTEMA OPERATIVO WINDOWS
# mi primer back con mysqldump

mysqldump -u root -p  --host 127.0.0.1 --port 3306  --databases donaton_bk > backup_donaton.bk.sql


# con procedimientos
mysqldump -u root -p `
--host 127.0.0.1 `
--port 3306 `
--databases `
--routines `
--verbose `
--no-create-db `
donaton_bk | `
Set-Content backup_donaton.bk.20241203.sql
# Out-File -Encoding utf8 backup_donaton.bk.sql


# restaurar una base de datos

# comando para crear la base de dato sin ingresar al sistema
mysql -u root -p `
--host 127.0.0.1 `
--port 3306 `
--verbose `
-e "CREATE DATABASE donaton_bk_terminal"

# comando para restaurar usando el archivo
Get-Content backup_donaton.bk.sql | mysql -u root -p `
--host 127.0.0.1 `
--port 3306 `
donaton_bk_terminal

