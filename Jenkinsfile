pipeline {
    agent none

    environment {
        API_ROOT_STAGING = 'http://localhost:3000/api'
        API_ROOT_PRODUCTION = 'http://localhost:2000/api'
    }
    
    stages {
        stage('Build for staging and production'){
            agent { 
                docker { 
                    image 'node:lts'
                    reuseNode true
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
                    reuseNode true
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
                    image 'node:lts'
                    reuseNode true
                }
            }
            steps {
                // executed inside node:lts container
                echo 'this stage uploads tar.gz to S3 bucket for artefacts'
            }
        }
        stage('Deploy the application from staging directory to application S3 bucket'){
            agent { 
                docker { 
                    image 'node:lts'
                    reuseNode true
                }
            }
            steps {
                // executed inside node:lts container
                echo 'this stage uploads staging build to application S3 bucket'
                sh 'printenv'
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
            }
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