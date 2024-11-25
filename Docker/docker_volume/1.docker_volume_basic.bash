## docker volume create 이름
# 생성
docker volume create volume_test

# 조회
docker volume ls

# 상세보기
docker volume inspect volume_test


## 볼륨 마운트
## --mount 옵션을 이용해서 source 와 target을 설정
docker run -d --name vol-test1 --mount source=volume_test,target=/app ubuntu:20.04

## -v 옵션을 이용해서 직접 매핑
docker run -d --name vol-test2 -v volume_test:/var/log ubuntu:20.04

## 없는 볼륨이름을 이용하면 자동 생성
docker run -d --name vol-test3 -v my-appvol-2:/var/log ubuntu:20.04

# 볼륨 삭제
docker volume rm 볼륨이름

# 현재 만들어진 2개의 볼륨 삭제
# 컨테이너를 삭제
docker stop vol-test1 vol-test2 vol-test3
docker rm vol-test1 vol-test2 vol-test3

# 볼륨을 삭제
docker volume rm my-appvol-1 my-appvol-2


## bind mount 실습
# 실습을 위한 디렉토리를 생성
mkdir /home/docker_volume/target

# mount 옵션으로 centos:8 의 /var/log 디렉토리 와 연결
docker run -dit --name bind-test1 --mount type=bind,source=/home/docker_volume/target,target=/var/log centos:8

# v 옵션으로 centos:8 의 /var/log 디렉토리 와 연결
docker run -dit --name bind-test2 -v /home/docker_volume/target:/var/log centos:8

# 없는 디렉토리 와 연결
docker run -dit --name bind-test3 -v /home/docker_volume/target1:/var/log centos:8

# 없는 디렉토리에 권한을 부여해서 연결
docker run -dit --name bind-test4 -v /home/docker_volume/target_ro:/app1:ro -v /home/docker_volume/target_rw:/app2:rw centos:8


## tmpfs mount 실습
##mount 옵션을 이용해서 tmpfs 연결을 수행하는데 httpd:2 의 /var/www/html 파일을 임시로 연결
docker run -dit --name tmpfs-test1 --mount type=tmpfs,destination=/var/www/html httpd:2
docker run -dit --name tmpfs-test2 --tmpfs /var/www/html httpd:2
docker run -d --name nginx-mount --mount type=bind,source=/home/user/website,target=/usr/share/nginx/html nginx


## volume 활용 실습
## 데이터의 지속성 유지를 위해서 볼륨 생성
docker volume create mysql-data-vol

## 볼륨과 연결해서 mysql:5.7 이미지를 컨테이너로 생성
docker run --platform linux/amd64 -it -d --name=mysql-server -e MYSQL_ROOT_PASSWORD=wnddkd
-e MYSQL_DATABASE=dockertest -v mysql-data-vol:/var/lib/mysql mysql:5.7

## 데이터 수정
# 쉘에 접속
docker exec -it mysql-server /bin/bash

# 데이터베이스 사용을 위해서 mysql에 접속
mysql -uroot -p

# 데이터베이스 확인
show databases;

# 데이터베이스 사용 설정
use dockertest;

# 테이블 생성
create table mytab(c1 int, c2 char);

# 데이터 추가
insert into mytab values(1, 'a');

# 데이터 확인
select * from mytab;

# 컨테이너를 삭제
docker stop mysql-server
docker rm mysql-server

docker run --platform linux/amd64 -it -d --name=mysql-server -e MYSQL_ROOT_PASSWORD=wnddkd -e MYSQL_DATABASE=dockertest -v mysql-data-vol:/var/lib/mysql mysql:5.7


