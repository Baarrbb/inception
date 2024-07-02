# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: marvin <marvin@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/06/26 22:53:10 by marvin            #+#    #+#              #
#    Updated: 2024/07/02 17:43:51 by marvin           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

all :
# @ sudo rm -rf /home/bsuc
	@ sudo mkdir -p /home/bsuc/data/db
	@ sudo mkdir -p /home/bsuc/data/wp_files
	@ docker compose -f ./srcs/docker-compose.yml up

fclean :
	@ sudo rm -rf /home/bsuc
	@ docker ps -qa | xargs docker stop 2> /dev/null || true
	@ docker ps -qa | xargs docker rm 2> /dev/null || true
	@ docker images -qa | xargs docker rmi -f 2> /dev/null || true
	@ docker volume ls -q | xargs docker volume rm 2> /dev/null || true
	@ docker network ls -q | xargs docker network rm 2> /dev/null || true
