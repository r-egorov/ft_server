#!/bin/bash
name=$(docker ps | tail -1 | grep -o '[^ ]\+$')
docker kill $name
docker system prune -f
