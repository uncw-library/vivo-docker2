# Dockerized VIVO

This project creates two dockerized containers,
- `vivo` The vivo instance
- `solr` A standalone solr instance, based on a solr docker image

# Usage

## Example Docker Installation

Regardless of the usage, you will need to build the images, which require the following steps:

1. Linux: [Install](https://docs.docker.com/install/) Docker
1. Linux: [Install](https://docs.docker.com/compose/install/) Docker Compose
1. Windows/Mac: [Install](https://www.docker.com/products/docker-desktop) Docker Desktop
1. Clone this project
1. (optional)  Copy the tdbModels & tdbContentModels from your production instance into the matching folders in this repo.  This pulls in any changes made on the production site via the Admin panel to the dev box.
```bash
   rsync -avz yourname@servername.com:/path/to/vivo/home/tdbModels .
   rsync -avz yourname@servername.com:/path/to/vivo/home/tdbContentModels .
   sudo chown -R root:root tdbModels/ tdbContentModels/
```
1. Start the containers:
```bash
   docker-compose up --build
```
1. Rebuild the search index via the Admin menu if content is missing.

 Then navigate to [localhost:8080](http://localhost:8080)

## VIVO Runtime Example

The example [docker-compose.yml](docker-compose.yml) is a basic VIVO installation in docker. This file has two containers and uses the standard TBD system.  The files in ./vivo configure many of the vivo settings.  There is an example custom theme included. 

1. On first startup, log in with user: vivo_root@mydomain.edu password: rootPassword
1. Any users/instance data is preserved in docker bind mounted volumes to the tdb* volumes in this repo.
1. Subsequent `docker-compose down` and `docker-compose up --build` will retain the persistant docker volumes.
1. If you wish to start clean, `docker volume rm vivo-docker2_tdbContentModels vivo-docker2_tdbModels` will delete the volumes holding user/instance data.

## VIVO Development

Exposing the solr instance to localhost:8983 can be done by adding `ports: 8983:8983` to the solr section of docker-compose.yml

## Revising the Theme

You can disable the theme caching in the Site Admin page: "Activate developer Panel" / "Defeat the template cache".  Then, you can edit files in the "nemo" folder and see the changes in real time at localhost:8080.  On the next `docker-compose up --build` the changes will be baked into your vivo image.

## Production

Data persistance can be accomplished by bind volume mapping two container folders:

 - /usr/local/VIVO/home/tdbContentModels
 - /usr/local/VIVO/home/tdbModels

, or by perserving the docker volumes:

 - vivo-docker2_tdbContentModels
 - vivo-docker2_tdbModels


Dev note:  Thank you to the developers of earlier dockerized VIVO releases who laid the groundwork,

 - [vivo-docker](https://github.com/gwu-libraries/vivo-docker)
 - [vivo-docker2](https://github.com/vivo-community/vivo-docker2)


# Person Images portion

A GET request to http://sitename.com/file/n1234567890/personImage.jpg will load the file on the server at /usr/local/VIVO/home/uploads/file_storage_root/a\~n/123/456/789/0/personImage.jpg

The spliting of the large integer into groups of 3 is important.

So a file in ./person_images/123/456/789/0/personImage.jpg will map to the two locations above.

# Automatic import/refresh

Our use-case is:  One ttl file holds all the userdata.  Place it at ./current_turle/userdata.ttl.  When starting the vivo instance, userdata.ttl is autoimported into Vivo.   (Vivo autoimports any file in vivo/home/rdf/abox/filegraph/;  docker-compose mounts userdata.ttl into that folder).  

To do a data refresh, replace the userdata.ttl file with a new version.  Restarting Vivo will remove the previous data, and autoimport the new version.
