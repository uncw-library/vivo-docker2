#!/bin/sh
# Render VIVO's runtime.properties from environment variables, then start Tomcat.
set -e

CONF=/usr/local/vivo/home/config
OUT="$CONF/runtime.properties"

# required
: "${VIVO_DEFAULT_NAMESPACE:?VIVO_DEFAULT_NAMESPACE must be set}"
: "${VIVO_ROOT_EMAIL:?VIVO_ROOT_EMAIL must be set}"
# defaulted
export SOLR_URL="${SOLR_URL:-http://vivo-solr:8983/solr/vivocore}"

# only substitute our vars so any other literal $ in the template is left alone
envsubst '${VIVO_DEFAULT_NAMESPACE} ${VIVO_ROOT_EMAIL} ${SOLR_URL}' \
	< "$CONF/runtime.properties.template" > "$OUT"

# optional properties: written only when the variable is set, so an unset
# variable leaves the property absent rather than blank
add_prop() {
	if [ -n "$2" ]; then
		printf '%s = %s\n' "$1" "$2" >> "$OUT"
	fi
}

printf '\n# ---- added from environment by docker-entrypoint.sh ----\n' >> "$OUT"
add_prop email.smtpHost       "$SMTP_HOST"
add_prop email.port           "$SMTP_PORT"
add_prop email.replyTo        "$SMTP_REPLY_TO"
add_prop email.username       "$SMTP_USERNAME"
add_prop email.password       "$SMTP_PASSWORD"
add_prop orcid.clientId       "$ORCID_CLIENT_ID"
add_prop orcid.clientPassword "$ORCID_CLIENT_SECRET"
add_prop orcid.webappBaseUrl  "$ORCID_WEBAPP_BASE_URL"
add_prop orcid.api            "$ORCID_API"
add_prop orcid.apiLevel       "$ORCID_API_LEVEL"
add_prop google.maps.key      "$GOOGLE_MAPS_KEY"

exec "$@"
