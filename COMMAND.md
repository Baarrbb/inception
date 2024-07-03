## Sections
 - [Images](#images)
 - [Containers](#containers)
 - [Volumes](#volumes)
 - [Networks](#networks)

##
##

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