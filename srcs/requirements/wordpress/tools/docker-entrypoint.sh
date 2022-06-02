#!/bin/sh

# download wp-cli command line tool for interacting with and managing WordPress sites.
echo "Downloading WordPress command line tool..."
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
# make it an executable file and move it to the local /bin
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp
echo "... wp-cli is ready to use !"

# bash script for checking whether WordPress is installed or not 
if ! wp core is-installed --path=${WORDPRESS_PATH} 1>&2;
	then
		# download WordPress core
		echo "WordPress is not installed yet. Downloading wp core..."
		wp core download --path=${WORDPRESS_PATH}
	
		# create wp-config.php that will link WordPress to the database
		echo "Creating a new wp-config.php with database constants, and verifying that the database constants are correct..."
		wp config create --dbname=${DB_NAME} \
						 --dbuser=${DB_USER} \
						 --dbpass=${DB_PASSWORD} \
						 --dbhost=${DB_HOST} \
						 --path=${WORDPRESS_PATH}
		# create admin user
		echo "Creating the WordPress tables in the database using the URL, title, and default admin user details provided..."
		wp core install  --url=${DOMAIN_NAME} \
						 --title=${PROJECT_NAME} \
						 --admin_user=${ADMIN_USER} \
						 --admin_password=${ADMIN_PASSWORD} \
						 --admin_email=${ADMIN_EMAIL} \
						 --skip-email \
						 --path=${WORDPRESS_PATH}
	else
		echo "WordPress is already installed and properly configured !"
fi

echo "Starting up FastCGI Process Manager..."
exec "$@"