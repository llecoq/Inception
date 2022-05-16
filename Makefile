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
	docker compose -f srcs/docker-compose.yml up -d

stop:
	docker compose -f srcs/docker-compose.yml down

clean: stop
	docker system prune -a

fclean: stop
	docker system prune -f

re: clean all

sh_nginx: all
	docker exec -it -t srcs-nginx-1 sh

.PHONY:	all stop clean fclean re sh_nginx