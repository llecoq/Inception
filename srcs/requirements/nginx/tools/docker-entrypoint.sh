#!/bin/sh

# For this project self-signed certificate is required but it is not recommended in production

# Generate self-signed certificate that is valid only 7 days everytime the server is launched
openssl req -newkey rsa:2048 -x509 -sha256 -days 7 -nodes \
	-keyout /etc/ssl/private/$DOMAIN_NAME.key \
	-out /etc/ssl/certs/$DOMAIN_NAME.crt \
	-subj "/C=$COUNTRY/ST=$STATE/L=$LOCALITY/O=$ORGANIZATION/OU=$ORGANIZATIONAL_UNIT/CN=$COMMON_NAME"

# Enable the new server block file by creating a symbolic link from the file to the sites-enabled directory:
ln -s /etc/nginx/sites-available/$DOMAIN_NAME.conf /etc/nginx/sites-enabled/

exec "$@"