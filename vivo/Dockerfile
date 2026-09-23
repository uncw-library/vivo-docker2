## ---- build stage: compile Vitro + VIVO with maven ----
FROM maven:3.9-eclipse-temurin-11-noble AS build

ARG GIT_BRANCH=rel-1.15-maint

# Vitro has no local customizations, so build it first; this layer stays cached
# when only files under ./vivo change. /root/.m2 is a BuildKit cache mount so
# downloaded dependencies are reused across builds without landing in the image.
WORKDIR /usr/local/
RUN git clone https://github.com/vivo-project/Vitro.git Vitro -b ${GIT_BRANCH}
WORKDIR /usr/local/Vitro
RUN --mount=type=cache,target=/root/.m2 mvn clean install

WORKDIR /usr/local/
RUN git clone https://github.com/vivo-project/VIVO.git vivo -b ${GIT_BRANCH}

## insert customizations to vivo git repo ./installer before maven install
WORKDIR /usr/local/vivo/
COPY --chown=root:root ./api/src/main/java/org/vivoweb/webapp/sitemap/SiteMapServlet.java ./api/src/main/java/org/vivoweb/webapp/sitemap/SiteMapServlet.java

COPY --chown=root:root ./installer/settings.xml ./installer/settings.xml

COPY --chown=root:root ./installer/home/src/main/resources/config/applicationSetup.n3 ./installer/home/src/main/resources/config/applicationSetup.n3

COPY --chown=root:root ./installer/home/src/main/resources/rdf/applicationMetadata/firsttime/initialSiteConfig.rdf ./installer/home/src/main/resources/rdf/applicationMetadata/firsttime/initialSiteConfig.rdf
COPY --chown=root:root ./installer/home/src/main/resources/rdf/display/everytime/homePageDataGetters.n3 ./installer/home/src/main/resources/rdf/display/everytime/homePageDataGetters.n3
COPY --chown=root:root ./installer/home/src/main/resources/rdf/display/everytime/searchIndexerConfigurationVivo.n3 ./installer/home/src/main/resources/rdf/display/everytime/searchIndexerConfigurationVivo.n3
COPY --chown=root:root ./installer/home/src/main/resources/rdf/display/firsttime/menu.n3 ./installer/home/src/main/resources/rdf/display/firsttime/menu.n3
COPY --chown=root:root ./installer/home/src/main/resources/rdf/i18n/en_US/display/firsttime/aboutPage.n3 ./installer/home/src/main/resources/rdf/i18n/en_US/display/firsttime/aboutPage.n3
COPY --chown=root:root ./installer/home/src/main/resources/rdf/i18n/en_US/interface-i18n/firsttime/vivo_UiLabel_wilma_uncw.ttl ./installer/home/src/main/resources/rdf/i18n/en_US/interface-i18n/firsttime/vivo_UiLabel_wilma_uncw.ttl
COPY --chown=root:root ./installer/home/src/main/resources/rdf/tbox/firsttime/featuredProfileOntology.n3 ./installer/home/src/main/resources/rdf/tbox/firsttime/featuredProfileOntology.n3
COPY --chown=root:root ./installer/home/src/main/resources/rdf/tbox/firsttime/wos.n3 ./installer/home/src/main/resources/rdf/tbox/firsttime/wos.n3

COPY --chown=root:root ./installer/webapp/pom.xml ./installer/webapp/pom.xml
COPY --chown=root:root ./installer/webapp/src/main/java/com/wokinfo/vivo/dataservice ./installer/webapp/src/main/java/com/wokinfo/vivo/dataservice
COPY --chown=root:root ./installer/webapp/src/main/webapp/themes/uncw_theme ./installer/webapp/src/main/webapp/themes/uncw_theme
COPY --chown=root:root ./installer/webapp/src/main/webapp/themes/wilma_uncw ./installer/webapp/src/main/webapp/themes/wilma_uncw
COPY --chown=root:root ./installer/webapp/src/main/webResources/WEB-INF/classes/log4j.properties ./installer/webapp/src/main/webResources/WEB-INF/classes/log4j.properties

# maven install: writes the webapp to /usr/local/tomcat/webapps/vivo and
# VIVO home to /usr/local/vivo/home (tomcat-dir / vivo-dir in settings.xml)
RUN mkdir -p /usr/local/tomcat/webapps
RUN --mount=type=cache,target=/root/.m2 mvn clean install -s installer/settings.xml


## ---- runtime stage: tomcat + the built webapp and VIVO home only ----
FROM tomcat:9-jdk11-temurin-noble

RUN apt-get update && \
	apt-get install -y --no-install-recommends tzdata gettext-base && \
	rm -rf /var/lib/apt/lists/*

# defaults; override at runtime via .env
ENV TZ="America/New_York"
ENV CATALINA_OPTS="-Xms1g -Xmx5g -XX:MaxMetaspaceSize=512m"

# deploy vivo as the ROOT webapp
COPY --from=build /usr/local/tomcat/webapps/vivo /usr/local/tomcat/webapps/ROOT
COPY --from=build /usr/local/vivo/home /usr/local/vivo/home

# runtime.properties is rendered from this template + env vars at container start
COPY --chown=root:root ./installer/home/src/main/resources/config/runtime.properties.template /usr/local/vivo/home/config/runtime.properties.template
COPY --chown=root:root ./setenv.sh /usr/local/tomcat/bin/setenv.sh
COPY --chown=root:root --chmod=755 ./docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

WORKDIR /usr/local/vivo/home

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["catalina.sh", "run"]
