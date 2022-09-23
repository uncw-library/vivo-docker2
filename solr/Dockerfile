FROM amd64/solr:8
# vivo docs specify using solr 8
# https://wiki.lyrasis.org/display/VIVODOC113x/Installing+VIVO

COPY ./vivocore /opt/vivocore

CMD solr-create -c vivocore -d /opt/vivocore
