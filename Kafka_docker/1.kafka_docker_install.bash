## 1.docker_kafka 디렉터리 생성 
mkdir docker_kafka
cd docker_kafka

## 2. docker-compose.yml 파일 생성 후 내용 작성
vi docker-compose.yml

version: '2'
services:
  zookeeper:
	image: wurstmeister/zookeeper
	container_name: zookeeper
	ports:
  	
- "2181:2181"
  kafka:
	image: wurstmeister/kafka:2.12-2.5.0
	container_name: kafka
	ports:
  	- "9092:9092"
	environment:
  	KAFKA_ADVERTISED_HOST_NAME: 127.0.0.1
  	KAFKA_ZOOKEEPER_CONNECT: zookeeper:2181
	volumes:
  	- /var/run/docker.sock:/var/run/docker.sock

## 3. 컨테이너 생성 후 실행
docker-compose up -d

## 4. kafka 터미널 접속
docker exec -it kafka /bin/bash

## 5. kafka server.properties 수정
cd /opt/kafka/bin
listeners=PLAINTEXT://:9092                                                   
delete.topic.enable=true                                                        
auto.create.topics.enable=true  
