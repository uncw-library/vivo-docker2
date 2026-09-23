# Sourced by catalina.sh. Flags VIVO always needs go here so they survive
# CATALINA_OPTS / JAVA_OPTS being overridden from .env.
CATALINA_OPTS="$CATALINA_OPTS -Dtdb:fileMode=direct"
