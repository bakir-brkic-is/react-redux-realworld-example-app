#!/bin/sh -eu
if [ ! -z "${EXPRESS_BACKEND_SERVICE_SERVICE_HOST:-}" ]; then
    if [ ! -z "${EXPRESS_BACKEND_SERVICE_SERVICE_PORT:-}" ]; then

cat > /usr/share/nginx/html/config.js/config.js <<EOF
window.API_ROOT="http://${EXPRESS_BACKEND_SERVICE_SERVICE_HOST}:${EXPRESS_BACKEND_SERVICE_SERVICE_PORT}/api";
EOF

    fi
fi