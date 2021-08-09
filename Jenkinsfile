pipeline {
    agent { 
        docker { 
            image 'brrx387/jenkins-docker'
            args '-v /var/run/docker.sock:/var/run/docker.sock'
            reuseNode true
        } 
    }
    
    stages {
        stage('Build container image') {
            steps {
                sh "docker build . -t reduxapp:${env.BUILD_ID}"
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