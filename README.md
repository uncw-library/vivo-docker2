# Dockerized VIVO

This project creates two dockerized containers,
- `vivo-vivo` The vivo instance
- `vivo-solr` A standalone solr instance, based on a solr docker image

And three docker mounted volumes:
- `solr-data`
- `tdbModels`
- `tdbContentModels`

(works on Mac arm64 and Windows/Linux amd64)

# Usage

## Set up your computer

Regardless of the usage, you will need to build the images, which require the following steps:

1. Linux: [Install](https://docs.docker.com/install/) Docker
1. Linux: [Install](https://docs.docker.com/compose/install/) Docker Compose
1. Windows/Mac: [Install](https://www.docker.com/products/docker-desktop) Docker Desktop
1. Git Clone this project

## Build the docker images

1. Your custom theme, config files, and custom rdfs are baked into the vivo-vivo image.  See our examples in the ./vivo/inject/ folder.
1. `docker compose build`

## Development env

1. Ensure ./instanceData/turtles contains a file called `userdata.ttl` and one called `featuredFaculty.ttl`
    
    `touch ./instanceData/turtles/userdata.ttl && touch ./instanceData/turtles/featuredFaculty.ttl`
    - even empty files with that name is ok.
    - otherwise docker-compose will make empty folders with those names, which may be annoying.
1. (optional)  Configure & customize your instance as noted in the Lyrasis Vivo wiki.
1. (optional)  Create a custom theme, following the uncw_theme or wilma_uncw in ./vivo/inject.  
Revise ./vivo/Dockerfile and docker-compose.yml lines to add the theme folder.
1. Build the images:
    ```bash
    docker compose build
    ```
1. Start the containers:
    ```bash
    docker compose up -d
    ```
1. Watch the vivo logs:
    ```bash
    docker compose exec vivo-vivo tail /usr/local/tomcat/logs/vivo.all.log -f
    ```

1. Site at [localhost:8080](http://localhost:8080)
1. To wipe the box & start fresh:
    ```bash
    docker compose down
    docker volume rm vivo-docker2_solr-data vivo-docker2_tdbModels vivo-docker2_tdbContentModels 
    ```
    - then goto step 4.

1. When satisfied with your dev box, rebuild the images and push to production.  

## Production env

Assumes the docker images are already built/pushed.

UNCW's servers are 'libapps' and 'libapps-dev'.  git clone this repo onto your server, then git checkout the branch 'libapps' or 'libapps-dev'

Otherwise, same steps as above #Development env.




## VIVO app admin

1. On first startup, log in with the user named in ./vivo/inject/vivo_home/config/runtime.properties
1. Any vivo users/instance data is preserved in docker volumes: vivo-docker2_tdbModels and vivo-docker2_tdbContentModels.
1. Solr data is preserved in docker volume: vivo-docker2_solr-data.
1. Subsequent `docker compose down` and `docker compose up` will preserve the tdb data and solr data.
1. If you wish to start clean, `docker volume rm vivo-docker2_solr-data` will delete the volume holding solr data.  And `docker volume rm tdbContentModels tdbModels` will clear that data.  Start from step 1 after  the next `docker compose up`

## Solr access for dev

In the docker-compose.yml, adding a `ports: 8983:8983` will expose the solr instance to localhost:8983.  The build otherwise makes solr unreachable everywhere except from the vivo container.


## Revising the Theme

A custom theme lives at ./vivo/uncw_theme  It is included in the docker container during 'docker build'
You can copy another theme into a sister folder, then tell docker-compose.yml and Dockerfile about it.

You can disable the theme caching in the Site Admin page: "Activate developer Panel" / "Defeat the template cache".  Then, you can edit files in the theme folder to see the changes in real time at localhost:8080.  On the next `docker build` the changes will be baked into your vivo image.


## Person Images creation

A GET request to http://sitename.com/file/n1234567890/personImage.jpg will load the file on the server at /usr/local/vivo/home/uploads/file_storage_root/a\~n/123/456/789/0/personImage.jpg

The spliting of the large integer into groups of 3 is important.

So, a file in this repo's ./instanceData/uploads/file_storage_root/a~n/123/456/789/0/personImage.jpg maps to the two locations above.

We use vivo_data_update app to fetch and organize the person images into ./siteData/uploads/

## Automatic import/refresh

Our use-case is:
- One userdata.ttl file (turtle fileformat), created outside of Vivo, holding all the site data for profiles.  Place it at ./instanceData/turtles/userdata.ttl.  When starting the vivo instance, userdata.ttl is autoingested into Vivo.
- One folder with profile images, created outside of Vivo.  Place it at ./instanceData/uploads.  Check that the namespaces file in that folder has your site's namespace.
- One featuredFaculty.ttl file, created outside of Vivo, holding site data for our custom FeaturedFaculty homepage display.  Place it at ./instanceData/turtles/featuredFaculty.ttl.

To do a data refresh, replace some files in ./instanceData with a new version.  Restarting Vivo autoupdates any changes.


# Acknowledgements:  
Thank you to the developers of earlier dockerized VIVO releases who laid the groundwork,
 - [vivo-docker](https://github.com/gwu-libraries/vivo-docker)
 - [vivo-docker2](https://github.com/vivo-community/vivo-docker2)