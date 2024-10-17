## 1. 디렉터리 생성
mkdir compose
cd compose
mkdir db-data
cd db-data

## 2. yml 파일 생성 후 작성
vi docker-compose.yml

version: '3.3'
services:
    mydb:
     image: mariadb:10.4.6
     restart: always
     environment:
     - MYSQL_ROOT_PASSWORD=0826
     - MYSQL_DATABASE=appdb
     volumes:
     - ./db-data:/var/lib/mysql
     ports:
     - '3306:3306'


## 3. docker container 로 실행
docker-compose up

