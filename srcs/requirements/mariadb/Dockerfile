FROM alpine:3.14.6

RUN set -ux \
# create mysql user and group 
    && adduser -D -g 'mysql' mysql \
# update and upgrade / same as "apk -U upgrade"
	&& apk update \
	&& apk upgrade \
# install mariadb and its client
	&& apk add --no-cache \
		mariadb \
		mariadb-client \
# remove cache from update
	&& rm /var/cache/apk/* \
# set ownership and permissions as required
	&& mkdir -m 0751 -p /var/lib/mysql \
	&& chown -R mysql:mysql /var/lib/mysql

# copy script needed to setup mariadb
COPY /tools/docker-entrypoint.sh /

# launch docker-entrypoint script that will set up the database and start the mariadb daemon
ENTRYPOINT [ "/docker-entrypoint.sh" ]

# MySQL Server Startup Script with safety features
CMD ["/usr/bin/mysqld_safe"]
