# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: marvin <marvin@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/06/26 22:53:10 by marvin            #+#    #+#              #
#    Updated: 2024/06/27 18:25:35 by marvin           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


all : volume wordpress

nginx :
	docker build ./srcs/requirements/nginx -t nginx
	docker run --name nginx -p443:443 nginx

volume :
	docker volume create WP_files
	docker volume create DB

wordpress :
	docker build ./srcs/requirements/wordpress -t wordpress
	docker run -it --name wordpress wordpress bash
	# docker run --name wordpress -v WP_files:/data wordpress
# docker run -it --name wordpress -v WP_DB:/data wordpress bash

mariadb :
	docker build ./srcs/requirements/maraidb -t mariadb
	docker run --name mariadb -v DB:/data mariadb

fclean :
	# docker stop nginx
	# docker rm nginx
	# docker rmi nginx

	# docker volume rm WP_DB

	# docker stop wordpress
	# docker rm wordpress
	# docker rmi wordpress
