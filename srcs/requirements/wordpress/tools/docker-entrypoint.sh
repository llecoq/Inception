#!/bin/sh

# bash script for checking whether WordPress is installed or not 
if ! wp core is-installed --path=${WORDPRESS_PATH};
	then
		# download WordPress core
		echo "WordPress is not installed yet. Downloading wp core..."
		wp core download --path=${WORDPRESS_PATH}

		# checking if the database is ready and reachable
		until mysql --host=mariadb --user=${DB_USER} --password=${DB_PASSWORD} -e "exit";
			do
				echo "Database is not ready yet."
				sleep 1
		done

		# create wp-config.php that will link WordPress to the database
		echo "Creating a new wp-config.php with database constants, and verifying that the database constants are correct..."
		wp config create --dbname=${DB_NAME} \
						 --dbuser=${DB_USER} \
						 --dbpass=${DB_PASSWORD} \
						 --dbhost=${DB_HOST} \
						 --path=${WORDPRESS_PATH}
	
		# create WordPress tables in the database and the admin user
		echo "Creating the WordPress tables in the database using the URL, title, and default admin user details provided..."
		wp core install  --url=${DOMAIN_NAME} \
						 --title=${PROJECT_NAME} \
						 --admin_user=${ADMIN_USER} \
						 --admin_password=${ADMIN_PASSWORD} \
						 --admin_email=${ADMIN_EMAIL} \
						 --skip-email \
						 --path=${WORDPRESS_PATH}
		
		# create wordpress user
		wp user create ${WORDPRESS_USER} ${WORDPRESS_USER_EMAIL} \
						 --user_pass=${WORDPRESS_USER_PASSWORD} \
						 --role=${WORDPRESS_USER_ROLE} \
						 --path=${WORDPRESS_PATH}

	else
		echo "WordPress is already installed and properly configured !"
fi

echo "Starting up FastCGI Process Manager..."
exec "$@"