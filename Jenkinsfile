pipeline {
    // 어떠한 Jenkins 노드(worker)든 사용 가능하다.
    agent any

    // jenkins에 등록된 JDK와 Gradle 도구를 사용할 것이다.
    // jdk-21과 gradle-8.4는 global tool configuration에서 지정한 이름 
    tools {
        jdk 'jdk-21'
        gradle 'gradle-8.4'
    }

    // 파이프라인 전체에서 사용할 환경변수 정의
    // IMAGE_NAME : Docker 이미지 이름
    // Docker_credentials_id : dockerhub-creds
    environment {
        IMAGE_NAME = 'nouu94/hello-api'
        DOCKER_CREDENTIALS_ID = 'dockerhub-creds'
    }

    // github에서 레파지토리를 clone합니다.
    // credentialsId: 젠킨스에서 등록한 자격증명 id: 이에 대한 값
    // url : 대상 github repository
    stages {
        stage('Clone') {
            steps {
                git credentialsId: 'github-token', url: 'https://github.com/nouu94/hello-api.git'
            }
        }

	
	// env.BUILD_NUMBER란? 젠킨스가 자동으로 증가시키는 빌드 번호
	// 현재 디렉토리의 Dockerfile 사용
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

