pipeline {
    agent none
    environment {
        dockerhub=credentials('Docker_Hub')
    }
    stages {
        stage('Build Node App in container') {
            agent { label 'container' }
            steps {
               sh 'echo $env.BRANCH_NAME'
            }
            post {
                success {
                    slackSend (channel: 'jenkins-multibranch', color: '#00FF00', message: "BUILD STAGE SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'[${env.BRANCH_NAME}]")

                }
                failure {
                    slackSend (channel: 'jenkins-multibranch', color: '#FF0000', message: "BUILD STAGE FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' [${env.BRANCH_NAME}]")
                }
            }
        }
        stage('Build Node App in instance') {
            agent { label 'instance' }
            steps {
                sh 'echo $env.BRANCH_NAME'
            }
        
            post {
                success {
                    slackSend (channel: 'jenkins-multibranch', color: '#00FF00', message: "BUILD STAGE SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' [${env.BRANCH_NAME}]")

                }
                failure {
                    slackSend (channel: 'jenkins-multibranch', color: '#FF0000', message: "BUILD STAGE FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'[${env.BRANCH_NAME}]")
                }
            }
        }
    }

    post {
        success {
            echo 'This will run only if successful'
        }
    }
}
