# sed -i "s/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/" "/etc/php/7.3/fpm/pool.d/www.conf";
# chown -R www-data:www-data /var/www/*;
# chown -R 755 /var/www/*;
# mkdir -p /run/php/;
# touch /run/php/php7.3-fpm.pid;

exec "$@"