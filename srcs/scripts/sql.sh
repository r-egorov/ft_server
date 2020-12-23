#!/bin/bash

if [[ `ps -acx|pgrep mysql|wc -l` -gt 1  ]]
then
	sleep 1s
	echo "CREATE DATABASE wordpress;"| mysql -u root --skip-password
	echo "CREATE USER 'ft_admin'@'localhost' IDENTIFIED BY 'ft_admin';"| mysql -u root --skip-password
	echo "GRANT ALL PRIVILEGES ON *.* TO 'ft_admin'@'localhost';"| mysql -u root --skip-password
	echo "FLUSH PRIVILEGES;"| mysql -u root --skip-password
	exit 0
else
	exit 1
fi
