#!/bin/sh
set -ex

# 
if [ ! -d /var/lib/mysql/$DB_NAME ];
	then
		# install/initialize MySQL database / equivalent of /etc/init.d/mariadb setup
		mysql_install_db --user=mysql --datadir=/var/lib/mysql
		# start mariadb server
		/usr/share/mariadb/mysql.server start
		# secure installation of mariadb / same steps as mariadb-secure-installation script :
		# set database root password, delete anonymous user, ensure the root user can not log in remotely,
		# remove the test database and flush the privileges tables.
		mysql --user=root <<_EOF_
		ALTER USER 'root'@'localhost' IDENTIFIED BY ${DB_ROOT_PASSWORD};
		DELETE FROM mysql.user WHERE User='';
		DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
		DROP DATABASE IF EXISTS test;
		DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
		FLUSH PRIVILEGES;
		_EOF_
fi

# exec "$@"