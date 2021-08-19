FROM nginx:alpine
ARG JOB BRANCH NUM
COPY ${JOB}-${BRANCH}-build-${NUM}/build-${NUM}-staging /usr/share/nginx/html