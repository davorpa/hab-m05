# Instalación y configuración de MySQL

Guía de instalación en vídeo: https://youtu.be/PXj5aDj6Dgo


## 1. Instalación MySQL Server
#### 1.1 Instalación en Ubuntu

##### 1.1.1 Actualizar paquetes disponibles

Abrir un terminal y ejecutar:
```shell
sudo apt-get update
```
Nos solicitará la contraseña de nuestro usuario de Linux, y se la proporcionaremos
```console
[sudo] contraseña para nombre-de-usuario:
```
El sistema descargará una lista de ficheros de internet, cuando termine nos mostrará
`Leyendo lista de paquetes... Hecho` y nos dejará escribir de nuevo en el terminal.

A continuación actualizamos los paquetes instalados
```shell
sudo apt-get upgrade
```
##### 1.1.2 Instalar MySQL Server
Desde un terminal ejecutamos
```shell
sudo apt-get install mysql-server mysql-client
```
El sistema comprobará qué ficheros debe descargarse de internet y nos pedirá que le confirmemos que deseamos instalarlo
```console
Se utilizarán 245 MB de espacio de disco adicional después de esta operación.
¿Desea continuar? [S/n] S
```
Pulsamos **S** para indicarle que si.
Se descargará los ficheros de internet y los instalará.
Cuando termine nos permitirá escribir de nuevo en el terminal.

#### 1.2 Instalación en MacOS

Primero debemos instalar [Homebrew](https://brew.sh/) abriendo un terminal y ejecutando

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

El comando anterior es todo en una sola línea.

Después de tenerlo instalado ejecutamos los siguientes comandos por orden esperando que acabe el anterior:

```shell
brew install mysql
brew tap homebrew/services
brew services start mysql
```

### 1.3 Comprobar que se ha instalado
Ejecutaremos
```shell
mysql --version
```
Si el proceso de instalación ha ido bien se debería mostrar una línea similar a:
```console
mysql Ver 8.0.22-0ubuntu0.20.10.2 for Linux on x86_64 ((Ubuntu))
```

Si no da error todo va bien.

### 1.4 Establecer configuración de seguridad inicial

MySQL tiene un usuario de administración que se llama `root`.
Lo primero que vamos a hacer es asignarle como contraseña `root` y ajustar la configuración básica de seguridad

En un terminal ejecutar
```shell
sudo mysql_secure_installation
```
Lo primero que nos preguntará el asistente es si deseamos usar contraseñas seguras, en un entorno real debería activarse
pero nosotros le vamos a decir que no porque vamos a usar una constraseña muy sencilla.
```console
Would you like to setup VALIDATE PASSWORD plugin?

Press y|Y for Yes, any other key for No: n
```
A Continuación nos solicita qué contraseña queremos asignarle al usuario `root`, en un alarde de originalidad
vamos a ponerle `root`. Recordad que aunque no se vea lo que escribís (por seguridad) si que estais introduciendo la contraseña.

```console
Please set the password for root here.

New password:
Re-enter new password:
```

Finalmente nos relizará unas preguntas sobre seguridad, le diremos a todo que si: `y`
```console
Remove anonymous users: y
Disallow root login remotely: y
Remove test database and access to it: y
Reload privilege tables now: y
```

Al finalizar el asistente se mostrará por pantalla `All done!` y nos devolverá al terminal.

## 2. Permisos de acceso
En esta sección estableceremos los permisos de acceso para dos usuarios:
* `root` cuya contraseña será `root`
* Crearemos un nuevo usuario `demo`, cuya contraseña será `password`.
Con el usuario `demo` es con el que haremos las prácticas.

### 2.1 Permisos de acceso para root
Desde un terminal ejecutar:
```shell
sudo mysql
```

En caso de usar MacOS ejecutar lo siguiente:

```shell
mysql -u root -p
```

Os pedirá una password que es 'root' como introducisteis en el paso anterior.

Si todo va bien tanto en Linux como en Mac se abrirá una *consola de MySQL*, lo sabemos porque la línea comieza por `mysql>`.

En la consola de MySQL las sentencias terminan con `;`
Si dejamos una sentencia a medio escribir y pulsamos intro mysql no sabe que la sentencia ha terminado.
Siempre hay que poner el `;` para que mysql ejecute el código.
Cuando MySQL ejecuta una sentencia siempre indica el resultado de la misma, nosotros nos fijaremos en que
ponga `Query OK`, independientemente del número de tuplas que se hayan visto involucradas.

Esto abrirá un _bash_ SQL, ahí ejecutar:
```sql
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root';
```
```sql
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
```
```sql
FLUSH PRIVILEGES;
```

Ya hemos terminado de ejecutar sentencias de MySQL, para salir escribiremos `exit`

Para finalizar comprobamos que podemos acceder a MySQL con el usuario root, escribiremos:
```shell
mysql -u root –p
```
Y si todo ha ido bien entrará en la consola de MySQL.
Escribiremos `exit` para salir.

```mysql
mysql> exit
Bye
```

### 2.2 Crear el usuario 'demo'
Desde un terminal accederemos con el usuario `root` (Su contraseña es `root`):
- en ubuntu:
```shell
sudo mysql
```
- en mac:
```shell
mysql -u root -p
```
Desde la consola de MySQL ejecutaremos las siguientes sentencias:
```sql
CREATE USER 'demo'@'localhost' IDENTIFIED BY 'password';
```
```sql
GRANT ALL PRIVILEGES ON *.* TO 'demo'@'localhost';
```
```sql
FLUSH PRIVILEGES;
```
Ya hemos terminado de ejecutar sentencias de MySQL, para salir escribiremos `exit`

Finalmente comprobaremos que nuestro usuario `demo` se puede conectar.
```shell
mysql -u demo –p
```


Y si todo ha ido bien entrará en la consola de MySQL.
Escribiremos `exit` para salir.
```mysql-sql
mysql> exit
Bye
```

## 3. MySQL Workbench
Instalaremos y configuraremos el cliente de MySQL
### 3.1 Instalación de MySQL Workbench

Para instalar MySQL Workbench vamos a la librería de software de ubuntu "Ubuntu Software" que podemos encontrar en nuestras aplicaciones y buscamos la aplicación escribiendo en el buscador "workbench". La instalamos y después de instalada pulsamos en el botón permisos y marcamos que tenga permisos para leer y guardar contraseñas.

También podemos instalar la aplicación desde terminal usando estes dos comandos:
```shell
sudo snap install mysql-workbench-community
sudo snap connect mysql-workbench-community:password-manager-service :password-manager-service
```

### 3.2 Configuración de la conexión a la base de datos

Iremos desde, el escritorio de Linux, a: `Aplicaciones`, Seleccionaremos `Todas` (en las parte de abajo),
y pulsaremos sobre `MySQL Workbench`. Esto abrirá una aplicación de escritorio.

Pulsaremos en el `+` que está a la derecha de `MySQL Connections` y cubriremos con los siguientes datos

```
Conection name: Example
Hostname: 127.0.0.1
Port: 3306
User: demo
Password: (pulsamos en el botón Store in Keychain y la introducimos)
```
Finalmente pulsaremos sobre `Test connection`. y si todo ha ido bien se mostrará una ventana emergente que pondrá `Successfully made the MySQL connection`

## 4. Desinstalar

En caso de que queramos eliminar MySQL:

```shell
sudo apt-get remove --purge mysql-server mysql-client mysql-common -y
sudo apt-get autoremove -y
sudo apt-get autoclean

rm -rf /etc/mysql
rm -rf /var/lib/mysql
```
**CUIDADO:**  No ejecutar si no se está seguro
En ocasiones pueden quedar ficheros relacionados con MySQL después de la desinstalación.
Con el siguiente comando localizaremos cualquier fichero que comience por `mysql`.
**OJO:** ¡Puede haber ficheros que usan otras aplicaciones que comiencen por mysql!
```shell
sudo find / -iname 'mysql*'
```
**PELIGRO:** Sólo ejecutar si realmente estamos seguros de lo que hacemos.
Con esta sentencia eliminamos todos los resultados anteriores.
Nota: Si solamente queremos borrar unos ficheros en particular tendremos que eliminarlos manualmente.
```shell
sudo find / -iname 'mysql*' -exec rm -rf {} \;
```
