# 이미지 빌드 과정
# 1.
mkdir python_lab
cd python_lab

# 2.
# vi Dockerfile 생성 후 작성
# update 와 -y 옵션을 주는 것이 중요함
FROM ubuntu:18.04

RUN apt-get update
RUN apt-get -y install python

# 3. 
# 이미지 빌드 
docker build -t mypyapp:1.0 .                                                                                                                     0.0s
