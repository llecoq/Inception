FROM alpine:3.14.6

RUN set -ux \
# Create user and group that will be used in the php-fpm www.conf file
    && adduser -D -g 'wordpress' wordpress \
# update and upgrade / same as "apk -U upgrade"
	&& apk update \
	&& apk upgrade \
# install the bare minimum needed for this project (mariadb client, php-fpm, php and its dependencies)
	&& apk add --no-cache \
		php8 \
		php8-fpm \
		php8-mysqli \
		php8-phar \
		php8-iconv \
		mariadb-client \
# download wp-cli command line tool for interacting with and managing WordPress sites.
		&& echo "Downloading WordPress command line tool..." \
		&& wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
# make it an executable file and move it to the local /bin
		&& chmod +x wp-cli.phar \
		&& mv wp-cli.phar /usr/local/bin/wp \
		&& echo "... wp-cli is ready to use !" \
# symlink php8 to php
	&& ln -s /usr/bin/php8 /usr/bin/php \
# set ownership and permissions as required
	&& mkdir -m 0751 -p /var/www/html/ \
	&& chown -R wordpress /var/www/html \
	&& chown -R wordpress /var/lib/php8 \
	&& chown -R wordpress /var/log/php8 \
# remove cache
	&& rm /var/cache/apk/*

COPY /conf/www.conf /etc/php8/php-fpm.d/
# copy docker-entrypoint.sh script that will be needed for configuration 
COPY /tools/docker-entrypoint.sh /

# launch docker-entrypoint script that configure WordPress
ENTRYPOINT [ "/docker-entrypoint.sh" ]

# force FastCGI Process Manager to stay in foreground, and ignore daemonize option from config file
CMD [ "php-fpm8", "--nodaemonize" ]