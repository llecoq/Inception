FROM alpine:3.14.6

RUN set -ux \
# Create user and group that will be used to run the mariadb server
    && adduser -D -g 'wordpress' wordpress \
# update and upgrade / same as "apk -U upgrade"
	&& apk update \
	&& apk upgrade \
# install php and php-fpm
	&& apk add --no-cache \
		php7 \
		php7-fpm \
# install wordpress
	&& mkdir -m 0751 -p /var/www/html/ \
	&& cd /var/www/html/ \
	&& wget https://wordpress.org/wordpress-6.0.tar.gz \
	&& tar -xzvf wordpress-6.0.tar.gz \
# set ownership and permissions as required
	&& chown -R wordpress /var/www/html/ \
# remove cache and wordpress archive
	&& rm wordpress-6.0.tar.gz \
	&& rm /var/cache/apk/*

# copy docker-entrypoint.sh script that will be needed for configuration 
COPY /tools/docker-entrypoint.sh /

# launch docker-entrypoint script that configure WordPress
ENTRYPOINT [ "php-fpm7", "--nodaemonize" ]

# force FastCGI Process Manager to stay in foreground, and ignore daemonize option from config file
# CMD [ "php-fpm7", "--nodaemonize" ]