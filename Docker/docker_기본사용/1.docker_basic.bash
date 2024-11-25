## image 다운로드 및 확인
docker pull hello-world
docker images

## image 를 container 로 생성
docker run hello-world
docker ps -a

## docker 버전 확인
docker version

## docker 정보 확인
docker info

## 디스크 사용량 확인
docker system df
docker system df -v

## docker 관련 이벤트 정보를 표시하는 명령 
docker system events


# 확인 실습
# 1. 1번 터미널에서 수행
docker system events

# 2. 2번 터미널에서 수행
# nginx 이미지로 webapp 컨테이너 생성
docker run -itd -p 80:80 --name=webapp nginx

# 3. 1번 터미널 로그 확인


# filter 옵션
docker system events --filter 'type=image'
docker system events --filter 'event=stop'
docker system events --filter 'container=webapp'
docker system events --filter 'container=webapp' --filter 'event=stop'

docker system events --since 24h
docker system events --format '{{json .}}'


## 터미널을 이용해 컨테이너에 접속
docker container run -it imagename
docker container top 컨테이너ID

## 현재 실행 중인 컨테이너 확인
docker ps
docker container ls

## 컨테이너의 상세 정보 확인
docker container inspect 컨테이너ID

## 컨테이너 로그 정보 확인
docker container logs 컨테이너ID


