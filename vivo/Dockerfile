## ---- build stage: compile Vitro + VIVO with maven ----
# Runs on the build machine's platform even with --platform linux/amd64, so the
# maven build isn't emulated; its output (jars, templates, rdf) is platform-independent.
FROM --platform=$BUILDPLATFORM maven:3.9-eclipse-temurin-11-noble AS build

ARG GIT_BRANCH=rel-1.15-maint

WORKDIR /usr/local/
RUN git clone https://github.com/vivo-project/Vitro.git Vitro -b ${GIT_BRANCH}
WORKDIR /usr/local/Vitro
RUN --mount=type=cache,target=/root/.m2 mvn clean install

WORKDIR /usr/local/
RUN git clone https://github.com/vivo-project/VIVO.git vivo -b ${GIT_BRANCH}

## insert customizations into the vivo git repo before maven install
WORKDIR /usr/local/vivo/
COPY --chown=root:root ./api ./api
COPY --chown=root:root ./installer ./installer

# maven install: writes
# 	webapp /usr/local/tomcat/webapps/vivo (tomcat-dir)
# 	VIVO home /usr/local/vivo/home (vivo-dir)
RUN mkdir -p /usr/local/tomcat/webapps
RUN --mount=type=cache,target=/root/.m2 mvn clean install -s installer/settings.xml


## ---- runtime stage ----
FROM tomcat:9-jdk11-temurin-noble

RUN apt-get update && \
	apt-get install -y --no-install-recommends tzdata gettext-base && \
	rm -rf /var/lib/apt/lists/*

# override via vivo.env
ENV TZ="America/New_York"
ENV CATALINA_OPTS="-Xms1g -Xmx5g -XX:MaxMetaspaceSize=512m"

# deploy vivo as the ROOT webapp
COPY --from=build /usr/local/tomcat/webapps/vivo /usr/local/tomcat/webapps/ROOT
COPY --from=build /usr/local/vivo/home /usr/local/vivo/home

# runtime-only files, mirrored at their destinations under ./usr/local (merged in):
COPY --chown=root:root ./usr/local /usr/local
RUN chmod 755 /usr/local/bin/docker-entrypoint.sh

WORKDIR /usr/local/vivo/home

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["catalina.sh", "run"]
