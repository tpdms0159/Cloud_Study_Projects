## Docker file 작성 및 생성 

# 1.
mkdir phpapp
cd phpapp

# 2.
# phpapp 폴더에 Dockerfile 생성 후 작성

#base image
FROM ubuntu:14.04

MAINTAINER "tpdms <tpdms0159@naver.com>"

LABEL title "IaC PHP application"

RUN apt-get update && apt-get -y install apache2 php5 git curl ssh wget

#Apache Environment Variable
ENV APACHE_RUN_USER www-data APACHE2_RUN_USER www-data APACHE2_LOG_DIR /var/log/apache2 APACHE2_WEB_DIR /var/www/html APACHE2_PID_FILE /var/run/apache2/apache2.pid

#basic web page
RUN echo 'Hello Docker Application' > /var/www/html/index.html

#PHP 파일
RUN echo '<?php phpinfo(); ?>' > /var/www/html/index.php

EXPOSE 80

WORKDIR /var/www/html

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

# 3.Dockerfile 빌드
docker build -t myphpapp:1.0 .

# 4. 컨테이너로 생성
docker run -dit -p 8101:80 --name phpapp1 myphpapp:1.0

