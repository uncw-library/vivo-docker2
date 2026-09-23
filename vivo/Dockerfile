FROM tomcat:9-jdk11-temurin-noble

RUN apt update && \
	apt install -y ca-certificates-java maven git tzdata gettext-base

# defaults; override at runtime via .env
ENV TZ="America/New_York"
ENV CATALINA_OPTS="-Xms1g -Xmx5g -XX:MaxMetaspaceSize=512m"

ARG GIT_BRANCH=rel-1.15-maint

WORKDIR /usr/local/
RUN git clone https://github.com/vivo-project/Vitro.git Vitro -b ${GIT_BRANCH} && \
	git clone https://github.com/vivo-project/VIVO.git vivo -b ${GIT_BRANCH}

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

# maven install
WORKDIR /usr/local/Vitro
RUN mvn clean install
WORKDIR /usr/local/vivo
RUN mvn clean install -s installer/settings.xml

# move vivo tomcat folder to ROOT tomcat folder
RUN mv /usr/local/tomcat/webapps/vivo/ /usr/local/tomcat/webapps/ROOT

# runtime.properties is rendered from this template + env vars at container start
COPY --chown=root:root ./installer/home/src/main/resources/config/runtime.properties.template /usr/local/vivo/home/config/runtime.properties.template
COPY --chown=root:root ./setenv.sh /usr/local/tomcat/bin/setenv.sh
COPY --chown=root:root --chmod=755 ./docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

WORKDIR /usr/local/vivo/home

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["catalina.sh", "run"]
