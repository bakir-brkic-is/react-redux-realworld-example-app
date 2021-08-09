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
                sh 'docker build . -t reduxapp'
            }
        }
        stage('Deploy') {
            steps {
                echo 'polahko doci ce na red'
            }
        }
    }
    
    post {
        // always {
        //     archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
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