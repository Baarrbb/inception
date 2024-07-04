# INCEPTION

Broaden knowledge of system administration by using Docker.
Virtualize several Docker images and set up a small infrastructure composed of different services. Each service has to run in a dedicated container.


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


<!-- ## [Docker CLI Basic commands](./COMMAND.md)
 - [Images](https://github.com/Baarrbb/inception/blob/master/COMMAND.md#images)
 - [Containers](https://github.com/Baarrbb/inception/blob/master/COMMAND.md#containers)
 - [Volumes](https://github.com/Baarrbb/inception/blob/master/COMMAND.md#volumes)
 - [Networks](https://github.com/Baarrbb/inception/blob/master/COMMAND.md#networks) -->

## Docker CLI basic commands

### Images
 - List images<br>

		$ docker images
 - Remove an image

		$ docker rmi [ID]
 - Remove all images

		$ docker rmi -f $(docker images -qa)
### Containers
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
 - Exec cmd in a container

		$ docker exec [ID] [cmd] [args]
### Volumes
 - List volumes

		$ docker volume ls
 - Remove a volume

		$ docker volume rm [ID]
 - Remove all volumes

		$ docker volume rm $(docker volume ls -q)
### Networks
 - List networks

		$ docker network ls
 - Remove a network

		$ docker network rm [ID]
 - Remove all networks

		$ docker network rm $(docker network ls -q)


##
##

#### How Docker work ?

#### How docker compose work ?

#### Difference between a Docker image used with docker compose and without ?

#### Benefit of Docker compared to VM ?

#### Pertinence of the directory structure ?

##
##

# Services

## A Docker container that contains NGINX with TLSv1.2 or TLSv1.3 only

- [Nginx](./srcs/requirements/nginx/README.md)

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

![Schema](./readme_img/schema.png)

