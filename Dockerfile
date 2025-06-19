FROM eclipse-temurin:21-jre-alpine
WORKDIR /app

# Jenkins에서 빌드된 JAR 파일을 복사
COPY build/libs/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]

