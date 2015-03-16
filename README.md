# FIUBA Campus Móvil Web Service
[![Build Status](https://travis-ci.org/ezeperez26/fiuba-campus-movil-ws.svg)](https://travis-ci.org/ezeperez26/fiuba-campus-movil-ws)

Web service y backend administrativo de FIUBA Campus Móvil

## Requisitos
* Ruby 2.1.x
* MySQL

## Configuración del ambiente
### SQL
En sistemas operativos basados en Debian, se deberá instalar MySQL con el
siguiente comando:
```sh
sudo apt-get install mysql-server mysql-client
```
Durante el proceso de instalación se le pedirá que ingrese una contraseña para
el usuario root de MySQL. ¡No olvidarla!

Una vez finalizada la instalación, el servidor MySQL se inicia automáticamente.
Para verificar si el servidor se encuentra corriendo, puede ejecutar el
siguiente comando:
```sh
sudo netstat -tap | grep mysql
```
Cuando ejecuta el comando, se puede ver una salida similar a la siguiente:
```
tcp        0      0 localhost:mysql         *:*                LISTEN      2556/mysqld
```
Si el servidor no está corriendo, puede utilizar este comando para iniciarlo:
```sh
sudo service mysql restart
```
Ahora se requiere crear la base de datos de desarrollo y el usuario
correspondiente para que Rails pueda acceder a la base de datos.
Procedemos iniciar el modo interactivo de MySQL con el siguiente comando:
```sh
mysql -u root -p
```
Luego de ingresar la contraseña que configuró durante la instalación, se abrirá
el modo interactivo. Para crear la base de datos de desarrollo ejecutar el
siguiente comando:
```sh
CREATE DATABASE fiuba_campus_movil_ws_development;
```
A continuación, ejecutar el siguiente comando para crear el usuario `dev`:
```sh
CREATE USER dev;
```
Para otorgar los permisos para manipular la base de datos creada con el comando
anterio, ejecutar el comando:
```sh
GRANT ALL PRIVILEGES ON fiuba_campus_movil_ws_development.* TO 'dev'@'%';
FLUSH PRIVILEGES;
```
Para salir del modo interactivo de MySQL, simplemente escribir `exit`.

### Ruby
