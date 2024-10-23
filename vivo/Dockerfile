FROM tomcat:9-jdk11-openjdk

RUN apt update && \
	apt install -y ca-certificates-java maven git tzdata

ENV TZ="America/New_York"
ENV CATALINA_OPTS="-Xms1g -Xmx5g -XX:MaxPermSize=2g"
ENV JAVA_OPTS="${JAVA_OPTS} -Dtdb:fileMode=direct"

ARG GIT_BRANCH=rel-1.15-maint

WORKDIR /usr/local/
RUN git clone https://github.com/vivo-project/Vitro.git Vitro -b ${GIT_BRANCH} && \
	git clone https://github.com/vivo-project/VIVO.git vivo -b ${GIT_BRANCH}

## insert customizations to vivo git repo ./installer before maven install
WORKDIR /usr/local/vivo/
COPY --chown=root:root ./inject/installer/settings.xml ./installer/settings.xml
COPY --chown=root:root ./inject/installer/webapp/pom.xml ./installer/webapp/pom.xml
COPY --chown=root:root ./inject/installer/webapp/src/main/java/com/wokinfo/vivo/dataservice ./installer/webapp/src/main/java/com/wokinfo/vivo/dataservice
COPY --chown=root:root ./inject/installer/webapp/src/main/java/org/vivoweb/webapp/sitemap/SiteMapServlet.java ./installer/webapp/src/main/java/org/vivoweb/webapp/sitemap/SiteMapServlet.java
COPY --chown=root:root ./inject/installer/webapp/src/main/webapp/themes/uncw_theme ./installer/webapp/src/main/webapp/themes/uncw_theme
COPY --chown=root:root ./inject/installer/webapp/src/main/webapp/themes/wilma_uncw ./installer/webapp/src/main/webapp/themes/wilma_uncw

# maven install
WORKDIR /usr/local/Vitro
RUN mvn install
WORKDIR /usr/local/vivo
RUN mvn clean package -s installer/settings.xml
RUN mvn install -s installer/settings.xml

## insert customizations to image $vivo_home after maven install
WORKDIR /usr/local/vivo/home
COPY --chown=root:root ./inject/vivo_home/config/runtime.properties ./config/runtime.properties
COPY --chown=root:root ./inject/vivo_home/config/applicationSetup.n3 ./config/applicationSetup.n3
COPY --chown=root:root ./inject/vivo_home/rdf/applicationMetadata/firsttime/initialSiteConfig.rdf ./rdf/applicationMetadata/firsttime/initialSiteConfig.rdf
COPY --chown=root:root ./inject/vivo_home/rdf/display/everytime/homePageDataGetters.n3 ./rdf/display/everytime/homePageDataGetters.n3
COPY --chown=root:root ./inject/vivo_home/rdf/display/everytime/searchIndexerConfigurationVivo.n3 ./rdf/display/everytime/searchIndexerConfigurationVivo.n3
COPY --chown=root:root ./inject/vivo_home/rdf/i18n/en_US/display/firsttime/aboutPage.n3 ./rdf/i18n/en_US/display/firsttime/aboutPage.n3
COPY --chown=root:root ./inject/vivo_home/rdf/i18n/en_US/interface-i18n/firsttime/vivo_UiLabel_wilma_uncw.ttl ./rdf/i18n/en_US/interface-i18n/firsttime/vivo_UiLable_wilma_uncw.ttl
COPY --chown=root:root ./inject/vivo_home/rdf/tbox/firsttime/featuredProfileOntology.n3 ./rdf/tbox/firsttime/featuredProfileOntology.n3
COPY --chown=root:root ./inject/vivo_home/rdf/tbox/firsttime/wos.n3 ./rdf/tbox/firsttime/wos.n3

# move vivo tomcat folder to ROOT tomcat folder
RUN mv /usr/local/tomcat/webapps/vivo/ /usr/local/tomcat/webapps/ROOT

WORKDIR /usr/local/vivo/home