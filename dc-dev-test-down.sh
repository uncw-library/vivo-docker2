# WARNING! - Only for development testing! May remove items outside of vivo-docker2 scope.

docker-compose down
docker image rm vivo-docker2_solr:latest vivo-docker2_vivo:latest 
docker system prune -f
docker volume prune  -f
docker-compose up --build -d && docker-compose down && docker-compose up -d && docker-compose logs -f

