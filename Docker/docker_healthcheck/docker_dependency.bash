## 컨테이너 실행
docker run -d -p:8082:80 --name numbers-web diamol/ch08-numbers-web

## 컨테이너 확인
docker ps - 컨테이너가 정상 실행되고 있음

## Dockerfile 확인
nano numbers-web/Dockerfile
# 실행 명령어가 ENTRYPOINT에 작성되어 있음
# 종속성을 확인하지 않고 바로 실행되는데 버튼을 누르면 호출하는 API를 확인하지 않음

##Dockerfile 확인
nano numbers-web/Dockerfile:v2
# 실행 명령어가 CMD에 추가되어 있는데 버튼을 누르면 호출하는 API가 동작하는 경우에 실행되도록 작성

## 컨테이너 실행
docker run -d -p 8084:80 --name number_web_dependency diamol/ch08-numbers-web:v2
