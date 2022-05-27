#!/bin/sh
set -ex

# set up and run new database if it doesn't already exist in the shared volume
# else start server via Dockerfile CMD
if [ ! -d /var/lib/mysql/${DB_NAME} ];
	then
		# install/initialize MySQL database / equivalent of /etc/init.d/mariadb setup
		mysql_install_db --user=mysql --datadir=/var/lib/mysql
		# start mariadb server
		/usr/share/mariadb/mysql.server start
		# secure installation of mariadb / same steps as mariadb-secure-installation script :
		# set database root password, delete anonymous user, ensure the root user can not log in remotely,
		# remove the test database and flush the privileges tables.
		# Creating new database and granting privileges to the DB user;
		mysql --user=root <<_EOF_
		ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';
		DELETE FROM mysql.user WHERE User='';
		DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
		DROP DATABASE IF EXISTS test;
		DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
		CREATE DATABASE IF NOT EXISTS ${DB_NAME};
		GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASSWORD}';
		FLUSH PRIVILEGES;
_EOF_
else
	exec "$@"
fi