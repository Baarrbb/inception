
## Dockerfile

	FROM debian:stable

	RUN apt update -y && apt install -y nginx openssl
	RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/private.key -out /etc/ssl/certs/certificate.crt -subj "/C=/ST=/L=/O=/OU=/CN="

	COPY ./conf/nginx.conf /etc/nginx/nginx.conf

	EXPOSE 443

	CMD ["/usr/sbin/nginx", "-g", "daemon off;"]

## RUN

**RUN** est utilise pour executer des commandes pendant la phase de build

### On install `nginx` et `openssl`

`apt update` -> pour mettre a jour les paquets disponibles.

`apt install nginx openssl` -> pour installer nginx (requit par le sujet) et openssl pour generer des certificats numerique pour securise communication.

### On genere certificats pour protocole TLS

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

## COPY
On copie la configuration de nginx.<br>
On a besoin d'une configuration specifique de nginx pour repondre au sujet. On a donc notre conf en local et on copie cette configuration dans notre image docker a l'emplacement souhaite.

`COPY ./conf/nginx.conf /etc/nginx/nginx.conf`

## EXPOSE
On a besoin que notre container ecoute sur le port 443. Mais ca n'expose pas vraiment le port, c'est plutot pour documenter notre image et indiquer que lorsque qu'on run notre image on doit exposer le port specifie.

## CMD
**CMD** est utilise pour spécifier la commande par défaut à exécuter lorsqu'un conteneur basé sur l'image est démarré.

`CMD ["/usr/sbin/nginx", "-g", "daemon off;"]`

revient a 

`/usr/sbin/nginx -g "daemon off;"`<br>
`-g` -> set des directives de configuration globale.
`daemon off` ->  signifie que nginx s'exécutera en avant-plan dans le conteneur plutôt que de fonctionner comme un service en arrière-plan.


## nginx.conf

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




Bien que vous ayez exposé le port 443, cela ne signifie pas que ce port sera accessible depuis l'extérieur du conteneur par défaut. Pour que le port soit accessible, il doit être publié lors du démarrage du conteneur à l'aide de l'option -p ou --publish de la commande docker run.
 l'instruction EXPOSE dans Docker est utilisée pour documenter les ports sur lesquels le conteneur écoute, facilitant ainsi la configuration et l'utilisation appropriées du conteneur lors de son déploiement et de son utilisation avec Docker.