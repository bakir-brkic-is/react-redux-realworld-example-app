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
                    // args '-v /var/run/docker.sock:/var/run/docker.sock'
                }
            }
            steps {
                // shell script that runs npm install and builds for staging and production, 
                // executed inside node:lts container
                sh 'chmod +x jenkins-scripts/build.sh'
                sh './jenkins-scripts/build.sh'
            }
        }
        // stage('Package into docker images') {
        //     steps {
        //         sh "docker build -t reduxapp:${env.BUILD_ID} ."
        //     }
        // }
        // stage('Docker run container') {
        //     steps {
        //         sh "docker rm -f redux-app"
        //         sh "docker run -d -p 8080:80 --name redux-app -e EXPRESS_BACKEND_SERVICE_SERVICE_PORT=${BACKEND_PORT} -e EXPRESS_BACKEND_SERVICE_SERVICE_HOST=${BACKEND_HOST} reduxapp:${env.BUILD_ID}"
        //     }
        // }
    }
    
    post {
        // always {
        //     archiveArtifacts artifacts: 'build', fingerprint: true
        // }
        success {
            echo 'Success!'
        }
        failure {
            echo 'This will run only if failed'
        }
        unstable {
            echo 'This will run only if the run was marked as unstable'
        }
        changed {
            echo 'This will run only if the state of the Pipeline has changed'
            echo 'For example, if the Pipeline was previously failing but is now successful'
        }
    }
}