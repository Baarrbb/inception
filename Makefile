# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: marvin <marvin@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/06/26 22:53:10 by marvin            #+#    #+#              #
#    Updated: 2024/06/27 14:13:38 by marvin           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


all :
	docker build ./srcs/requirements/nginx -t nginx
	docker run --name nginx -p443:443 nginx

fclean :
	docker stop nginx
	docker rm nginx
	docker rmi nginx
