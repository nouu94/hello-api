pipeline {
  agent any

  tools {
    jdk 'jdk-21'
    gradle 'gradle-8.4'
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

    stage('Gradle Build') {
      steps {
        sh './gradlew clean bootJar'
      }
    }

    stage('Build & Push Docker Image') {
      steps {
        script {
          def imageTag = "${IMAGE_NAME}:${env.BUILD_NUMBER}"
          docker.withRegistry('https://index.docker.io/v1/', "${DOCKER_CREDENTIALS_ID}") {
            def img = docker.build(imageTag)
            img.push()
            img.push("latest")
          }
        }
      }
    }
  }
}

