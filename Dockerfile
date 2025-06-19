# --- 1단계: Build Stage ---

# clipse-temurin:21-jdk-alpine 이라는 이미지를 쓸거고 build 용도로 쓸거고 2단계 run stage를 위해 build로 변수를 정의할게요.
FROM eclipse-temurin:21-jdk-alpine AS build
# 작업 디렉토리를 /app 으로 만들거에요
WORKDIR /app
# 현재 경로에 있는 모든 루트 경로 파일을 /app에 복사합니다.
COPY . .
RUN chmod +x ./gradlew
# gradle, Jar 기반으로 빌드할게요
RUN ./gradlew bootJar
# 빌드가 잘 됐는지 /app/build/libs 경로 내 빌드된 jar 파일이 만들어졌는지 확인할게요.
RUN ls -l /app/build/libs

# --- 2단계: Run Stage ---
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
# build stage에 build 변수 내 /app/build/libs/demo jar 파일을 app.jar 파일명을 바꿔서 /app 파일에 가져갈게요.
COPY --from=build /app/build/libs/demo-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
