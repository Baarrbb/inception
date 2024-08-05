# INCEPTION

Broaden knowledge of system administration by using Docker.
Virtualize several Docker images and set up a small infrastructure composed of different services. Each service has to run in a dedicated container.

## <a name="top">Table of contents</a>
 1. [Docker basics](#docker-basics)
	- [Dockerfile](#dockerfile)
	- [Images](#images)
	- [Containers](#containers)
	- [Docker compose](#docker-compose)
	- [Docker CLI basic commands](#docker-cli-basic-commands)
	- [Questions](#questions)
 2. [Services](#services)
	- [NGINX with TLSv1.3](#nginx-with-tlsv13)
		<ul style="list-style-type:none;">
		<li><a href="#dockerfile-1">Dockerfile</a></li>
		<li><a href="#nginxconf">nginx.conf</a></li>
		<li><a href="#documentations">Doc</a></li>
		</ul>
	- [WordPress + php-fpm](#wordpress--php-fpm)
		<ul style="list-style-type:none;">
		<li><a href="#dockerfile-2">Dockerfile</a></li>
		<li><a href="#script">script</a></li>
		<li><a href="#documentations-1">Doc</a></li>
		</ul>
	- [MariaDB](#mariadb)
		<ul style="list-style-type:none;">
		<li><a href="#dockerfile-3">Dockerfile</a></li>
		<li><a href="#script-1">script</a></li>
		<li><a href="#documentations-2">Doc</a></li>
		</ul>
 3. [Volumes](#volumes)
	- [WordPress database](#wordpress-database)
	- [WordPress website files](#wordpress-website-files)
4. [Docker Compose]()
5. [Docker network]()
6. [Makefile]()

# Docker basics
Docker provides the ability to package and run an application in an isolated environment called a **container**. Containers are lightweight and contain everything needed to run the application.

Docker is a tool that is used to automate the deployment of applications in lightweight containers so that applications can work efficiently in different environments in isolation.


![Schema](./readme_img/Struct.png)


## Dockerfile
A Dockerfile is a text document that contains instructions for generating a Docker **image**.

It define the steps needed to create the image and run it. Each instruction create a layer in the image. That includes all the files, binaries, libraries, and configurations to run a container.

It is the source code of the image.

### Basic instructions

 - **`FROM`** `<image>[:<tag>]`<br>
It defines the base image. Docker applies the remaining instructions in your Dockerfile on top of the base image.<br>
A valid Dockerfile must start with a `FROM` instruction. The image can be any valid image.

- **`RUN`** `<command>`<br>
Runs a command within the container. This can be any command available in the container's environment. This create a new layer on top of the current image.

- **`COPY`** `<src> <dst>`<br>
Copies new files or directories from `<src>` and add them to the filesystem of the container at the path `<dst>`.

- **`EXPOSE`** `<port>`<br>
Informs Docker that the container listens on the specified network ports at runtime. It doesn't actually publish the port. It functions as a type of documentation.

- **`ENTRYPOINT`** `["executable", "param1", "param2"]`<br>
Defines the program or script that will be executed when the containers starts.

 - **`CMD`** `["cmd", "arg", "..."]` <br>
Sets the command to be executed when running a container from an image.

A container runs as long as its main process runs, so it is necessary for Docker to run processes in foreground to ensure the process doesn't exit immediately.<br>
By default, Docker containers are designed to run a single application or service. If the main process of that application or service stops, there is nothing left for the container to do, so it exits.

The container's lifecycle is tied to the main process specified in the `CMD` or `ENTRYPOINT` instruction of the Dockerfile.

[(Dockerfile reference)](https://docs.docker.com/reference/dockerfile/)

## Images
An image is a read-only template with instructions for creating a Docker container.

Docker Image is an executable package of software that includes everything needed to run an application. This image informs how a container should instantiate, determining which software components will run and how.

Base Image: The foundational layer, often a minimal OS or runtime environment.<br>
Layers: Immutable filesystem layers stacked to form a complete image.

### Images are :
 - **Immutable**. Once an image is created, it can't be modified. You can only make a new image or add changes on top of it.
 - **Composed of layers**. Each layer represented a set of file system changes that add, remove, or modify files.

## Containers
A container is a runnable instance of an image.

You can connect a container to one or more networks or attach storage to it. A container is defined by its image as well as any configuration options you provide to it when you create or start it.


Best practice for containers is that each container should do one thing and do it well.

### Containers are :
 - **Self-contained**. Each container has everything it needs to function with no reliance on any pre-installed dependencies on the host machine.
 - **Isolated**. Since containers are run in isolation, they have minimal influence on the host and other containers, increasing the security of your applications.
 - **Independent**. Each container is independently managed. Deleting one container won't affect any others.
 - **Portable**. Containers can run anywhere.

### Containers VS VMs
A VM is an entire operating system with its own kernel, hardware drivers, programs and applications. A container is simply an isolated process with all the files is need to run.

## Docker compose
With Docker Compose, you can define all of your containers and their configurations in a single YAML file.

You don't always need to recreate everything from scratch. If you make a change, run *docker compose up* again and Compose will reconcile the changes in your file and apply them intelligently.

Docker Compose manages multi-container setups and networking.

### Dockerfile VS Compose file
A Dockerfile provides instructions to build a container image while a Compose file defines your running containers. Quite often, a Compose file references a Dockerfile to build an image to use for a particular service.

## Docker CLI basic commands

<details>
<summary><strong>Images</strong></summary>

 - List images<br>

		$ docker images
 - Remove an image

		$ docker rmi [ID]
 - Remove all images

		$ docker rmi -f $(docker images -qa)
</details>

<details>
<summary><strong>Containers</strong></summary>

 - List containers

		$ docker ps -a
 - Stop container

		$ docker stop [ID]
 - Stop all containers

		$ docker stop $(docker ps -qa)
 - Remove container

		$ docker rm [ID]
 - Remove all containers

		$ docker rm $(docker ps -qa)
 - Execute a command in a container

		$ docker exec [ID] [cmd] [args]
</details>

<details>
<summary><strong>Volumes</strong></summary>

 - List volumes

		$ docker volume ls
 - Remove a volume

		$ docker volume rm [ID]
 - Remove all volumes

		$ docker volume rm $(docker volume ls -q)
</details>

<details>
<summary><strong>Networks</strong></summary>

 - List networks

		$ docker network ls
 - Remove a network

		$ docker network rm [ID]
 - Remove all networks

		$ docker network rm $(docker network ls -q)
</details>

[(Docker CLI commands reference)](https://docs.docker.com/reference/cli/docker/)

##
##
## Questions
#### How Docker work ?
#### How docker compose work ?
#### Difference between a Docker image used with docker compose and without ?
#### Benefit of Docker compared to VM ?
#### Pertinence of the directory structure ?

##
##

# Services

![Schema](./readme_img/schema.png)

The containers must be built either from the penultimate stable version of *Alpine* or *Debian*. 

## NGINX with TLSv1.3

Subject : A Docker container that contains NGINX with TLSv1.2 or TLSv1.3 only

---

### Dockerfile

	FROM debian:stable

	RUN apt update -y && apt install -y nginx openssl
	RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
		-keyout /etc/ssl/private/private.key \
		-out /etc/ssl/certs/certificate.crt \
		-subj "/C=/ST=/L=/O=/OU=/CN="

	COPY ./conf/nginx.conf /etc/nginx/nginx.conf

	EXPOSE 443

	CMD ["/usr/sbin/nginx", "-g", "daemon off;"]

#### Base image

Specifies the base image for the Docker container.

#### Install `nginx` and `openssl`

`apt update` : Update available packages.

`apt install nginx openssl` : Install *nginx*, a web server, and *openssl* to generate numeric certificates to securise communications with TLSv1.3.

`-y` : Used to automatically answer 'yes' to all prompt during the execution of the command and avoid manually confirming each action.

#### Generate certificates for TLS

TLS (Transport Layer Security) is a protocol designed to provide secure communication over networks. It is used to ensure privacy, data integrity and authentication between to communication applications.

##

 - Purposes of TLS :

It encrypts the data between two parties, ensuring that it can't be read by anyone else. This protects sensitive information from being intercepted and understood by unauthorized entities.

It ensures that the data sent and received has not been altered during transit. Any unauthorized modifications to the data will be detected.

It allows the client to verify the identity of the server. It ensures the client is communicating with the intended server and not an imposter.

 - How it works ?

The initial process between the client and server exchange cryptographic keys and agree on the encryption methods to be used.

The client and the server send messages to each other that contain information about the supported encryption algorithms and session keys.

The server sends its digital certificate to prove its identity.

A session key is generated and securely exchange  between the client and server, which will be used to encrypt the data during the session.

Once the initial process is complet, all communication between the client and server is encrypted using the session key.

##

Generate certificates to use TLS protocol :

`openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/private.key -out /etc/ssl/certs/certificate.crt -subj "/C=/ST=/L=/O=/OU=/CN="`

`openssl` is a cryptography toolkit implementing the TLS network protocol and related cryptography standards required.

`req` : certificate signing request<br>
`-x509` : outputs a self signed certificate instead of a certificate request<br>
`-nodes` : (no DES) not encrypt the private key. (don't ask for a password)<br>
`-days 365` : validity period of the certificate (when *-x509* is being used)<br>
`-newkey rsa:2048` : (*-newkey rsa:nbits*) generates a new RSA private/public key pair with a length of 2048 bits.<br>
`-keyout` : path to save the private key<br>
`-out` : path to save the self-signed certificate<br>
`-subj "/C=/ST=/L=/O=/OU=/CN="` : replaces subject field of input request with specified data. Avoid prompt asking for certificate informations.


#### Copying nginx configuration file

From local file in `./conf/nginx.conf`<br>
to `/etc/nginx/nginx.conf` in the container, which is the default path for **nginx** configuration files.

[nginx.conf details](#nginxconf)

#### Port 443

Documentation on which port need to be expose.<br>
`443` is the default port for https.

#### Start Nginx in the foreground

As the process must run in the foreground :

`/usr/sbin/nginx -g "daemon off;"`

`/usr/sbin/nginx` : start nginx<br>
`-g` : set global configuration directives<br>
`"daemon off;"` : option which tells to Nginx to run in foreground

<a href="#top"><img src="./readme_img/top.png" align="right"></a>
<br>

---

### nginx.conf

	events {
		worker_connections 1024;
	}
	http {
		server {
			listen 443 ssl;

			server_name bsuc.42.fr;

			ssl_certificate /etc/ssl/certs/certificate.crt;
			ssl_certificate_key /etc/ssl/private/private.key;

			ssl_protocols TLSv1.3;

			location ~ \.php$ {
				fastcgi_pass wordpress:9000;
				fastcgi_index index.php;
				include fastcgi_params;
				fastcgi_param SCRIPT_FILENAME /var/www/html$fastcgi_script_name;
				fastcgi_param PATH_INFO $fastcgi_path_info;
			}

			location / {
				root /var/www/html;
				index index.php;
			}

			location = /favicon.ico {
				log_not_found off;
			}
		}
	}

#### `events`

This block configure how Nginx handles connections.

`worker_connections` : sets maximum number of simultaneous connections that each worker process can handle.

<!-- ------

voir cb de worker_processes par defaut<br>
worker_processes par default = 1 ?

------ -->


#### `http`

This block configure directives for http server and handling web traffic.

#### `server`

This block defines the configuration for a server.

`listen 443 ssl;` : makes the server listen on port 443 for https connection, with ssl enabled.

`server_name login.42.fr;` : specifies the server's domain name.

`ssl_certificate /etc/ssl/certs/certificate.crt;` : specifies the path to the ssl certificate file.

`ssl_certificate_key /etc/ssl/private/private.key;`: specifies the path to the ssl certificate's private key file.

`ssl_protocols TLSv1.3;` : specifies the SSL/TLS protocols to use.

**`location ~ \.php$ {}`** : this block defines how to process PHP files.

`fastcgi_pass wordpress:9000;` : sets the FastCGI server to handle PHP requests.

`fastcgi_index index.php;` : specifies the default file to be served.

`include fastcgi_params;` : includes the defaults FastCGI parameters provided by Nginx.

`fastcgi_param SCRIPT_FILENAME /var/www/html$fastcgi_script_name;` : sets the `SCRIPT_FILENAME` parameter to tell FastCGI where the PHP scripts are located. `$fastcgi_script_name` is a built-in variable used in FastCGI configurations, it contains the script name requested by the client.

`fastcgi_param PATH_INFO $fastcgi_path_info` : sets the `PATH_INFO` parameter with extra path information following the script name but preceding the query string. `$fastcgi_path_info` contains the part of the URL path that follows the script name.

**`location / {}`** : this block is necessary to serve static content (like images, CSS and javascript files). It also handles directory indexing, serving the default index file.

`root /var/www/html;` : sets the root directory for serving files. This mean that any request to the server will look for files in this directory.

`index index.php;` : specifies the default file to serve.

**`location = /favicon.ico {}`** : this block is used to handle request for the favicon.ico file.

`log_not_found off;` : it tells to NGINX to not log an error if the favicon.ico file is not found.

<a href="#top"><img src="./readme_img/top.png" align="right"></a>
<br>

---

### Documentations
<details>
<summary><strong>Nginx</strong></summary>

 - [nginx beginner's guide](https://nginx.org/en/docs/beginners_guide.html)
 - [nginx core](https://nginx.org/en/docs/ngx_core_module.html)
</details>
<details>
<summary><strong>OpenSSL</strong></summary>

 - [man openssl](https://linux.die.net/man/1/openssl)
 - [man openssl req](https://www.openssl.org/docs/man1.0.2/man1/openssl-req.html)
</details>

<a href="#top"><img src="./readme_img/top.png" align="right"></a>
<br>

## WordPress + php-fpm

Subject : A Docker container that contains WordPress (it must be installed and configured) and php-fpm only without nginx.

### Dockerfile
	
	FROM debian:stable

	RUN apt update -y && apt install -y php-fpm curl php-mysql

	COPY ./tools/entry.sh /entry.sh
	RUN chmod +x /entry.sh

	EXPOSE 9000

	ENTRYPOINT ["./entry.sh"]

#### Base image

Specifies the base image for the Docker container.

#### Install `php-fpm`, `curl` and `php-mysql`

`apt update` : Update available packages.

`apt install php-fpm` : Install *php-fpm* (PHP FastCGI Process Manager), used to execute PHP scripts on a web server.

##

**php-fpm** is designed to efficiently handle many simultaneous requests.<br>
This is a variant of PHP that will run in the background as a daemon, listening for CGI requests.

**FastCGI** is a protocol allowing communication between a web server and an external programs.

##

`curl` : Install *curl*, a  tool for transferring data from or to a server.

`php-mysql` : Install *php-mysql*, it is a PHP extension that allows PHP scripts to interact with MySQL databases.

##

We need **php-mysql** because Wordpress uses MySQL database to stock all the data, articles, pages, users etc. Without, Wordpress could not connect to the database and work properly.

##

`-y` : Used to automatically answer 'yes' to all prompt during the execution of the command and avoid manually confirming each action.

#### Copying script

From local file in `./tools/entry.sh`<br>
to `/entry.sh` at the root of the container.

[script entry.sh details](#script)

#### Make the script executable

`chmod +x /entry.sh` in the container to make the script executable.

#### Port 9000

Documentation on which port need to be expose.<br>
`9000` is generally the default port for php-fpm to listen at the server requests.

#### Entrypoint

When the container starts, it executes `entry.sh`.

[script entry.sh details](#script)


<a href="#top"><img src="./readme_img/top.png" align="right"></a>
<br>

---

### Script

	#!/bin/sh

	path=/var/www/html

	sed -i 's/listen\s*=\s*\/run\/php\/php8.2-fpm.sock/listen = 0.0.0.0:9000/' /etc/php/8.2/fpm/pool.d/www.conf

	curl -s -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	mv wp-cli.phar /usr/local/bin/wp

	rm -f $path/index.nginx-debian.html

	if [ ! "$(ls -A  $path)" ]; then

		wp core download --allow-root --path=$path --quiet

		cd $path
		wp config create --allow-root --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASSWD --dbhost=$WP_HOST_DB --quiet

		wp core install --allow-root --path=$path --url=$DOMAIN_NAME --title="Inception" --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASSWD --admin_email=$WP_ADMIN_EMAIL

		wp user create --allow-root --path=$path $WP_USER $WP_EMAIL --user_pass=$WP_PASSWD --role=$WP_USER_ROLE --quiet

	fi

	php-fpm8.2 -F -y /etc/php/8.2/fpm/php-fpm.conf


This script starts running at the start up of the container. His main purpose is to create the database for WordPress from the WP-CLI and start php-fpm in the foreground.

`path=/var/www/html` : WordPress container and NGINX container share a persisting volume which is located at `/var/www/html`.

#### Modify configuration file

**`sed -i 's/listen\s*=\s*\/run\/php\/php8.2-fpm.sock/listen = 0.0.0.0:9000/' /etc/php/8.2/fpm/pool.d/www.conf`**

This command line allows to replace `listen` in a configuration file from php-fpm because it's set to `/run/php/php8.2-fpm.sock` and sockets are used to local communication and our server is not in the same container, so we replace by `0.0.0.0:9000` to listen on all the network interfaces on port 9000.

`sed` : is used to perform basic text transformations on an input stream.

`-i` : edit files in place (directly in the file without producing copy).

**`s/listen\s*=\s*\/run\/php\/php8.2-fpm.sock/listen = 0.0.0.0:9000/`**

`s/<regexp>/<replacement>/` : if `<regexp>` is find, replace that portion matched with `<replacement>`.

`<regexp>` -> `listen\s*=\s*\/run\/php\/php8.2-fpm.sock` : search for `listen = /run/php/php8.2-fpm.sock`.<br> `\s*` stand for all the spaces that can be around the `=` and the others `\` to escape the `/`.<br>
`<replacement>` -> `listen = 0.0.0.0:9000`

`/etc/php/8.2/fpm/pool.d/www.conf` : path of the configuration file we need to modify.

#### Get WP-CLI

`curl -s -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar`

`curl` : get data from the following URL.<br>
`-s` : silent option. <br>
`-O` : save that data into a local file. <br>
`https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar` : URL of the WP-CLI Phar file from the official repository.

## 

A **Phar** file (**PH**P **Ar**chive) is an archive format for storing PHP packages that can be manipulated without decompression.

**WP-CLI** is the command-line interface for WordPress. WP-CLI provides a command-line interface for many actions you might perform in the WordPress admin.

##

`chmod +x wp-cli.phar` : makes the downloaded file executable.

`mv wp-cli.phar /usr/local/bin/wp` : moves the executable to `usr/local/bin/wp` so it can be run from anywhere.

`rm -f $path/index.nginx-debian.html` : deletes the default NGINX index page if it exists.

#### Set up WordPress with WP-CLI

**`if [ ! "$(ls -A  $path)" ]; then`** 

Checks if the directory `/var/www/html` is empty. If it is empty, the following commands are executed. If it's not it means that the Wordpress is already set up, it is possible because we have a persisting volume.

`wp core download --allow-root --path=$path --quiet` : downloads the latest WordPress version into the specified directory (`/var/www/html`) and allow downloads from root user. 

`wp config create --allow-root --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASSWD --dbhost=$WP_HOST_DB --quiet` : generates the configuration file `wp-config.php` and set up the database credentials for our installation.

`wp core install --allow-root --path=$path --url=$DOMAIN_NAME --title="Inception" --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASSWD --admin_email=$WP_ADMIN_EMAIL` : installs WordPress with the specified site URL, title and admin user credentials.

`wp user create --allow-root --path=$path $WP_USER $WP_EMAIL --user_pass=$WP_PASSWD --role=$WP_USER_ROLE --quiet` : creates an additional WordPress user with the specified username, email, password and role.

**`fi`**

#### Start php-fpm

`php-fpm8.2 -F -y /etc/php/8.2/fpm/php-fpm.conf` : starts *php-fpm*, `-y` using the configuration file located at `/etc/php/8.2/fpm/php-fpm.conf`, `-F` force to stay in foreground and ignore daemonize option from configuration file (`/etc/php/8.2/fpm/php-fpm.conf`).


<a href="#top"><img src="./readme_img/top.png" align="right"></a>
<br>

---


### Documentations

<details>
<summary><strong>Wordpress</strong></summary>

 - [WP-CLI How to install](https://make.wordpress.org/cli/handbook/how-to/how-to-install/)
 - [WP-CLI user create](https://developer.wordpress.org/cli/commands/user/create/)
 - [WP-CLI commands](https://developer.wordpress.org/cli/commands/)
</details>

<details>
<summary><strong>PHP-FPM</strong></summary>

 - [man php-fpm](https://linux.die.net/man/8/php-fpm)
 - [FPM conf](https://www.php.net/manual/en/install.fpm.configuration.php)
</details>

<details>
<summary><strong>Others</strong></summary>

 - [man curl](https://www.man7.org/linux/man-pages/man1/curl.1.html)
</details>



<a href="#top"><img src="./readme_img/top.png" align="right"></a>
<br>


<!-- 

			MARIADB

 -->


## MariaDB

Subject : A Docker container that contains MariaDB only without nginx.

### Dockerfile


	FROM debian:stable

	RUN apt update -y && apt install -y mariadb-server

	COPY ./tools/setup_db.sh /
	RUN chmod +x setup_db.sh

	EXPOSE 3306

	ENTRYPOINT ["./setup_db.sh"]

#### Base image

Specifies the base image for the Docker container.

#### Install `mariadb-server`

`apt update` : Update available packages.

`apt install mariadb-server` : Install *mariadb-server*, a database management system, allowing to create, manage and interact with databases.

#### Copying script and make it executable

From local file in `./tools/setup_db.sh`<br>
to `/setup_db.sh` at the root of the container.

`chmod +x setup_db.sh` : make the script executable in the container.

[script setup_db.sh details](#script-1)

#### Port 3306

Documentation on which port need to be expose.<br>
`3306` is generally the default port for MariaDB.

#### Entrypoint

When the container starts, it executes `setup_db.sh`.

[script setup_db.sh details](#script-1)

<a href="#top"><img src="./readme_img/top.png" align="right"></a>
<br>

---

### Script

	#!/bin/sh

	sed -i 's/bind-address\s*=\s*127\.0\.0\.1/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

	service mariadb start

	sleep 2

	echo "CREATE DATABASE $DB_NAME;" | mariadb
	echo "CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWD';" | mariadb
	echo "GRANT ALL ON $DB_NAME.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWD' WITH GRANT OPTION;" | mariadb
	echo "GRANT ALL ON $DB_NAME.* TO 'root'@'%' IDENTIFIED BY '$DB_ROOT_PASSWD' WITH GRANT OPTION;" | mariadb
	echo "FLUSH PRIVILEGES;" | mariadb

	service mariadb stop

	mysqld_safe

This script starts running at the start up of the container. His main purpose is to configure and initialize a MariaDB database server.

#### Modify configuration file

**`sed -i 's/bind-address\s*=\s*127\.0\.0\.1/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf`**

This command line allows to replace `bind-address` in a configuration file from mariadb because it's set to `127.0.0.1` (localhost) and we need to listen to `0.0.0.0` (all the network interfaces).

`sed` : is used to perform basic text transformations on an input stream.

`-i` : edit files in place (directly in the file without producing copy).

**`s/bind-address\s*=\s*127\.0\.0\.1/bind-address = 0.0.0.0/`**

`s/<regexp>/<replacement>/` : if `<regexp>` is find, replace that portion matched with `<replacement>`

`<regexp>` -> `bind-address\s*=\s*127\.0\.0\.1` : search for `bind-address = 127.0.0.1`.<br> `\s*` stand for all the spaces that can be around the `=` and the others `\` to escape the dots.<br>
`<replacement>` -> `bind-address = 0.0.0.0`

`/etc/mysql/mariadb.conf.d/50-server.cnf` : path of the file we need to modify.

#### Start mariadb

`service mariadb start` : starting mariadb service.

`sleep 2` : pauses the script for 2 seconds to ensure that the mariadb service has enough time to start.

#### Create Database and Users

All the variables uses in this script are imported in the environment variables of the container from the .env file.

As we are in a script we can't use mariadb in interactive mode so we use pipes to pass the output to `mariadb` command, which executes it on the MariaDB server.

`echo "CREATE DATABASE $DB_NAME;" | mariadb` : create database with the name from the environment variable `$DB_NAME`.

`echo "CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWD';" | mariadb` : create a new user with the username stored in the env var `$DB_USER` and the password stored in the env var `$DB_PASSWD`.

`echo "GRANT ALL ON $DB_NAME.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWD' WITH GRANT OPTION;" | mariadb` : grant all privileges on the specified database to the new user.

`echo "GRANT ALL ON $DB_NAME.* TO 'root'@'%' IDENTIFIED BY '$DB_ROOT_PASSWD' WITH GRANT OPTION;" | mariadb` : grant all privileges on the specified database to the `root` user.

`echo "FLUSH PRIVILEGES;" | mariadb` : ensures that all changes take effect immediately.

#### Restart MariaDB server

`service mariadb stop` : stopping the mariadb service.

`mysqld_safe` : start mariadb server in foreground.


<a href="#top"><img src="./readme_img/top.png" align="right"></a>
<br>

---

### Documentations

<details>
<summary><strong>Sed</strong></summary>

 - [man sed](https://linux.die.net/man/1/sed)
</details>

<details>
<summary><strong>Database</strong></summary>

 - [WordPress with MariaDB](https://mariadb.com/es/resources/blog/how-to-install-and-run-wordpress-with-mariadb/)
 - [Create database](https://mariadb.com/kb/en/create-database/)
 - [Create user](https://mariadb.com/kb/en/create-user/)
 - [Grant privileges](https://mariadb.com/kb/en/grant/)
 - [mysqld_safe](https://dev.mysql.com/doc/refman/8.0/en/mysqld-safe.html)
</details>

<a href="#top"><img src="./readme_img/top.png" align="right"></a>
<br>

## Volumes

### Wordpress database

Subject : A volume that contains your WordPress database

<a href="#top"><img src="./readme_img/top.png" align="right"></a>
<br>

---

### Wordpress website files

Subject : A volume that contains your WordPress website files.


<a href="#top"><img src="./readme_img/top.png" align="right"></a>
<br>

## Docker compose

<a href="#top"><img src="./readme_img/top.png" align="right"></a>
<br>

## Docker network

Subject : A **docker network** that establishes the connection between containers.


<a href="#top"><img src="./readme_img/top.png" align="right"></a>
<br>

## Makefile


<a href="#top"><img src="./readme_img/top.png" align="right"></a>
<br>
