# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: marvin <marvin@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/06/26 22:53:10 by marvin            #+#    #+#              #
#    Updated: 2024/06/28 17:02:38 by marvin           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

all : volume mariadb

nginx :
	docker build ./srcs/requirements/nginx -t nginx
	docker run --name nginx -p443:443 nginx

volume :
	docker volume create WP_files
	docker volume create DB

wordpress :
	docker build ./srcs/requirements/wordpress -t wordpress
	docker run -it --name wordpress -v WP_files:/var/www/html wordpress bash
# docker run --name wordpress -v WP_files:/data wordpress
# docker run -it --name wordpress -v WP_files:/data wordpress bash

mariadb :
	docker build ./srcs/requirements/mariadb -t mariadb
	docker run -it --name mariadb -v DB:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=1234 -p3306:3306 mariadb bash
# docker run --name mariadb -v DB:/data mariadb

fclean :
	docker stop $(shell docker ps -qa); \
	docker rm $(shell docker ps -qa); \
	docker rmi -f $(shell docker images -qa); \
	docker volume rm $(shell docker volume ls -q); \
	docker network rm $(shell docker network ls -q) 2> /dev/null

	# docker stop nginx
	# docker rm nginx
	# docker rmi nginx

	# docker volume rm WP_DB

	# docker stop wordpress
	# docker rm wordpress
	# docker rmi wordpress
