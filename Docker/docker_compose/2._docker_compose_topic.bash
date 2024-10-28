## 1. docker-compose.yml 파일을 생성하고 작성
mkdir docker_compose
cd docker_compose
nano docker-compose.yml

# 작성
version: '2'
services:
  zookeeper:
    image: bitnami/zookeeper:latest
    container_name: zookeeper
    ports:
     - "2181:2181"
    environment:
     ALLOW_ANONYMOUS_LOGIN: yes
  kafka:
    image: bitnami/kafka:latest
    container_name: kafka
    ports:
     - "9092:9092"
    environment:
     KAFKA_ADVERTISED_HOST_NAME: 127.0.0.1
     KAFKA_ZOOKEEPER_CONNECT: zookeeper:2181
    volumes:
     - /var/run/docker.sock:/var/run/docker.sock


# 카프카는 설치를 할 때 2개의 이미지를 이용
# 카프카 와 주키퍼(카프카 코디네이터)를 같이 설치

## 2. 터미널에서 명령을 수행 - 클러스터 1개를 가진 카프카 서버를 실행
sudo docker-compose up -d

## 3. 외부에서 사용할 수 있도록 설정 변경
# 터미널에서 도커 컨테이너 안으로 접속
docker exec -it kafka /bin/bash
docker exec -it -u root kafka /bin/bash

# 설정 파일을 수정 - 내용을 추가
cd /opt/bitnami/kafka/bin
vi server.properties

listeners=PLAINTEXT://:9092         # kafka 브로커가 수신할 주소와 포트                                                    
delete.topic.enable=true            # 토픽 삭제 기능 활성화
auto.create.topics.enable=true      # 토픽 자동 생성 기능 활성화

## 4. 토픽 생성과 조회 및 삭제
# 명령어 사용을 위해 프롬프트 이동
cd /opt/bitnami/kafka/bin

# kafka 서버의 첫번째 영역에 토픽 생성
# 기본 토픽 생성 형식
kafka-topics.sh --create --topic [토픽이름] --bootstrap-server localhost:9092 --partitions [파티션수] --replication-factor [복제본수]

kafka-topics.sh --create --topic exam-topic --bootstrap-server kafka:9002

# 토픽 삭제
kafka-topics.sh --delete --topic exam-topic --bootstrap-server kafka:9092

## 5. 메세지 전송 및 받기
# 메시지 전송
kafka-console.producer.sh --topic exam-topic --broker-list localhost:9092


# 메시지 받기 - 다른 터미널 열어서 카프카의 첫번째 서버 영역으로 설정
kafka-console-consumer.sh --topic exam-topic --bootstrap-server localhost:9092 --from-beginning


kafka-topics.sh --list --bootstrap-server localhost:9092






