# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: cisis <marvin@42.fr>                       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/22 15:35:29 by cisis             #+#    #+#              #
#    Updated: 2020/12/22 18:22:38 by cisis            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

RUN apt-get update && apt-get upgrade && apt-get install -y \
		wget \
		supervisor \
		nginx \
		mariadb-server mariadb-client \
		php7.3 php-mysql php-fpm php-pdo php-gd php-cli php-mbstring

COPY ./srcs/ft_server_nginx.conf /etc/nginx/sites-available/
COPY ./srcs/supervisor.conf /etc/supervisor/conf.d/supervisord.conf

WORKDIR /etc/nginx/sites-enabled
RUN rm default
RUN ln -s ../sites-available/ft_server_nginx.conf

WORKDIR /var/www/html/
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-english.tar.gz
RUN tar -xf phpMyAdmin-5.0.4-english.tar.gz && rm -rf phpMyAdmin-5.0.4-english.tar.gz
RUN mv phpMyAdmin-5.0.4-english phpMyAdmin

CMD ["/usr/bin/supervisord"]
