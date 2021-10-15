FROM tomcat:9.0.21-jdk11-openjdk

RUN apt update && \
	apt install -y maven git

WORKDIR /usr/local/

ENV VITRO_VERSION 1.11.0
ENV VIVO_VERSION 1.11.0

RUN wget -O Vitro.zip https://github.com/vivo-project/Vitro/releases/download/vitro-${VITRO_VERSION}/vitro-${VITRO_VERSION}.zip && \
	unzip Vitro.zip -d Vitro && \
	rm Vitro.zip && \
	wget -O VIVO.zip https://github.com/vivo-project/VIVO/releases/download/vivo-${VIVO_VERSION}/VIVO-${VIVO_VERSION}.zip && \
	unzip VIVO.zip -d VIVO && \
	rm VIVO.zip

WORKDIR /usr/local/VIVO/

# insert customizations to image before maven install
COPY --chown=root:staff ./configs/settings.xml settings.xml
COPY --chown=root:staff ./configs/initialSiteConfig.rdf /usr/local/VIVO/home/src/main/resources/rdf/applicationMetadata/firsttime/
COPY --chown=root:staff ./nemo /usr/local/VIVO/webapp/target/vivo/themes/nemo

RUN mvn install -s settings.xml

# clean up
RUN rm -r /usr/local/tomcat/webapps/docs && \
	rm -r /usr/local/tomcat/webapps/examples && \
	rm -r /usr/local/tomcat/webapps/ROOT

# insert customizations to image after maven install
COPY --chown=root:staff ./configs/runtime.properties /usr/local/VIVO/home/config/runtime.properties
COPY --chown=root:staff ./configs/applicationSetup.n3 /usr/local/VIVO/home/config/applicationSetup.n3
COPY --chown=root:staff ./configs/aboutPage.n3 /usr/local/VIVO/home/rdf/display/firsttime/aboutPage.n3
COPY --chown=root:staff ./nemo/images/UNCW-1.jpg /usr/local/tomcat/webapps/vivo/images/placeholders/person.bordered.thumbnail.jpg
COPY --chown=root:staff ./nemo/images/UNCW-3.jpg /usr/local/tomcat/webapps/vivo/images/placeholders/person.thumbnail.jpg

RUN chmod ugo+w -R /usr/local/tomcat/temp && \
	chmod ugo+w -R /usr/local/VIVO/home

RUN mv /usr/local/tomcat/webapps/vivo/ /usr/local/tomcat/webapps/ROOT

RUN export CATALINA_OPTS="-Xms512m -Xmx512m -XX:MaxPermSize=128m"
