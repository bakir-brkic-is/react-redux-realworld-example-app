#!/bin/sh -eu
./inject-env.sh >/usr/share/nginx/html/config.js
nginx -g "daemon off;"