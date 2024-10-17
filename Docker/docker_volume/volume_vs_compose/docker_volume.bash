## docker volume 명령어로 작성
# 1. volume 생성
docker volume create mydb_data
docker volume create myweb_data

docker volume ls
docker inspect --type volume mydb_data

## 2. 컨테이너를 묶을 네트워크 생성 (IP 는 자동생성)
docker network create myapp_net

docker network ls
docker network inspect myapp_net

## 3. MySQL8.0 컨테이너를 생성
# 줄바꿈은 지워서 터미널에 입력
docker run -dit --name=wordpress_app -v mywebdata:/var/www/html -v ${PWD}/myweb-log:/var/log --restart=always -p 8888:80 --net=myapp_net --link mysql_app:mysql -e WORDPRESS_DB_HOST=mysql_app:3306 -e WORDPRESS_DB_NAME=volume  -e WORDPRESS_DB_USER=root -e WORDPRESS_DB_PASSWORD=mysql wordpress:5.7

docker run -dit 
--name=mysql_app 
-v mydb_data:/var/lib/mysql 
--restart=always -p 3306:3306 
--net=myapp_net 
-e MYSQL_ROOT_PASSWORD=0826 
-e MYSQL_DATABASE=volumedb 
-e MYSQL_USER=root 
-e MYSQL_PASSWORD=mysql 
mysql:8.0

## 4. wordpress:5.7 컨테이너를 생성
# mariadb 에 volumedb 생성
docker run -dit --name=wordpress app -v mywebdata:/var/www/html -v ${PWD}/myweb-log:/var/log --restart=always -p 8888:80 --net=myapp_net --link mysql_app:mysql -e WORDPRESS_DB_HOST=mysql_app:3306 -e WORDPRESS_DB_NAME=volumedb -e WORDPRESS_DB_USER=root -e WORDPRESS_DB_PASSWORD=mysql wordpress:5.7

docker run -dit 
--name=wordpress app 
-v mywebdata:/var/www/html 
-v ${PWD}/myweb-log:/var/log 
--restart=always -p 8888:80 
--net=myapp_net 
--link mysql_app:mysql 
-e WORDPRESS_DB_HOST=mysql_app:3306 
-e WORDPRESS_DB_NAME=volumedb
-e WORDPRESS_DB_USER=root
-e WORDPRESS_DB_PASSWORD=mysql
wordpress:5.7

## 5. 디렉터리 생성 후 docker-compose.yml 파일 생성 후 작성
cd ~/compose
mkdir myapp && cd $_

vi docker-compose.yml

version: "3.9"
services:
  mydb:
    image: mysql:8.0
    container_name: mysql_app
    volumes:
      - mydb_data: /var/lib/mysql
    restart: always
    ports:
      - "3306:3306"
    networks:
      - backend-net
    environment:
      MYSQL_ROOT_PASSWOR: 0826
      MYSQL_DATABASE: volumedb
      MYSQL_USER: root
      MYSQL_PASSWORD: mysql
  myweb:
    image: wordpress:5.7
    container_name: wordpress_app
    ports:
      - "8888:80"
        
    networks:
      - backend-net
      - frontend-net
    volumes:
      - myweb_data:/var/www/html
      - ${PWD}/myweb-log:/var/log
    restart: always
    environment:
      WORDPRESS_DB_HOST: mydb:3306
      WORDPRESS_DB_USER: root
      WORDPRESS_DB_PASSWORD: mysql
      WORDPRESS_DB_NAME: volumedb
    depends_on:
      - mydb
        
volumes:
  mydb_data: {}
  myweb_data: {}
    
networks:
  frontend-net: {}
  backend-net: {}
    

## 6. 기존의 구동 중이던 3306 포트 컨테이너 중지
docker stop $(docker ps -a)

## 7. 실행
docker-compose up -d