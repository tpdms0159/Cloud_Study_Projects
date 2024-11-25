## 컨테이너 생성하기
# 1. 이미지 다운로드
docker image pull gihyodocker/echo:latest

# 2. 컨테이너 실행
docker container run -t -p 9000:8080 gihyodocker/echo:latest

# 3. 다른 터미널로 확인
curl http://localhost:9000/

## 컨테이너 실행
docker start 컨테이너이름

## 컨테이너 접속
docker attach 컨테이너이름

## 컨테이너 중지
docker stop 컨테이너이름

## 컴테이너 삭제
docekr rm 컨테이너이름

## 컨테이너로 애플리케이션 실행 후 접속
docker pull nginx
docker run --name nginx -d -p 8001:80 nginx

## 컨테이너의 리소스 사용량 실시간 확인
docker stats nginx

## 컨테이너의 실행 중인 프로세스 확인
docker top nginx

## 실행 중인 컨테이너를 제외한 모든 container 파기
docker container prune

## 사용하지 않는 리소스 전부 삭제
docker system prune


