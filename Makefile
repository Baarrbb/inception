
define NGINX_CONF
events {
		worker_connections 2;
}
http {
	server {
		listen 80;
		server_name localhost;
		location / {
			root /usr/share/nginx/html;
			index index.html index.htm;
		}
	}
}
endef
export NGINX_CONF

PATH_NGINX=./srcs/requirements/nginx/nginx.conf


all :
	@ echo "$$NGINX_CONF" > $(PATH_NGINX)
	sudo docker build ./srcs/requirements/nginx -t nginx