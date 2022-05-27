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
	&& mkdir -m 0751 -p /usr/share/webapps/ \
	&& cd /usr/share/webapps/ \
	&& wget https://wordpress.org/wordpress-6.0.tar.gz \
	&& tar -xzvf wordpress-6.0.tar.gz \
# set ownership and permissions as required
	&& chown -R wordpress /usr/share/webapps/ \
# remove cache and wordpress archive
	&& rm wordpress-6.0.tar.gz \
	&& rm /var/cache/apk/*

# copy docker-entrypoint.sh script that will be needed for configuration 
COPY /tools/docker-entrypoint.sh /

# launch docker-entrypoint script that configure WordPress
ENTRYPOINT [ "/docker-entrypoint.sh" ]

# tell nginx to stay in the foreground
# CMD [ "nginx", "-g", "daemon off;"]