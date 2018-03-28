#!/bin/bash
set -e
cd /app/koel

# wait for mysql to be up and running
while ! mysqladmin ping -h"$DB_HOST" --silent; do
    sleep 1
done

# initialise on first run
if [ -f "/app/init.exp" ]; then
    #expect /app/init.exp
    #rm /app/init.exp
fi

php artisan serve --host 0.0.0.0
exec $0
