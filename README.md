# React Redux Realworld Example

[Default Readme file of this project is here.](README.default.md)

## This is a guide and overview of changes and additions to the project.

## Additions and changes:
- Made it possible to change the API_ROOT value on build
- Made it possible to build the app and package it inside Docker image based on nginx web server
- Jenkinsfile containing build pipeline
## How to:
- Set it up in Jenkins (two jobs): 
    - First pipeline based on [Jenkinsfile](Jenkinsfile), builds the react app, for staging and production environment, packages in .tar.gz archives and uploads artifact, and staging build to respective S3 buckets, builds Docker image
    - Second pipeline [Jenkinsfile-production](Jenkinsfile-production), downloads and unpacks the artifact, uploads production build to *build bucket*
    - AWS credentialds are handeled  through Jenkins
- Change API_ROOT: 
    - On build edit the *environment* directive inside Jenkinsfile to provide correct staging and production API_ROOTs
    - If using docker image, on Docker run, EXPRESS_BACKEND_SERVICE_SERVICE_PORT, EXPRESS_BACKEND_SERVICE_SERVICE_HOST
    environment variables can be specified to change the API_ROOT for the new container
- Select what to serve if using docker image:
    - Docker image containes both staging and production build, by default staging env is served, if you would like to serve production env, on docker run provide environment variable: 
    *-e ENVIRONMENT_TYPE=production*

Jenkins build agent images:
- brrx387/jenkins-docker
- node:lts
- brrx387/jenkins-with-aws-cli 