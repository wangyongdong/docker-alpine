#!/bin/sh

# parameters
MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD:-""}

if [ ! -d "/run/mysqld" ]; then
    echo '[i] MySQL run dir create /run/mysqld'
	mkdir -p /run/mysqld
	chmod -R 777 /run/mysqld
fi
#
#if [ ! -a "/var/log/mysql/error.log" ]; then
#	touch /var/log/mysql/error.log
#	chmod -R 777 /var/log/mysql/error.log
#fi
#
#if [ ! -a "/var/log/mysql/slow_query.log" ]; then
#	touch /var/log/mysql/slow_query.log
#	chmod -R 777 /var/log/mysql/slow_query.log
#fi

if [ -d /var/lib/mysql/mysql ]; then
	echo '[i] MySQL directory already present, skipping creation'
else
	echo "[i] MySQL data directory not found, creating initial DBs"

#    chmod -R 777 /var/lib/mysql/mysql

	# init database
	echo 'Initializing database'
	mysql_install_db --user=root > /dev/null
	echo 'Database initialized'

	echo "[i] MySql root password: $MYSQL_ROOT_PASSWORD"

	# create temp file
	tfile=`mktemp`
	if [ ! -f "$tfile" ]; then
	    return 1
	fi

	# save sql
	echo "[i] Create temp file: $tfile"
	cat << EOF > $tfile
USE mysql;
FLUSH PRIVILEGES;
DELETE FROM mysql.user;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION;
DROP DATABASE IF EXISTS test;
EOF

	echo 'FLUSH PRIVILEGES;' >> $tfile

	# run sql in tempfile
	echo "[i] run tempfile: $tfile"
	/usr/bin/mysqld --user=root --bootstrap --verbose=0 < $tfile
	rm -f $tfile
fi

echo "[i] Sleeping 3 sec"
sleep 3

echo '[i] start running mysqld'
exec /usr/bin/mysqld --user=root --console