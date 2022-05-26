FROM alpine:3.14.6

RUN set -ux \
# Create user and group that will be used to run the mariadb server
    && adduser -D -g 'mysql' mysql \
# update and upgrade / same as "apk -U upgrade"
	&& apk update \
	&& apk upgrade \
# install mariadb and its client
	&& apk add --no-cache \
		mariadb \
		mariadb-client \
# remove cache form update
	&& rm /var/cache/apk/* \
# set ownership and permissions as required
	&& mkdir /var/lib/mysql \
	&& chmod 0751 /var/lib/mysql \
	&& chown -R mysql /var/lib/mysql

COPY /tools/docker-entrypoint.sh /

# launch docker-entrypoint script that will start and configure the mariadb server
ENTRYPOINT [ "/docker-entrypoint.sh" ]

# MySQL Server Startup Script with safety features
CMD ["/usr/bin/mysqld_safe"]
