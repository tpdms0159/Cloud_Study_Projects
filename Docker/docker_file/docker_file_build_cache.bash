# 이미지 빌드 캐시
####################################

# 빌드 캐시 실습
mkdir appimage
cd appimage

# Dockerfile 생성 후 작성
FROM ubuntu:latest

RUN apt-get update && apt-get -y install nginx curl vim

RUN echo 'Docker Container Application.' > /var/www/html/index.html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

# 이미지 빌드
docker build -f Dockerfile -t webapp:1.0 .
docker build -f Dockerfile -t webapp:2.0 .

# 두번째 빌드의 결과 중 CACHED
# 빌드 속도 향상을 위해 실행 중간의 이미지 캐시 사용 -> 빌드 캐시
[+] Building 0.8s (7/7) FINISHED                                                                                                                                                                 docker:default
 => CACHED [2/3] RUN apt-get update && apt-get -y install nginx curl vim                                                                                                                                   0.0s
 => CACHED [3/3] RUN echo 'Docker Container Application.' > /var/www/html/index.html  


#######################################################

# 1. 폴더 생성
mkdir python-file
cd python-file

# 2. Dockerfile 생성 후 작성
# RUN ADD COPY -> 각각의 레이어 생성 -> 시간이 오래 걸림
# alpine 버전 사용 -> 용량이 작음 -> 성능 향상 good
# 빌드 캐시 - 수정된 코드 이전까지 적용 -> 수정 빈도 down 코드 순서 up
FROM ubuntu:20.04

COPY app.py /app

RUN apt-get update && apt-get -y install python python-pip && pip install -r requirements.txt

CMD ["python", "/app/app.py"]



