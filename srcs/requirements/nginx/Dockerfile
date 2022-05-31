FROM alpine:3.14.6

ENV DOMAIN_NAME "llecoq.42.fr"

RUN set -ux \
# Create user and group that will be used to run the server via nginx.conf file
    && adduser -D -g 'nginx' nginx \
# update and upgrade / same as "apk -U upgrade"
	&& apk update \
	&& apk upgrade \
# install nginx and openssl
	&& apk add --no-cache \
		nginx \
		openssl \
# set directories, ownership and permissions as required
	&& mkdir -m 0755 -p /var/www/html/ \
	&& mkdir -m 0751 -p /etc/nginx/sites-enabled/ \
	&& chown -R nginx:nginx /etc/nginx/ \
	# && chown -R nginx /var/www/${DOMAIN_NAME}/public_html/ \
# remove cache from update
	&& rm /var/cache/apk/*

# copy conf files into container
COPY /conf /etc/nginx
# copy docker-entrypoint.sh script that will be needed for configuration 
COPY /tools/docker-entrypoint.sh /

# launch docker-entrypoint script that will generate the self-signed ssl certificate
ENTRYPOINT [ "/docker-entrypoint.sh" ]

# tell nginx to stay in the foreground
CMD [ "nginx", "-g", "daemon off;"]
