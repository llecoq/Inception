#!/bin/sh

# download wp-cli command line tool for interacting with and managing WordPress sites.
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
# make it an executable file and move it to the local /bin
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# if WordPress isn't already installed and configured : 
if [ ! -e /var/www/html/wp-config.php ]
	then
		# download WordPress core
		wp core download --path=${WORDPRESS_PATH}
		# create wp-config.php that will link WordPress to the database
		wp config create --dbname=${DB_NAME} \
						 --dbuser=${DB_USER} \
						 --dbpass=${DB_PASSWORD} \
						 --dbhost=${DB_HOST} \
						 --path=${WORDPRESS_PATH}
		# create admin user
		wp core install --url=${DOMAIN_NAME} \
						--title=${PROJECT_NAME} \
						--admin_user=${ADMIN_USER} \
						--admin_password=${ADMIN_PASSWORD} \
						--admin_email=${ADMIN_EMAIL} \
						--path=${WORDPRESS_PATH}
fi

exec "$@"