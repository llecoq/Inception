#!/bin/sh

# Set bind-address so MySQL can bind to all networks and make sure skip-networking is off
echo "Setting up mariadb-server configuration file so it can bind to remote network..."
sed -ie 's/#bind-address/bind-address/g' /etc/my.cnf.d/mariadb-server.cnf
sed -ie 's/skip-networking/#skip-networking/g' /etc/my.cnf.d/mariadb-server.cnf
echo "... Success !"

# set up and run new database if it doesn't already exist in the shared volume
# else start server via Dockerfile CMD
if [ ! -d /var/lib/mysql/${DB_NAME} ];
	then
		echo "Database does not exist yet."
		# install/initialize MySQL database / equivalent of /etc/init.d/mariadb setup
		mysql_install_db --user=${DB_USER} --datadir=/var/lib/mysql
		# start mariadb server
		/usr/share/mariadb/mysql.server start
		# secure installation of mariadb / same steps as mariadb-secure-installation script :
		# set database root password, delete anonymous user, ensure the root user can not log in remotely,
		# remove the test database and flush the privileges tables.
		# Creating new database and granting privileges to the DB user with renote access;
		mysql --user=root <<_EOF_
		ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';
		DELETE FROM mysql.user WHERE User='';
		DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
		DROP DATABASE IF EXISTS test;
		DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
		CREATE DATABASE IF NOT EXISTS ${DB_NAME};
		GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
		FLUSH PRIVILEGES;
_EOF_
		mysqladmin --user=root --password=$DB_ROOT_PASSWORD shutdown
	else
		echo "Database is already installed and configured !"
fi

echo "Starting up mariadb's server..."

exec "$@"