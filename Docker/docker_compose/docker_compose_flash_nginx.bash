## 
## alb 디렉토리를 생성하고 그 안에 nginx_alb, pyfla_app1, pyfla_app2, pyfla_app3 
cd nginx_alb

## 2. Dokcerfile 생성한 후 작성
FROM nginx:alpine
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf

## 3. nginx 설정 파일을 생성(nginx.conf)
upstream web-alb{
        server 172.17.0.1:5001;
        server 172.17.0.1:5002;
        server 172.17.0.1:5003;
}

server{
        location /{
                proxy_pass http://web-alb;
        }
}


### pyfla_app1에서 작업 ###
## 1. requirements.txt 를 생성하고 작성
blinker==1.6.3
click==8.1.7
Flask==3.0.0

## 2. Dockerfile을 생성하고 작성
FROM python:3
COPY ./requirements.txt /requirements.txt
WORKDIR /
RUN pip install -r requirements.txt
COPY . /
ENTRYPOINT ["python"]
CMD ["pyfla_app1.py"]

## 3. pyfla_app1.py 파일을 생성하고 작성
from flask import request, Flask
import json
app1 = Flask(__name__)

@app1.route("/")
def hello_world():
  return  "Web Application [1]" + "\n"

if __name__ == "__main__":
  app1.run(debug=True, host='0.0.0.0')


### pyfla_app2에서 작업 ###
## 1. requirements.txt 를 생성하고 작성
blinker==1.6.3
click==8.1.7
Flask==3.0.0

## 2. Dockerfile을 생성하고 작성
FROM python:3
COPY ./requirements.txt /requirements.txt
WORKDIR /
RUN pip install -r requirements.txt
COPY . /
ENTRYPOINT ["python"]
CMD ["pyfla_app1.py"]

## 3. pyfla_app1.py 파일을 생성하고 작성
from flask import request, Flask
import json
app1 = Flask(__name__)

@app1.route("/")
def hello_world():
  return  "Web Application [2]" + "\n"

if __name__ == "__main__":
  app1.run(debug=True, host='0.0.0.0')

### pyfla_app3에서 작업 ###
## 1. requirements.txt 를 생성하고 작성
blinker==1.6.3
click==8.1.7
Flask==3.0.0

## 2. Dockerfile을 생성하고 작성
FROM python:3
COPY ./requirements.txt /requirements.txt
WORKDIR /
RUN pip install -r requirements.txt
COPY . /
ENTRYPOINT ["python"]
CMD ["pyfla_app1.py"]

## 3. pyfla_app1.py 파일을 생성하고 작성
from flask import request, Flask
import json
app1 = Flask(__name__)

@app1.route("/")
def hello_world():
  return  "Web Application [3]" + "\n"

if __name__ == "__main__":
  app1.run(debug=True, host='0.0.0.0')


## 4. alb 디렉토리에 docker-compose.yml 파일을 만들고 작성 
version: "3"
services:
  pyfla_app1:
    build: ./pyfla_app1
    ports:
      - "5001:5000"

  pyfla_app2:
    build: ./pyfla_app2
    ports:
      - "5002:5000"

  pyfla_app3:
    build: ./pyfla_app3
    ports:
      - "5003:5000"

  nginx:
    build: ./nginx_alb
    ports:
      - "8080:80"
    depends_on:
      - pyfla_app1
      - pyfla_app2
      - pyfla_app3

## 5. 실행
=>docker-compose up -d

## 6. 변경 작업
=>nginx.conf 파일을 수정
upstream web-alb {
        ip_hash;

        server 172.17.0.1:5001;
        server 172.17.0.1:5002;
        server 172.17.0.1:5003;
}

server{
        location /{
                proxy_pass http://web-alb;
        }
}

## 7. docker-compose up을 재실행

## 8. 컨테이너를 다시 생성하고 docker-compose up 수행
docker-compose build
docker-compose up -d


