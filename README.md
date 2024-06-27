
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

`apt install nginx openssl` -> pour installer nginx (requit par le sujet) et openssl pour generer des certificats numerique pour securise les communications.

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

SSL
: Secure Socket Layer

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
`-g` -> set des directives de configuration globale.<br>
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


### `events`

Section qui configure les parametres lies aux evenements du serveur nginx.

`worker_connections` -> definit le nb max de connexions simultanees que chaque processus worker peut gerer.

------

voir cb de worker_processes par defaut

------


### `http`

definit la conf pour protocol http

### `server`

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

---------

Voir fichier dans /usr/share/nginx/html dans container mais dans mon souvenir il y a que index.html donc on peut virer les autres.

-------

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
