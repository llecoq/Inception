#!/bin/sh

# Required
domain=llecoq.42.fr
commonname=$domain

# Company details
country=FR
state=Auvergne-Rhone-Alpes
locality=Lyon
organization="42 Lyon"
organizationalunit=IT
email=llecoq@student.42lyon.fr

# Optional
# password=mypassword

# For this project self-signed certificate is required but it is not recommended in production

# Generate self-signed certificate that is valid only 7 days everytime the server is launched
mkdir /etc/ssl/private
openssl req -newkey rsa:2048 -x509 -sha256 -days 7 -nodes \
	-keyout /etc/ssl/private/$domain.key \
	-out /etc/ssl/certs/$domain.crt \
	-subj "/C=$country/ST=$state/L=$locality/O=$organization/OU=$organizationalunit/CN=$commonname/emailAddress=$email"

exec "$@"