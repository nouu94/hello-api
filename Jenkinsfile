pipeline {
    agent any

    tools {
        jdk 'jdk-21'
    }

    environment {
        IMAGE_NAME = 'nouu94/hello-api'
        DOCKER_CREDENTIALS_ID = 'dockerhub-creds'
    }

    stages {
        stage('Clone') {
            steps {
                git branch: 'main', credentialsId: 'github-api-token', url: 'https://github.com/nouu94/hello-api.git'
            }
        }

        stage('Build JAR') {
            steps {
		sh 'chmod +x ./gradlew'
                sh './gradlew clean bootJar'
            }
        }

        stage('Build & Push Docker Image') {
            steps {
                script {
                    def imageTag = "${IMAGE_NAME}:${env.BUILD_NUMBER}"
                    docker.withRegistry('https://index.docker.io/v1/', "${DOCKER_CREDENTIALS_ID}") {
                        def builtImage = docker.build(imageTag)
                        builtImage.push()
                        builtImage.push('latest')
                    }
                }
            }
        }
    }
}

