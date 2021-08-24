FROM nginx:alpine
ARG JOB BRANCH NUM
COPY ${JOB}-${BRANCH}-build-${NUM}/build-${NUM}-staging /usr/share/nginx/html
COPY ${JOB}-${BRANCH}-build-${NUM}/build-${NUM}-production /usr/share/nginx/production

COPY docker-entrypoint.sh inject-env.sh /
RUN chmod +x docker-entrypoint.sh inject-env.sh
 
ENTRYPOINT ["/docker-entrypoint.sh"]