FROM tomcat:9-jdk11-openjdk

RUN apt update && \
	apt install -y ca-certificates-java maven git tzdata

ENV TZ="America/New_York"
ENV CATALINA_OPTS="-Xms1g -Xmx5g -XX:MaxPermSize=2g"
ENV JAVA_OPTS="${JAVA_OPTS} -Dtdb:fileMode=direct"

ARG GIT_BRANCH="main"

WORKDIR /usr/local/
RUN git clone https://github.com/vivo-project/Vitro.git Vitro -b ${GIT_BRANCH} && \
	git clone https://github.com/vivo-project/VIVO.git vivo -b ${GIT_BRANCH}

## insert customizations to vivo git repo ./installer before maven install
WORKDIR /usr/local/vivo/
COPY --chown=root:root ./configs/settings.xml ./installer/settings.xml
COPY --chown=root:root ./uncw_theme ./installer/webapp/src/main/webapp/themes/uncw_theme

# maven install
WORKDIR /usr/local/Vitro
RUN mvn install
WORKDIR /usr/local/vivo
RUN mvn clean package -s installer/settings.xml
RUN mvn install -s installer/settings.xml

## insert customizations to image after maven install
WORKDIR /usr/local/vivo/home
COPY --chown=root:root ./configs/runtime.properties ./config/runtime.properties
COPY --chown=root:root ./configs/applicationSetup.n3 ./config/applicationSetup.n3
COPY --chown=root:root ./configs/aboutPage.n3 ./rdf/i18n/en_US/display/firsttime/aboutPage.n3
COPY --chown=root:root ./configs/initialSiteConfig.rdf ./rdf/applicationMetadata/firsttime/initialSiteConfig.rdf

# ugly overwrite of SiteMapServet.java, which makes sitemap.xml
COPY --chown=root:root ./util/SiteMapServlet.java /usr/local/vivo/api/src/main/java/org/vivoweb/webapp/sitemap/SiteMapServlet.java

# move vivo tomcat folder to ROOT tomcat folder
RUN mv /usr/local/tomcat/webapps/vivo/ /usr/local/tomcat/webapps/ROOT
