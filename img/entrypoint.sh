#!/bin/bash
set -e
cd /app/code


echo "Waiting for Database Initialisation"
while ! mysqladmin ping -h"$DB_HOST" --silent; do
    sleep 1
done


if [ -f "/app/init.exp" ]; then
    echo "Initialise application"
    expect /app/init.exp

    # https://github.com/phanan/koel/issues/681
    if [ $HTTPS == "true" ]; then
       sed -i '3i$_SERVER["HTTPS"] = "on";' index.php
    fi
    rm /app/init.exp
fi
chown -R www-data:www-data /app/music/
chown -R www-data:www-data /app/code/

echo "Everything's ready, starting the server"
apachectl -DFOREGROUND
exec $0
