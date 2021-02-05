# Dockerized VIVO

This project creates two dockerized containers,
- `vivo` The vivo instance
- `solr` A standalone solr instance, based on a solr docker image

# Usage

## Example Docker Installation

Regardless of the usage, you will need to build the images, which require the following steps:

1. [Install](https://docs.docker.com/install/) Docker
1. [Install](https://docs.docker.com/compose/install/) Docker Compose
1. Clone this project
1. Start the containers:
```bash
   docker-compose up --build
```

## VIVO Runtime Example

The example [docker-compose.yml](docker-compose.yml) is a basic VIVO installation in docker. This file has two containers and uses the standard TBD system.  The files in ./vivo configure many of the vivo settings.  There is an example custom theme included. 

```bash
docker-compose up --build
```
 
 Then navigate to [localhost:8080/vivo](http://localhost:8080/vivo)


1. On first startup, log in with user: vivo_root@mydomain.edu password: rootPassword
2. Any users/instance data is preserved in docker volumes: tdbModels and tdbContentModels.
3. Subsequent `docker-compose down` and `docker-compose up --build` will use the persistant docker volumes.
4. If you wish to start clean, `docker volume rm vivo-docker2_tdbContentModels vivo-docker2_tdbModels` will delete those volumes.


## VIVO Development

Exposing the solr instance to localhost:8983 can be done by adding `ports: 8983:8983` to the solr section of docker-compose.yml


## Production

Data persistance can be accomplished by mapping localhost folders to two container folders:

 - /usr/local/VIVO/home/tdbContentModels
 - /usr/local/VIVO/home/tdbModels

, or by perserving the docker volumes:

 - vivo-docker2_tdbContentModels
 - vivo-docker2_tdbModels


Dev note:  Thank you to the developers of earlier dockerized VIVO releases who laid the groundwork,

 - [vivo-docker](https://github.com/gwu-libraries/vivo-docker)
 - [vivo-docker2](https://github.com/vivo-community/vivo-docker2)

