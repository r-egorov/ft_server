# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: cisis <marvin@42.fr>                       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/22 15:35:29 by cisis             #+#    #+#              #
#    Updated: 2020/12/23 16:30:36 by cisis            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

# Download the required stuff
RUN apt-get update && apt-get upgrade && apt-get install -y \
		wget \
		supervisor \
		nginx \
		mariadb-server mariadb-client \
		php7.3 php-mysql php-fpm php-pdo php-gd php-cli php-mbstring

# Install PHP, phpMyAdmin and create a directory for php-fpm.sock
WORKDIR /var/www/html/
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-english.tar.gz
RUN tar -xf phpMyAdmin-5.0.4-english.tar.gz && rm -rf phpMyAdmin-5.0.4-english.tar.gz
RUN mv phpMyAdmin-5.0.4-english phpmyadmin
RUN mkdir /run/php/ -p

# Install Wordpress
WORKDIR /var/www/html/
RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xf latest.tar.gz && rm -rf latest.tar.gz

# Copy the configs
COPY ./srcs/configs/nginx.conf /etc/nginx/sites-available/
COPY ./srcs/configs/supervisor.conf /etc/supervisor/conf.d/supervisord.conf
COPY ./srcs/configs/php-myadmin.config.php /var/www/html/phpmyadmin/config.inc.php
COPY ./srcs/configs/wp-config.php /var/www/html/wordpress/

# Make the directories for logs, scripts and SSH
RUN mkdir /logs/
RUN mkdir /opt/run/

# Copy the scripts and give the necessary permissions
COPY ./srcs/scripts/*.sh /opt/run/
RUN chmod 755 /opt/run/*.sh

# Set up a password for the root user
# RUN echo 'root:ft_server' | chpasswd

# Configure the NGINX
WORKDIR /etc/nginx/sites-enabled
RUN rm default
RUN ln -s ../sites-available/nginx.conf

# The necessary ports
EXPOSE 80
EXPOSE 443

#RUN chown -R www-data:www-data *
#RUN chmod -R 755 /var/www/*

# Run the supervisor daemon on the foreground
ENTRYPOINT ["/usr/bin/supervisord"]
