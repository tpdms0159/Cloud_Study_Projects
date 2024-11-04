## MySQL 5.7을 이용한 SQL 테스트 ##
## MySQL 5.7을 다운로드
docker pull mysql:5.7

## 이미지 확인
docker images | grep mysql

## 컨테이너를 실행하면서 쉘에 접속(운영체제는 쉘 이름만 입력하면 되지만 운영체제가 아닌 경우는 /bin/쉘이름)
docker run -it mysql:5.7 /bin/bash

## 설치 환경 확인
cat /etc/os-release

## 빠져 나오기
exit

## docker run 은 컨테이너를 생성하면서 시작
## 중지된 컨테이너를 재시작하는 것은 docker start {컨테이너ID | 컨테이너이름}

## 컨테이너에 명령 수행 
docker exec [옵션] 컨테이너이름 이나 컨테이너ID 명령어

## 현재 실행 중인 컨테이너의 bash 쉘에 접속
docker exec -it 컨테이너ID /bin/bash

## 컨테이너를 종료하지 않고 쉘에서 빠져나오기: ctrl + p + q

## 내부 IP 확인
docker inspect 컨테이너이름 | grep IPAddress

## bash에 접속
docker exec -it 컨테이너이름 /bin/bash
