##  Spring Boot Application을 NodePort를 이용해서 모든 Node에서 포트를 개방해서 서비스 할 수 있도록 하기
## 1. 기본 패키지 안에 요청을 처리하는 클래스를 추가하고 작성(FrontController)
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
public class FrontController {
   @GetMapping("/")
   public Map<String, Object> index(){
       Map<String, Object> data = new HashMap<>();
       data.put("result", "success");
      
       List<Map> list = new ArrayList<>();
       Map<String, String> map1 = new HashMap<>();
       map1.put("id", "itstudy");
       map1.put("name", "아담");
       list.add(map1);
      
       data.put("list", list);
      
       return data;
   }
}

## 2. Dockerfile 파일을 만들어서 이미지 생성
# 터미널을 실행 시켜서 애플리케이션 빌드: 실행 가능한 자바 파일을 생성
./gradlew clean build

# 프로젝트의 루트 디렉토리에 Dockerfile을 생성하고 작성
FROM amazoncorretto:17
CMD ["./mvnw", "clean", "package"]
ARG JAR_FILE=target/*.jar
COPY ./build/libs/*.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]

# 이미지 생성
docker build -f Dockerfile -t apiserver:0.0.1 .

# 이미지 확인
docker images

# 컨테이너로 실행
docker run -d --name apiserver -p 80:8080 apiserver:0.0.1

 
## 3. Github이용해서 DockerHub에 배포
# git hub에 레포지토리 생성
git init
git add .
git commit -m "init"

# 이메일, 이름 등록 필요 시
git config --global user.email "you@example.com"
git config --global user.name "Your Name"

# 브랜치 확인 후 변경
git branch
git checkout -b main

# 원격 저장소 등록
git remote add origin https://github.com/itstudy001/apiserver.git
git push origin main

## 3. push가 발생할 때 DockerHub에 이미지 배포
# Docker Hub에 Repository를 생성
#  .github/workflows/upload.yml

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

# git hub 에 push
git add .
git commit -m 메시지
git push 저장소이름 브랜치이름

## 4. 쿠버네티스 Deployment 이용해서 파드 생성
# pod 를 생성할 yml 파일 작성
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

## 5. kubenetes Service 를 이용해서 NodePort 설정
# nodeport를 이용할 서비스 파일을 생성: service.yml
apiVersion: v1
kind: Service
metadata:
  name: devops-spring-service
spec:
  type: NodePort
  ports:
  - port: 80
    protocol: TCP
    targetPort: 8080
  selector:
    app: devops-spring-app

# 서비스 생성
kubectl apply -f service.yml

# 서비스 확인
kubectl get svc
kubectl get svc -o wide

# endpoint 확인
kubectl get ep
