#!/bin/sh

# upgrade packages if UPGRADE_ON_START is set
if [ ! -z ${UPGRADE_ON_START+x} ]; then
    apk upgrade --no-cache 
fi

# generate davical config
mkdir -p /etc/davical
cat << EOF > /etc/davical/config.php
<?php
    \$c->default_locale = "${DEFAULT_LOCALE}";
    \$c->pg_connect[] = "host=${DB_HOST} port=${DB_PORT} dbname=${DB_NAME} user=${DB_APP_USER} password=${DB_APP_PASS}";
?>
EOF

if [ "$#" -eq 0 ]; then 
    exec lighttpd -D -f /etc/lighttpd/lighttpd.conf
fi

exec "$@"
