pipeline {
    agent none

    environment {
        // API_ROOT_STAGING = 'http://localhost:3000/api'
        API_ROOT_STAGING = 'http://staging.backend.ba:3000/api'
        API_ROOT_PRODUCTION = 'http://localhost:2000/api'

        AWS_ACCESS_KEY_ID = credentials('jenkins-aws-secret-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('jenkins-aws-secret-access-key')
    }
    
    stages {
        stage('Build for staging and production'){
            agent { 
                docker { 
                    image 'node:lts'
                }
            }
            steps {
                // shell script that runs npm install 
                // and builds for staging and production, 
                // executed inside node:lts container
                sh 'chmod +x jenkins-scripts/build.sh'
                sh './jenkins-scripts/build.sh'
            }
        }
        stage('Archive staging and production builds'){
            agent { 
                docker { 
                    image 'node:lts'
                }
            }
            steps {
                // shell script that uses tar to compress build directories 
                // and after producing archives deletes uncompressed directories
                // executed inside node:lts container
                sh 'chmod +x jenkins-scripts/archive.sh'
                sh './jenkins-scripts/archive.sh'
            }
        }
        stage('Upload the resulting archives to artifact S3 bucket'){
            agent { 
                docker { 
                    image 'jenkins-with-aws-cli'
                }
            }
            steps {
                // executed inside jenkins-with-aws-cli container
                echo 'this stage uploads tar.gz to S3 bucket for artefacts'
                
                sh "aws configure set aws_access_key_id ${AWS_ACCESS_KEY_ID}"
                sh "aws configure set aws_secret_access_key ${AWS_SECRET_ACCESS_KEY}"
                sh 'aws configure set default.region us-east-1'

                sh "aws s3 cp ${JOB_BASE_NAME}-master-build-${BUILD_ID}.tar.gz s3://bakirbs-combined-task-front-artifact-bucket/${JOB_BASE_NAME}-master-build-${BUILD_ID}.tar.gz"
            }
        }
        stage('Deploy the application from staging directory to staging S3 bucket'){
            agent { 
                docker { 
                    image 'jenkins-with-aws-cli'
                }
            }
            steps {
                // executed inside jenkins-with-aws-cli container
                echo 'this stage uploads staging build to application S3 bucket'

                sh "aws configure set aws_access_key_id ${AWS_ACCESS_KEY_ID}"
                sh "aws configure set aws_secret_access_key ${AWS_SECRET_ACCESS_KEY}"
                sh 'aws configure set default.region us-east-1'

                // delete old staging files
                sh 'aws s3 rm s3://bakirbs-combined-task-front-staging-bucket --recursive'
                // push staging build to bucket
                sh "aws s3 cp ${JOB_BASE_NAME}-master-build-${BUILD_ID}/build-${BUILD_ID}-staging s3://bakirbs-combined-task-front-staging-bucket/ --recursive"
            }
        }
        stage ('Run Jenkinsfile-production job to push the production build to application bucket') {
            agent any
            steps {
                build (job: 'reduxapp-prod', parameters: [string(name: 'VERSION', value: "${BUILD_ID}")])
            }
        }
        stage('Package into docker image') {
            agent { 
                docker { 
                    image 'brrx387/jenkins-docker'
                    args '-v /var/run/docker.sock:/var/run/docker.sock'
                }
            }
            steps {
                // if this step is used agent has to mount docker.sock
                // Nginx container with both staging and production applications, 
                // environment being selected using environment variable during container start
                // sh "docker build -t brrx387/react-redux-realworld-example-app:${env.BUILD_ID} ."
                echo 'this stage would create Docker image based on Nginx alpine baseimage'
                // sh '''IFS='/' read -r -a BRANCH_NAME <<< "$GIT_BRANCH"'''
                sh "docker build -t reduxapp:${env.BUILD_ID}-staging --build-arg JOB=${env.JOB_BASE_NAME} --build-arg BRANCH=master --build-arg NUM=${env.BUILD_ID} ."
                
                // delete local build dirs and archives
                sh "rm -rf ${JOB_BASE_NAME}-master-build-${BUILD_ID}"
                sh "rm ${JOB_BASE_NAME}-master-build-${BUILD_ID}.tar.gz"            }
        }
    }
    
    post {
        success {
            echo "**************\n** Success! **\n**************"
        }
        failure {
            echo "--------------\n|   FAILED!  |\n--------------"
        }
    }
}