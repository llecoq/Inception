FROM alpine:3.14.6

RUN set -ux \
# Create user and group that will be used to run the mariadb server
    && adduser -D -g 'wordpress' wordpress \
# update and upgrade / same as "apk -U upgrade"
	&& apk update \
	&& apk upgrade \
# install php, php-fpm and php-mysql
	&& apk add --no-cache \
		php8 \
		php8-fpm \
		php8-mysqli \
# install wordpress
	&& mkdir -m 0755 -p /var/www/html/ \
	&& cd /var/www/html/ \
	&& wget https://wordpress.org/wordpress-6.0.tar.gz \
	&& tar --strip-components=1 -zxf wordpress-6.0.tar.gz \
# set ownership and permissions as required
	&& chown -R wordpress:wordpress /var/www/* \
	&& chown -R wordpress:wordpress /var/lib/php8 \
# remove cache and wordpress archive
	&& rm wordpress-6.0.tar.gz \
	&& rm /var/cache/apk/*

COPY /conf/www.conf /etc/php8/php-fpm.d/
# copy docker-entrypoint.sh script that will be needed for configuration 
COPY /tools/docker-entrypoint.sh /

# launch docker-entrypoint script that configure WordPress
# ENTRYPOINT [ "/docker-entrypoint.sh" ]
ENTRYPOINT [ "php-fpm8", "--nodaemonize" ]

# force FastCGI Process Manager to stay in foreground, and ignore daemonize option from config file
# CMD [ "php-fpm8", "--nodaemonize" ]