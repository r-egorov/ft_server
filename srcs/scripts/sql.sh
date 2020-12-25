#!/bin/bash

if [[ `service mysql status | grep Uptime` ]]
then
	mysql < /opt/run/sql_script.sql
	mysql < /var/www/html/phpmyadmin/sql/create_tables.sql
	exit 0
else
	exit 1
fi
