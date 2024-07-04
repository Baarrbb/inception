# INCEPTION

Broaden knowledge of system administration by using Docker.
Virtualize several Docker images and set up a small infrastructure composed of different services. Each service has to run in a dedicated container.

# Table of contents
 1. [Docker basics](#docker-basics)
	- [Dockerfile](#dockerfile)
	- [Images](#images)
	- [Containers](#containers)
	- [Docker compose](#docker-compose)
	- [Docker CLI basic commands](#docker-cli-basic-commands)
	- [Questions](#questions)
 2. [Services](#services)
	- [NGINX with TLSv1.3](#a-docker-container-that-contains-nginx-with-tlsv12-or-tlsv13-only)
	- [WordPress + php-fpm](#a-docker-container-that-contains-wordpress--php-fpm-only)
	- [MariaDB](#a-docker-container-that-contains-mariadb-only)
 3. [Volumes]()
	- [WordPress database]()
	- [WordPress website files]()
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

## A Docker container that contains NGINX with TLSv1.2 or TLSv1.3 only

### Dockerfile

	FROM debian:stable

	RUN apt update -y && apt install -y nginx openssl
	RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/private.key -out /etc/ssl/certs/certificate.crt -subj "/C=/ST=/L=/O=/OU=/CN="

	COPY ./conf/nginx.conf /etc/nginx/nginx.conf

	EXPOSE 443

	CMD ["/usr/sbin/nginx", "-g", "daemon off;"]

### RUN

**RUN** est utilise pour executer des commandes pendant la phase de build

#### On install `nginx` et `openssl`

`apt update` -> pour mettre a jour les paquets disponibles.

`apt install nginx openssl` -> pour installer nginx (requit par le sujet) et openssl pour generer des certificats numerique pour securise les communications.

`-y` -> installation pas bloquante quand ca demande de confirmer que ca va installer tant de Mb sur la machine.


#### On genere certificats pour protocole TLS

On genere ensuite les certificats dont on a besoin pour mettre en place le protocol TLS avec :<br>
`openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/private.key -out /etc/ssl/certs/certificate.crt -subj "/C=/ST=/L=/O=/OU=/CN="`

`req` -> requete de certificat<br>
`-x509` -> genere certificat auto signe<br>
`-nodes` -> "No DES" ne pas chiffrer la cle prive avec un mdp<br>
`-days 365` -> duree de validite du certificat<br>
`-newkey rsa:2048` -> genere une nouvelle paire de cles privee/publique RSA avec une longueur de 2048 bits pour le certificat<br>
`-keyout ` -> chemin ou enregistrer la cle privee<br>
`-out ` -> chemin ou enregistrer le certificat<br>
`-subj "/C=/ST=/L=/O=/OU=/CN="` -> permet de specifier les informations relatives au certificat

TLS
: Transport Layer Security<br>
Assure la confidentialité, l'intégrité et l'authenticité des données transmises entre un client et un serveur<br>

SSL
: Secure Socket Layer

### COPY
On copie la configuration de nginx.<br>
On a besoin d'une configuration specifique de nginx pour repondre au sujet. On a donc notre conf en local et on copie cette configuration dans notre image docker a l'emplacement souhaite.

`COPY ./conf/nginx.conf /etc/nginx/nginx.conf`

### EXPOSE
On a besoin que notre container ecoute sur le port 443. Mais ca n'expose pas vraiment le port, c'est plutot pour documenter notre image et indiquer que lorsque qu'on run notre image on doit exposer le port specifie.

### CMD
**CMD** est utilise pour spécifier la commande par défaut à exécuter lorsqu'un conteneur basé sur l'image est démarré.

`CMD ["/usr/sbin/nginx", "-g", "daemon off;"]`

revient a 

`/usr/sbin/nginx -g "daemon off;"`<br>
`-g` -> set des directives de configuration globale.<br>
`daemon off` ->  signifie que nginx s'exécutera en avant-plan dans le conteneur plutôt que de fonctionner comme un service en arrière-plan.


### nginx.conf

	events {
		worker_connections 1024;
	}
	http {
		server {
			listen 443 ssl;

			server_name localhost;

			ssl_certificate /etc/ssl/certs/certificate.crt;
			ssl_certificate_key /etc/ssl/private/private.key;

			ssl_protocols TLSv1.3;

			location / {
				root /usr/share/nginx/html;
				index index.html index.htm;
			}
			location = /favicon.ico {
				log_not_found off;
			}
		}
	}


#### `events`

Section qui configure les parametres lies aux evenements du serveur nginx.

`worker_connections` -> definit le nb max de connexions simultanees que chaque processus worker peut gerer.


------

voir cb de worker_processes par defaut<br>
worker_processes par default = 1 ?

------


#### `http`

definit la conf pour protocol http

#### `server`

`listen 443 ssl;` -> indique a nginx d'ecouter sur le port 443 et d'utiliser ssl.<br>
`server_name localhost;` -> configure nom du server pour cette conf, icic localhost.<br>
`ssl_certificate /etc/ssl/certs/certificate.crt;` -> Specifie chemin vers le certificat SSL utilise par le serveur.
Emplacement ou on a copie dans le Dockerfile.<br>
`ssl_certificate_key /etc/ssl/private/private.key;` -> Specifie le chemin vers la cle privee correspondant au certificat SSL definit juste avant.
Emplacement ou on a copie dans le Dockerfile.<br>
`ssl_protocols TLSv1.3;` -> definit les protocoles SSL/TLS autorises pour les connexions securises. Ici uniquement TLSv1.3.<br>
`location / {}` -> definit la conf pour requete http entrante sur url correspondant a /<br>
`root /usr/share/nginx/html;` -> specifie repertoire racine a partir du quel nginx cherche les fichiers a afficher.<br>
`index index.html. index.htm;` -> fichiers index a afficher par defaut si aucun fichier specifique est demande dans l'url.<br>



`location = /favicon.ico {
	log_not_found off;
}` -> j'avais une erreur qui apparaissait quand je me connectais a localhost par rapport a favicon.ico, donc pour eviter que cette erreur apparaisse encore j'ai ajouter cette exceptionn.


#

A partir de la on peut faire tourner notre nginx dans le conteneur avec 

`docker build . -t nginx`

pour construire notre image a partid u dockerfile.<br>
`.` -> emplacement du dockerfile a build<br>
`-t nginx` -> donner un tag a notre image.

`docker run --name nginx -p443:443 nginx`

`--name nginx` -> on nomme notre container `nginx`<br>
`-p443:443` -> pour mapper le port du container sur le port hote. Donc le port 443 du container est expose sur notre port 443.<br>
`nginx` -> l'image a run (dans notre build on l'a nomme nginx avec `-t nginx`).

#

Maintenant notre container run comme il faut.
On peut verifier que les connexion en http (port 80) ne sont pas autorise avec :<br>
`curl -v http://localhost` -> connection refused<br>
`curl -v -k https://localhost` -> connexion au port 443 parfait.<br>
`-k` -> pour ignorer les problemes de certificats qui sont auto-signes.






## A Docker container that contains WordPress + php-fpm only

(it must be installed and configured)<br>
Without nginx

- [WordPress + php-fpm](./srcs/requirements/wordpress/README.md)

## A Docker container that contains MariaDB only

Without nginx

- [MariaDB](./srcs/requirements/mariadb/README.md)

##

### A volume that contains your WordPress database

### A volume that contains your WordPress website files

### A **docker network** that establishes the connection between containers.

##

<br>
<br>



