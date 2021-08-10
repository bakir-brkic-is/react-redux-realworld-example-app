pipeline {
    agent { 
        docker { 
            image 'brrx387/jenkins-docker'
            args '-v /var/run/docker.sock:/var/run/docker.sock'
            reuseNode true
        }
    }

    environment {
        API_ROOT = 'https://conduit.productionready.io/api'
    }
    
    stages {
        stage('Build container image') {
            steps {
                echo "API_ROOT=${API_ROOT}"
                sh "docker build -t reduxapp:${env.BUILD_ID} --build-arg API_ROOT=${API_ROOT} ."
            }
        }
        stage('Docker run container') {
            steps {
                sh "docker run -d -p 8080:80 --name redux-app-${env.BUILD_ID} reduxapp:${env.BUILD_ID}"
            }
        }
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