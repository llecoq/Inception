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

all:
	sudo docker compose -f srcs/docker-compose.yml up -d --build

stop:
	sudo docker compose -f srcs/docker-compose.yml down

clean: stop
	sudo docker system prune

fclean: stop
	sudo docker system prune -a -f

re: fclean all

sh_nginx: all
	sudo docker exec -it nginx sh

sh_mariadb: all
	sudo docker exec -it mariadb sh

.PHONY:	all stop clean fclean re sh_nginx sh_mariadb