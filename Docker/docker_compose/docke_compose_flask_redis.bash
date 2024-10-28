## 1. 디렉터리 생성
mkdir flask_redis && cd $_

## 2. 파이썬 파일 생성 후 작성
mkdir app
nano py_app.py

import time
import redis
from flask import Flask

py_app = Flask(__name__)
db_cache = redis.Redis(host='redis', port=6379)

def web_hit_cnt():
        return db_cache.incr('hits')

@py_app.route('/')
def python_flask():
        cnt = web_hit_cnt()

        return  '''<h1 style="text-align:center; color:deepskyblue;">docker-compose app:
Flask & Redis</h1>
<p style="text-align:center; color:deepskyblue;">Good Container Service</p>
<p style="text-align:center; color:red;">Web access count : {} times</p>'''.format(cnt)

if __name__ == '__main__':
        py_app.run(host='0.0.0.0', port=9000, debug=True)

## 3. app 디렉토리의 requirements.txt 파이썬 패키지의 의존성 목록을 작성
nano app/requirements.txt

Flask
redis


## 4. python application을 배포할 수 있는 Dockerfile을 생성하고 작성
nano Dockerfile

FROM python:3.8-alpine

RUN apk update && apk add --no-cache bash

RUN apk add --update build-base python3-dev py-pip

ENV LIBRARY_PATH=/lib:/usr/lib
ENV FLASK_APP=py_app
ENV FLASK_ENV=development

EXPOSE 9000

WORKDIR /py_app
COPY ./app/ .
RUN pip install -r requirements.txt
ENTRYPOINT ["python3"]
CMD ["py_app.py"]


## 5. 앱을 빌드해서 로컬에서 테스트
# redis 컨테이너 생성 후 실행
docker run --name myredis -d -p 6379:6379 redis

# application 실행
python3 ./app/py_app.py

## 6. 이미지 파일로 빌드
docker build -t flaskapp .
docker images

docker run -d -p 9000:9000 --name=flaskapp flaskapp
docker ps
# 브라우저에서 자신의IP:9000 으로 확인
# 모든 컨테이너 중지
docker stop $(docker ps -aq)

## 7. docker-compose.yml 를 파일 생성해서 실행
nano docker-compose.yml

version: '3'
services:
  redis:
    image: redis
    ports:
      - 6379:6379
    restart: always

  flask:
    build: .
    ports:
      - 9000:9000
    restart: always
    depends_on:
      - redis
# 컨테이너 실행
docker-compose up -d

# 현재 실행 중인 컨테이너를 제거
docker stop $(docker ps -aq)
docker rm $(docker ps -aq)

## 7-1). 소스 코드에서 redis 접속 IP를 redis로 수정한 후 재실행
import time
import redis
from flask import Flask

py_app = Flask(__name__)
db_cache = redis.Redis(host='redis', port=6379)

def web_hit_cnt():
        return db_cache.incr('hits')

@py_app.route('/')
def python_flask():
        cnt = web_hit_cnt()

        return  '''<h1 style="text-align:center; color:deepskyblue;">docker-compose app:
Flask & Redis</h1>
<p style="text-align:center; color:deepskyblue;">Good Container Service</p>
<p style="text-align:center; color:red;">Web access count : {} times</p>'''.format(cnt)

if __name__ == '__main__':
        py_app.run(host='0.0.0.0', port=9000, debug=True)


## 7-2). docker-compose 파일을 수정해서 redis를 외부에 노출시키지 않고 사용
# docker-compose.yml 파일을 수정
version: '3'
services:
  redis:
    image: redis
    expose:
      - "6379"
    restart: always
    networks:
      - our_net
  flask:
    build: .
    ports:
      - 9000:9000
    restart: always
    links:
      - redis
    depends_on:
      - redis
    networks:
      - our_net
networks:
  our_net: {}


