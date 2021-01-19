#!/bin/bash
# docker build -t web .
docker run --rm -d -p 80:80 -p 443:443 web 
name=$(docker ps | tail -1 | grep -o '[^ ]\+$')
docker container exec -u 0 -it $name bash
