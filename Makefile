# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: marvin <marvin@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/06/26 22:53:10 by marvin            #+#    #+#              #
#    Updated: 2024/06/27 00:08:58 by marvin           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

define NGINX_CONF
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
	}
}
endef
export NGINX_CONF

# server {
# 	listen 80;
# 	server_name localhost;
# 	return 301 https://localhost;
# }
#curl -v -L http://localhost

PATH_NGINX=./srcs/requirements/nginx



all :
	@ mkdir $(PATH_NGINX)/certificates
	@ openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout $(PATH_NGINX)/certificates/private.key -out $(PATH_NGINX)/certificates/certificate.crt -subj "/C=/ST=/L=/O=/OU=/CN="
	@ echo "$$NGINX_CONF" > $(PATH_NGINX)/nginx.conf
	docker build ./srcs/requirements/nginx -t nginx
	docker run -p443:443 nginx

fclean :
	rm -rf $(PATH_NGINX)/certificates
	rm -rf $(PATH_NGINX)/nginx.conf