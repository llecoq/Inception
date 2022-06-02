# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: llecoq <llecoq@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/04/28 12:53:40 by llecoq            #+#    #+#              #
#    Updated: 2022/04/28 12:53:42 by llecoq           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

include ./srcs/.env
.EXPORT_ALL_VARIABLES:

CONTAINERS = nginx mariadb wordpress

all: volume
	sudo docker compose -p inception -f srcs/docker-compose.yml up -d --build

stop:
	sudo docker stop $(CONTAINERS)

down: stop
	sudo docker compose -f srcs/docker-compose.yml down

clean: down
	sudo docker system prune

fclean: down
	sudo docker system prune -a -f

re: fclean all

sh_nginx: all
	sudo docker exec -it nginx sh

sh_mariadb: all
	sudo docker exec -it mariadb sh

volume: /home/${LOGIN}/data/DB /home/${LOGIN}/data/WordPress

/home/${LOGIN}/data/DB:
	mkdir -p /home/${LOGIN}/data/DB

/home/${LOGIN}/data/WordPress:
	mkdir -p /home/${LOGIN}/data/WordPress

.PHONY:	all stop clean fclean re sh_nginx sh_mariadb