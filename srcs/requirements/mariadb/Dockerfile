FROM alpine:3.14.6

RUN set -ux \
# Create user
    && adduser -D -g 'mysql' mysql \
# update and upgrade
	&& apk update \
	&& apk upgrade \
# install mariadb
	&& apk add --no-cache \
		mariadb \
		mariadb-client 
# set ownership and permissions as required 
	# && mkdir /var/lib/mysql \
	# && chown -R mysql /var/lib/mysql

# run container as mysql user instead of root
# USER mysql

COPY /tools/docker-entrypoint.sh /

# ENTRYPOINT [ "/bin/sh", "/docker-entrypoint.sh" ]

# CMD ["mysqld"]
