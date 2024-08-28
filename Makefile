# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: marvin <marvin@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/06/26 22:53:10 by marvin            #+#    #+#              #
#    Updated: 2024/08/28 18:49:48 by marvin           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


# This is a minimal set of ANSI/VT100 color codes
_END=\033[0;0m
_BOLD=\033[0;1m
_UNDER=\033[0;4m
_REV=\033[0;7m

# Colors
_GREY=\033[0;30m
_RED=\033[0;31m
_GREEN=\033[0;32m
_YELLOW=\033[0;33m
_BLUE=\033[0;34m
_PURPLE=\033[0;35m
_CYAN=\033[0;36m
_WHITE=\033[0;37m

# Inverted, i.e. colored backgrounds
_IGREY=\033[0;40m
_IRED=\033[0;41m
_IGREEN=\033[0;42m
_IYELLOW=\033[0;43m
_IBLUE=\033[0;44m
_IPURPLE=\033[0;45m
_ICYAN=\033[0;46m
_IWHITE=\033[0;47m

# Color test
_ROSE=\x1b[38;5;213m
_NEW_BLUE=\x1b[38;5;80m
_NEW_YELLOW=\x1b[38;5;228m
_GREEN_BOLD=\033[1;32m
_LIGHT_GREY=\x1b[38;5;242m


all :
	@ sudo mkdir -p /home/bsuc/data/db
	@ sudo mkdir -p /home/bsuc/data/wp_files
	@ sudo mkdir -p /home/bsuc/data/static_files
	@ sudo mkdir -p /home/bsuc/data/monitor_files
	@ sudo mkdir -p /home/bsuc/data/log
	@ sudo mkdir -p /home/bsuc/data/portainer
# @ sudo mkdir -p /home/bsuc/data/prom_data
# @ sudo mkdir -p /home/bsuc/data/graf_data
	@ docker compose -f ./srcs/docker-compose.yml up -d

fclean :
	@ sudo rm -rf /home/bsuc
	@ docker ps -qa | xargs docker stop 2> /dev/null || true
	@ docker ps -qa | xargs docker rm 2> /dev/null || true
	@ docker images -qa | xargs docker rmi -f 2> /dev/null || true
	@ docker volume ls -q | xargs docker volume rm 2> /dev/null || true
	@ docker network ls -q | xargs docker network rm 2> /dev/null || true

clean : stop
	@ docker ps -qa | xargs docker rm 2> /dev/null || true
	@ docker images -qa | xargs docker rmi -f 2> /dev/null || true

restart : clean all

stop :
	@ docker ps -qa | xargs docker stop 2> /dev/null || true

kill :
	@ docker ps -qa | xargs docker kill 2> /dev/null || true

ftp :
	lftp -u anonymous bsuc.42.fr -e "set ssl:verify-certificate no;"

logs :
	@ echo "$(_YELLOW)--- MARIADB LOGS ---$(_END)"
	@ docker logs mariadb
	@ echo "$(_YELLOW)--- WORDPRESS LOGS ---$(_END)"
	@ docker logs wordpress
	@ echo "$(_YELLOW)--- NGINX LOGS ---$(_END)"
	@ docker logs nginx

	@ echo "$(_YELLOW)--- REDIS LOGS ---$(_END)"
	@ docker logs redis
	@ echo "$(_YELLOW)--- ADMINER LOGS ---$(_END)"
	@ docker logs adminer
	@ echo "$(_YELLOW)--- FTP LOGS ---$(_END)"
	@ docker logs ftp
	@ echo "$(_YELLOW)--- STATIC LOGS ---$(_END)"
	@ docker logs static
	@ echo "$(_YELLOW)--- MONITORIX LOGS ---$(_END)"
	@ docker logs monitorix
	@ echo "$(_YELLOW)--- PROMETHEUS LOGS ---$(_END)"
	@ docker logs prometheus
	@ echo "$(_YELLOW)--- NGINX-EXPORTER LOGS ---$(_END)"
	@ docker logs nginx-exporter
	@ echo "$(_YELLOW)--- GRAFANA LOGS ---$(_END)"
	@ docker logs grafana
# @ echo "$(_YELLOW)--- CADVISOR LOGS ---$(_END)"
# @ docker logs cadvisor
	@ echo "$(_YELLOW)--- PORTAINER LOGS ---$(_END)"
	@ docker logs portainer

re: fclean all

# re: restart
