#!/bin/bash
name=$(docker ps | tail -1 | grep -o '[^ ]\+$')
docker container exec -u 0 -it $name bash
