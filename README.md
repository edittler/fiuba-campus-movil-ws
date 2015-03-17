# FIUBA Campus Móvil Web Service
[![Build Status](https://travis-ci.org/ezeperez26/fiuba-campus-movil-ws.svg)](https://travis-ci.org/ezeperez26/fiuba-campus-movil-ws)

Web service y backend administrativo de FIUBA Campus Móvil

## Requisitos
* MySQL
* Ruby 2.1.x
* *gema* Bundler

## Configuración del ambiente
### SQL
En sistemas operativos basados en Debian, se deberá instalar MySQL con el
siguiente comando:
```bash
sudo apt-get install mysql-server mysql-client
```
Durante el proceso de instalación se le pedirá que ingrese una contraseña para
el usuario root de MySQL. ¡No olvidarla!

Una vez finalizada la instalación, el servidor MySQL se inicia automáticamente.
Para verificar si el servidor se encuentra corriendo, puede ejecutar el
siguiente comando:
```bash
sudo netstat -tap | grep mysql
```
Cuando ejecuta el comando, se puede ver una salida similar a la siguiente:
```
tcp        0      0 localhost:mysql         *:*                LISTEN      2556/mysqld
```
Si el servidor no está corriendo, puede utilizar este comando para iniciarlo:
```bash
sudo service mysql restart
```
Ahora se crearán las bases de datos de desarrollo, pruebas y producción y sus
correspondientes usuarios para que Rails pueda acceder a la base de datos.
Procedemos iniciar el modo interactivo de MySQL con el siguiente comando:
```bash
mysql -u root -p
```
Luego de ingresar la contraseña que configuró durante la instalación, se abrirá
el modo interactivo. Para crear las bases de datos ejecutar los siguientes
comandos:
```sql
CREATE DATABASE fiuba_campus_movil_ws_development;
CREATE DATABASE fiuba_campus_movil_ws_test;
CREATE DATABASE fiuba_campus_movil_ws_production;
```
A continuación, ejecutar los siguientes comandos para crear los respectivos
usuarios:
```sql
CREATE USER dev;
CREATE USER travis;
CREATE USER fiuba-campus-movil-ws;
```
Para otorgar los permisos a cada usuario para manipular la base de datos creada
con el comando anterior, ejecutar los comandos:
```sql
GRANT ALL PRIVILEGES ON fiuba_campus_movil_ws_development.* TO 'dev'@'%';
GRANT ALL PRIVILEGES ON fiuba_campus_movil_ws_test.* TO 'travis'@'%';
GRANT ALL PRIVILEGES ON fiuba_campus_movil_ws_production.* TO 'fiuba-campus-movil-ws'@'%';
FLUSH PRIVILEGES;
```
Para salir del modo interactivo de MySQL, simplemente escribir `exit`.

### Ruby
Dado que el gestor de paquetes de los sistemas operativos basados en Debian
suelen tener versiones antiguas de Ruby, se recomienda el uso de
[RVM](https://rvm.io/), el cual permite instalar versiones actualizadas de Ruby:
Para instalar RVM, ejecutar los siguientes comandos:
```bash
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
```
```bash
\curl -sSL https://get.rvm.io | bash -s stable
```

**¿Usa el Terminal de Gnome o similar?**

Debería configurar el login shell como se indica en este
[link](https://rvm.io/integration/gnome-terminal)

Para instalar Ruby 2.1.x, ejecutar el siguiente comando:
```bash
rvm install 2.1
```

Para configurar la versión de Ruby que acaba de instalar, ejecutar el comando:
```bash
rvm use 2.1 --default
```

Ahora se procede a instalar el Bundler con el siguente comando:
```bash
gem install bundle
```

### Inicialización del proyecto
Clonar este proyecto, posicionarse desde la consola en el directorio del
repositorio recién clonado y actualizar las dependencias con el siguiente
comando:
```bash
bundle install
```

Luego de instalar las dependencias necesarias para el proyecto, se procede a 
inicializar las bases de datos ejecutando el siguiente comando:
```bash
bundle exec rake db:migrate
```

Ahora puede correr el servidor y utilizar el web service de este proyecto
ejecutando el comando:
```bash
rails server
```

Seguir las instrucciones que imprime el comando para visitar el sitio.