
## Dockerfile

	FROM debian:stable

	RUN apt update -y && apt install -y nginx openssl
	RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/private.key -out /etc/ssl/certs/certificate.crt -subj "/C=/ST=/L=/O=/OU=/CN="


	COPY ./conf/nginx.conf /etc/nginx/nginx.conf

	EXPOSE 443

	RUN 

	CMD ["/usr/sbin/nginx", "-g", "daemon off;"]

On install nginx et openssl avec **RUN**<br>

`apt update` -> pour mettre a jour les paquets disponibles.
`apt install nginx openssl` -> pour installer nginx (requit par le sujet) et openssl pour generer des certificats numerique pour securise communication.
<br>
On genere ensuite les certificats dont on a besoin pour mettre en place le protocol TLS avec :<br>
`openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/private.key -out /etc/ssl/certs/certificate.crt -subj "/C=/ST=/L=/O=/OU=/CN="'



TLS
: Transport Layer Security<br>
Assure la confidentialité, l'intégrité et l'authenticité des données transmises entre un client et un serveur<br>


On genere les certificats 

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