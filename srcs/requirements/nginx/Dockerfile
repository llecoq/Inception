FROM alpine:3.14.6

RUN set -ux \
# Create user
    && adduser -D -g 'nginx' nginx \
# update and upgrade
	&& apk update \
	&& apk upgrade \
# install nginx and openssl
	&& apk add --no-cache \
		nginx \
		openssl \
# set ownership and permissions as required 
	&& chown nginx /var/run/ \
	&& chown -R nginx /etc/ssl

# run container as nginx user instead of root
USER nginx

# copy conf files into container
COPY /conf /etc/nginx
# copy docker-entrypoint.sh script that will be needed for configuration 
COPY /tools/docker-entrypoint.sh /

# launch docker-entrypoint script that will generate the self-signed ssl certificate
ENTRYPOINT [ "/docker-entrypoint.sh" ]

CMD [ "nginx", "-g", "daemon off;"]