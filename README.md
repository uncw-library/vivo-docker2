# Dockerized VIVO

This project creates two dockerized containers,
- `vivo-vivo` The vivo instance
- `vivo-solr` A standalone solr instance, based on a solr docker image

# Usage

## Example Docker Installation

Regardless of the usage, you will need to build the images, which require the following steps:

1. Linux: [Install](https://docs.docker.com/install/) Docker
1. Linux: [Install](https://docs.docker.com/compose/install/) Docker Compose
1. Windows/Mac: [Install](https://www.docker.com/products/docker-desktop) Docker Desktop
1. Git Clone this project

## Build the docker images

1. Your custom theme like ./vivo/uncw_theme is included in the docker image.
1. Your config files at ./vivo/config are include in the docker image.
1. Your vivo container will serve from http://localhost:8080/
1. `docker build --no-cache -t libapps-admin.uncw.edu:8000/vivo-docker2/vivo ./vivo`
1. `docker build --no-cache -t libapps-admin.uncw.edu:8000/vivo-docker2/solr ./solr`

When satisfied with your dev box, build and push the images to production

## Production env

Assumes the docker images are already built/pushed.

Our servers are 'libapps' and 'libapps-dev'.  git clone this repo onto your server, then git checkout the branch 'libapps' or 'libapps-dev'

Make sure there is a `current_turtle/userdata.ttl` file.  even an empty file with that name is ok.

```
docker compose up vivo-solr -d     {wait 1 minute}
docker compose up -d
docker compose exec vivo-vivo tail /usr/local/tomcat/logs/vivo.all.log -f    {to follow the log output} 
```


## Development env

1. Place a userdata.ttl graph file into ./current_turtle.  It will be autoimported into vivo on `docker compose up`.  The file is gitignored.  Replacing userdata.ttl with a newer version will autoupdate the vivo data on `docker compose down && docker compose up`
1. (optional)  Create a custom theme, following the './vivo/uncw_theme' folder.  Revise ./vivo/Dockerfile and docker-compose.yml lines including uncw_theme.
1. Start the containers:
```bash
   docker compose up vivo-solr -d    { wait 1 minute }
   docker compose up vivo-vivo -d
   docker compose exec vivo-vivo tail /usr/local/tomcat/logs/vivo.all.log -f
   { watch the vivo-vivo logs }
```

1. Watch [localhost:8080](http://localhost:8080) until the site is up.
1. Rebuild the search index via logging into the Admin menu if the frontend does not display your instance data.
1. NOTE:  After doing any theme or configfile changes, you must do a `docker build` step before pushing to production.  Docker Compose only temporarily overlays those folders onto the containers.  `docker build` bakes those changes into the image.
1. `docker compose exec -it vivo-vivo bash` will get you inside the running container.

## VIVO Runtime Example

The example [docker-compose.yml](docker-compose.yml) is a basic VIVO installation in docker. This file has two containers and uses the standard TBD system.  The files in ./vivo configure many of the vivo settings.  There is an example custom theme included. 

1. On first startup, log in with the user named in ./vivo/configs/runtime.properties
1. Any users/instance data is preserved in docker bind mounted volumes to the ./tdb* folders in this repo.
1. Subsequent `docker compose down` and `docker compose up` will retain the persistant docker volumes.
1. If you wish to start clean, `docker volume rm vivo-docker2_solr_data` will delete the volume holding solr data.  And `rm ./tdbContentModels/*.*` and `rm ./tdbModels/*.*` will delete the vivo data.

## Solr access for dev

In the docker-compose.yml, adding a `ports: 8983:8983` will expose the solr instance to localhost:8983.  The build otherwise makes solr unreachable everywhere except from the vivo container.


## Revising the Theme

A custom theme lives at ./vivo/uncw_theme  It is included in the docker container during 'docker build'
You can copy another theme into a sister folder, then tell docker-compose.yml and Dockerfile about it.

You can disable the theme caching in the Site Admin page: "Activate developer Panel" / "Defeat the template cache".  Then, you can edit files in the theme folder to see the changes in real time at localhost:8080.  On the next `docker build` the changes will be baked into your vivo image.


# Person Images portion

A GET request to http://sitename.com/file/n1234567890/personImage.jpg will load the file on the server at /usr/local/VIVO/home/uploads/file_storage_root/a\~n/123/456/789/0/personImage.jpg

The spliting of the large integer into groups of 3 is important.

So a file in ./uploads/file_storage_root/a~n/123/456/789/0/personImage.jpg will map to the two locations above.

# Automatic import/refresh

Our use-case is:  One ttl file holds all the userdata.  Place it at ./current_turle/userdata.ttl.  When starting the vivo instance, userdata.ttl is autoimported into Vivo.   (Vivo autoimports any file in vivo/home/rdf/abox/filegraph/;  docker-compose mounts userdata.ttl into that folder).  

To do a data refresh, replace the userdata.ttl file with a new version.  Restarting Vivo will remove the previous data, and autoimport the new version.


Acknowledgements:  Thank you to the developers of earlier dockerized VIVO releases who laid the groundwork,

 - [vivo-docker](https://github.com/gwu-libraries/vivo-docker)
 - [vivo-docker2](https://github.com/vivo-community/vivo-docker2)