#!/bin/sh -eu
if [ ! -z "${ENVIRONMENT_TYPE:-}" ]; then
    if [ $ENVIRONMENT_TYPE = "production" ]; then
        rm -rf /usr/share/nginx/html
        mv "/usr/share/nginx/production" "/usr/share/nginx/html"
    fi
fi
./inject-env.sh
nginx -g "daemon off;"