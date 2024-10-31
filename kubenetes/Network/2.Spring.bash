## 1. 애플리케이션 생성
# Intellij에서 Spring Boot Application 생성(Lombok 과 Web 에 대한 의존성만 추가)
# FrontController class 생성 후 작성
package naver.tpdms0159.apiserver;

import org.springframework.web.bind.annotation.GetMapping;

import java.util.*;

public class FrontController {
    @GetMapping
    public Map<String, Object> index() {
        Map<String, Object> data = new HashMap<>();
        data.put("result", "success");

        List<Map> list = new ArrayList<>();
        Map<String, String> map1 = new HashMap<>();
        map1.put("id", "itstudy");
        map1.put("name", "adam");
        list.add(map1);

        data.put("list", list);

        return data;
    }
}

## 2. Dockekerfile 만들어서 이미지 생성
# 터미널을 실행 시켜서 애플리케이션 빌드 : 실행 가능한 자바 파일을 생성
./gradlew clean build

# 프로젝트의 루트 디렉터리에 Dockerfile 생성 후 작성
FROM amazonecorretto:17
CMD["./mvnw", "clean", "package"]
ARF JAR_FILE=target/*.jar
COPY ./build/libs/*.jar.app
ENTRYPOINT["java", "-jar", "app.jar"]

# 이미지 생성
docker build -f Dockerfile -t apiserver:0.0.1 .

# 이미지 확인
docker images

# 컨테이너로 실행
docker run -d --name apiserver -p 80:8080 apiserver:0.0.1

## 3. Github 를 이용해서 Docker Hub 에 배포
# git hub에 레포지토리 생성
apiserver

# git hub에 push
git init
git add .
git commit -m "init"

# 한번도 사용하지 않아서 이메일 과 이름을 등록하라고 메시지 출력
git config --global user.email "you@example.com"
git config --global user.name "Your Name"

# 브랜치 확인
git branch

# 브랜치 변경
git checkout -b main

# 원격 저장소 등록
git remote add 저장소이름 url
git remote add origin https://github.com/itstudy001/apiserver.git

# push: windows 나 mac에서는 브라우저에서 로그인하고 linux의 경우는 콘솔에서 로그인하라는 메시지가 출력됨
git push origin main

# push가 발생할 때 DockerHub에 이미지 배포
# 프로젝트 안에 .github/workflows/upload.yml
name: Java CI with Gradle

on:
 push:
   branches: ["main"]

jobs:
 build-docker-image:
   runs-on: ubuntu-latest
   steps:
     - uses: actions/checkout@v3
     #JDK 17버전 설치
     - name: Set Up JDK 17
       uses: actions/setup-java@v3
       with:
         java-version: '17'
         distribution: 'temurin'

      - name: Run chmod to make gradlew executable
        run: chmod +x ./gradlew
#빌드
     - name: Build and Gradle
       uses: gradle/gradle-build-action@67421db6bd0bf253fb4bd25b31ebb98943c375e1

       with:
         arguments: clean bootJar
     #도커 허브 로그인
     - name: Login To DockerHub
       uses: docker/login-action@v1
       with:
         username: ${{secrets.DOCKERHUB_USERNAME}}
         password: ${{secrets.DOCKERHUB_TOKEN}}
     #이미지 빌드 및 업로드
     - name: Image Build and Release to DockerHub
       env:
         NAME: ${{secrets.DOCKERHUB_USERNAME}}
         REPO: ${{secrets.DOCKERHUB_REPOSITORY}}
       run: |
         docker build -t $REPO .
         docker tag $REPO:latest $NAME/$REPO:latest
         docker push $NAME/$REPO:latest


# git hub 의 repository 에 variable 을 등록
DOCKERHUB_USERNAME, DOCKERHUB_TOKEN,  DOCKERHUB_REPOSITORY

push
git add .
git commit -m 메시지
git push 저장소이름 브랜치이름

# 배포가 제대로 되었는지 도커 허브에서 확인
# 이미지가 제대로 동작하는지 확인

## 4. 쿠버네티스 Deployment 이용해서 파드 생성
# pod 를 생성할 때 yml 파일을 생성
apiVersion: apps/v1

kind: Deployment

metadata:
  name: devops-spring-deployment

spec:
  selector:
    matchLabels:
      app: devops-spring-app
spec:
  selector:
    matchLabels:
      app: devops-spring-app

  replicas: 2
  template:
    metadata:
      labels:
        app: devops-spring-app
    spec:
      containers:
      - name: core
        image: ggnagpae1/apiserver
        imagePullPolicy: Always
        ports:
        - containerPort: 8080
          protocol: TCP
        resources:
          requests:
            cpu: 500m
            memory: 1000Mi
# 파드 생성
kubectl apply -f springbootdeployment.yml


## 5. 쿠버네티스 Service 이용해서 NodePort 설정
