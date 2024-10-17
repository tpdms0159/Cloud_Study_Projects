# ADD 명령어의 자동 압축 해제 기능 활용
# 1. 기본 터미널
sudo apt install git
git clone https://github.com/brayanlee/webapp.git

# 2. clone 한 폴더로 이동 후 dockerfiles/Dockerfile 생성
cd webapp
mkdir dockerfiles

# Dockerfile 에 내용 작성
FROM ubuntu:latest

RUN apt-get update && apt-get -y install apache2 vim curl

ADD webapp.tar.gz /var/www/html

WORKDIR /var/www/html

EXPOSE 80

CMD /usr/sbin/apachectl -D FOREGROUND


# 3. 파일 이미지 빌드 후 컨테이너 생성
docker build -t webapp:8.0 -f ./dockerfiles/Dockerfile .

docker run -dit -p 8201:80 --name webapp8 webapp:8.0

# 4. 압축 해제된 파일 확인
ls

# 실행 결과
# root@42502e4aa868:/var/www/html# ls
# css  index.html  pngs
