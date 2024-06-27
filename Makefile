# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: marvin <marvin@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/06/26 22:53:10 by marvin            #+#    #+#              #
#    Updated: 2024/06/27 12:47:26 by marvin           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

PATH_NGINX=./srcs/requirements/nginx


all :
	docker build ./srcs/requirements/nginx -t nginx
	docker run --name nginx -p443:443 nginx
