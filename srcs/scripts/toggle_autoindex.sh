#!/bin/bash
initial_state=$(cat /etc/nginx/sites-available/ft_server.conf | \
	grep -oP '(?<=autoindex )[^ ]*' | tr -d ';')
if [ "$initial_state" == "on" ]; then
	sed -i 's/autoindex on/autoindex off/g' \
		/etc/nginx/sites-available/ft_server.conf
	sed -i 's/#index index.html index.htm index.php index.nginx-debian.html;/index index.html index.htm index.php index.nginx-debian.html;/g' \
		/etc/nginx/sites-available/ft_server.conf

else
	sed -i 's/autoindex off/autoindex on/g' \
		/etc/nginx/sites-available/ft_server.conf
	sed -i 's/index index.html index.htm index.php index.nginx-debian.html;/#index index.html index.htm index.php index.nginx-debian.html;/g' \
		/etc/nginx/sites-available/ft_server.conf
fi
nginx -s reload
