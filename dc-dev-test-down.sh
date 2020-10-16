#!/usr/bin/bash

# Removes and rebuilds all vivo images, containers, volumes, etc.

docker-compose down
docker image rm vivo-docker2_solr:latest vivo-docker2_vivo:latest 
docker system prune -f
docker volume prune  -f
docker-compose up --build -d && docker-compose down && docker-compose up -d && docker-compose logs -f

