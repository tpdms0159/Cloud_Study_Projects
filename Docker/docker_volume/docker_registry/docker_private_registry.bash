## 1. docker 에서 registry 이미지 pull
docker pull registry

## 2. docker - 
sudo nano /etc/init.d/docker
DOCKER_OPTS=--insercure-registry 192.168.64.4:5000

# docker 재시작
sudo service docker restart

## 3. registry 를 컨테이너로 실행 - 서버 생성
docker run --name local-registry -d -p 5000:5000 registry 

## 4. 클라이언트 생성 - daemon.json 파일 생성 후 작성
sudo nano /etc/docker/daemon.json
{ "insecure-registries":["192.168.64.4:5000"] }

docker info 
# 확인
# Insecure Registries:
#   192.168.64.4:5000
#   127.0.0.0/8

## 5. register 확인 명령 - 가상환경이라 확인이 안됨
# utm - network - Bridge 설정 
curl -XGET 192.168.64.4:50/v2/_catalog

## 6. mysql 가져오기
docker pull mysql

## 7. 업로드 이미지 만들기
docker tag mysql:latest 192.168.64.4:5000/mysql:latest
docker tag mysql:latest localhost:5000/mysql:latest

## 8. private registry GUI 조회
docker pull hyper/docker-registry-web:arm64

## 9. 컨테이너로 생성
docker run --platform linux/amd64 -dit -p 8080:8080 --name registry-web --link local-registry -e REGISTRY_URL=http://192.168.64.4:50/v2 -e REGISTRY_NAME=l92.168.64.4:50 hyper/docker-registry-web


