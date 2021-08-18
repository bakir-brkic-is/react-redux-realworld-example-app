#!/bin/bash
npm --version
npm install

# here do something to set API_ROOT for staging
cat > public/config.js <<EOF
window.API_ROOT="$API_ROOT_STAGING";
EOF
npm run build && mv build build-${BUILD_ID}-staging

# here do something to set API_ROOT for production
cat > public/config.js <<EOF
window.API_ROOT="$API_ROOT_PRODUCTION";
EOF
npm run build && mv build build-${BUILD_ID}-production

ls -l