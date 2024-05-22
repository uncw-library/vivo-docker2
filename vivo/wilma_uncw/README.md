before maven build, Vivo theme folders go into $vivo_git/installer/webapp/src/main/webapp/themes/
after maven build, they end up in $tomcat_home/webapps/vivo/themes/

The vivo_UiLabel_....ttl file however goes into a different location, even though it belongs to the specific theme.
after maven build, put it in $vivo_home/rdf/i18n/en_US/interface-i18n/firsttime/

probably better ways to do it, but these seem to work.
