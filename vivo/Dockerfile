FROM amd64/tomcat:9.0.21-jdk11-openjdk

RUN apt update && \
	apt install -y maven git

WORKDIR /usr/local/

ARG GIT_BRANCH=rel-1.13-maint

RUN git clone https://github.com/vivo-project/Vitro.git Vitro -b ${GIT_BRANCH} && \
	git clone https://github.com/vivo-project/VIVO.git VIVO -b ${GIT_BRANCH} && \
	git clone https://github.com/vivo-project/Vitro-languages.git Vitro-languages -b ${GIT_BRANCH}  && \
	git clone https://github.com/vivo-project/VIVO-languages.git VIVO-languages -b ${GIT_BRANCH}


WORKDIR /usr/local/VIVO/

# insert customizations to image before maven install
COPY --chown=root:staff ./configs/settings.xml settings.xml
COPY --chown=root:staff ./configs/initialSiteConfig.rdf /usr/local/VIVO/home/src/main/resources/rdf/applicationMetadata/firsttime/
# COPY --chown=root:staff ./nemo /usr/local/VIVO/webapp/target/vivo/themes/nemo

WORKDIR /usr/local/Vitro-languages
RUN mvn install
WORKDIR /usr/local/VIVO-languages
RUN mvn install
WORKDIR /usr/local/Vitro
RUN mvn install
WORKDIR /usr/local/VIVO
RUN mvn clean package -s settings.xml
RUN mvn install -s settings.xml

# # clean up
RUN rm -r /usr/local/tomcat/webapps/docs && \
	rm -r /usr/local/tomcat/webapps/examples && \
	rm -r /usr/local/tomcat/webapps/ROOT

# # insert customizations to image after maven install
COPY --chown=root:staff ./configs/runtime.properties /usr/local/VIVO/home/config/runtime.properties
COPY --chown=root:staff ./configs/applicationSetup.n3 /usr/local/VIVO/home/config/applicationSetup.n3
COPY --chown=root:staff ./configs/aboutPage.n3 /usr/local/VIVO/home/rdf/display/firsttime/aboutPage.n3
# COPY --chown=root:staff ./nemo/images/UNCW-1.jpg /usr/local/tomcat/webapps/vivo/images/placeholders/person.bordered.thumbnail.jpg
# COPY --chown=root:staff ./nemo/images/UNCW-3.jpg /usr/local/tomcat/webapps/vivo/images/placeholders/person.thumbnail.jpg

RUN chmod ugo+w -R /usr/local/tomcat/temp && \
	chmod ugo+w -R /usr/local/VIVO/home

RUN ln -s /usr/local/tomcat/webapps/vivo/ /usr/local/tomcat/webapps/ROOT
# the next line "copy i18n to vivo root" seem wrong.  It works better than without, but still feels wrong.
# RUN cp -R /usr/local/tomcat/webapps/ROOT/src/i18n /usr/local/tomcat/webapps/ROOT

RUN export CATALINA_OPTS="-Xms512m -Xmx512m -XX:MaxPermSize=128m"
