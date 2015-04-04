# FIUBA Campus Móvil Web Service
[![Build Status](https://travis-ci.org/ezeperez26/fiuba-campus-movil-ws.svg)](https://travis-ci.org/ezeperez26/fiuba-campus-movil-ws)

Web service y backend administrativo de FIUBA Campus Móvil

## Requisitos
* PostgreSQL 8.2 o superior
* Ruby 2.1.5
* *gema* Bundler

## Configuración del ambiente
### PostgreSQL
La versión requerida de PostgreSQL para Rails es 8.2 o superior.
En sistemas operativos basados en Debian, se deberá instalar PostgreSQL con el
siguiente comando:
```bash
user@laptop:~$ sudo apt-get install postgresql postgresql-contrib
```

Cambiar al usuario PostgreSQL con el siguiente comando
```bash
user@laptop:~$ sudo su - postgres
postgres@laptop:~$
```

Crear los users necesarios con los siguientes comandos:
```bash
postgres@laptop:~$ createuser development --createdb
postgres@laptop:~$ createuser test --createdb
```

Una vez creados los users, se debe realizar unos ajustes a la configuración de
Postgre. Se procede a editar el documento `gp_hba.conf`:
``` bash
postgres@laptop:~$ nano /etc/postgresql/9.3/main/pg_hba.conf
```

Para la conexión local de sockets Unix se debe reemplazar el método "peer" a
"trust", quedando el documento de la siguiente manera:
```
# Database administrative login by Unix domain socket
local   all             postgres                                peer

# TYPE  DATABASE        USER            ADDRESS                 METHOD

# "local" is for Unix domain socket connections only
local   all             all                                     trust
# IPv4 local connections:
host    all             all             127.0.0.1/32            md5
# IPv6 local connections:
host    all             all             ::1/128                 md5
# Allow replication connections from localhost, by a user with the
# replication privilege.
#local   replication     postgres                                peer
#host    replication     postgres        127.0.0.1/32            md5
#host    replication     postgres        ::1/128                 md5
```

Salir del usuario tipeando "logout":
```bash
postgres@laptop:~$ logout
user@laptop:~$
```
Una vez que haya regresado al propio usuario se debe reiniciar el servidor
PostgreSQL para que surta efecto el cambio de configuración ejecutando el
siguiente comando:
```bash
user@laptop:~$ sudo service postgresql restart
```

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
gem install bundler
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

En caso de que la base de datos ya se encuentre inicializada y se quiera
"limpiarla", ejecutar el siguiente comando:
```bash
bundle exec rake db:reset
```

Ahora puede correr el servidor y utilizar el web service de este proyecto
ejecutando el comando:
```bash
rails server
```

Seguir las instrucciones que imprime el comando para visitar el sitio.
