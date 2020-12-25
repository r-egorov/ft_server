#!/bin/bash
initial_state=$(cat /etc/nginx/sites-available/ft_server.conf | grep -oP '(?<=autoindex )[^ ]*' | tr -d ';')
if [ "$initial_state" == "on" ]; then
	sed -i 's/autoindex on/autoindex off/g' /etc/nginx/sites-available/ft_server.conf
else
	sed -i 's/autoindex off/autoindex on/g' /etc/nginx/sites-available/ft_server.conf
fi
service nginx stop
