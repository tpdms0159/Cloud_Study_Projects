# 1.docker_kafka 실습을 실행할 디렉터리 생성
mkdir 1022_kafka
cd 1022_kafka
nano docker-compose.yml 

# 2.docker-compost.yml 파일에 작성
# macbook utm 전용
version: '2'
services:
  zookeeper:
    image: bitnami/zookeeper:latest
    container_name: zookeeper
    ports:
      - "2181:2181"
    environment:
      - ALLOW_ANONYMOUS_LOGIN=yes
    volumes:
      - zookeeper_data:/bitnami/zookeeper

  kafka:
    image: bitnami/kafka:latest
    container_name: kafka
    ports:
      - "9092:9092"
    environment:
      - KAFKA_CFG_ZOOKEEPER_CONNECT=zookeeper:2181
      - ALLOW_PLAINTEXT_LISTENER=yes
      - KAFKA_CFG_LISTENER_SECURITY_PROTOCOL_MAP=PLAINTEXT:PLAINTEXT,PLAINTEXT_HOST:PLAINTEXT
      - KAFKA_CFG_LISTENERS=PLAINTEXT://:29092,PLAINTEXT_HOST://:9092
      - KAFKA_CFG_ADVERTISED_LISTENERS=PLAINTEXT://kafka:29092,PLAINTEXT_HOST://localhost:9092
    volumes:
      - kafka_data:/bitnami/kafka
    depends_on:
      - zookeeper

volumes:
  zookeeper_data:
    driver: local
  kafka_data:
    driver: local

# 3.터미널에서 명령을 수행 - 클러스터 1개를 가진 카프카 서버를 실행
docker-compose up -d

# 4.외부에서 사용할 수 있도록 설정 변경 => 터미널에서 도커 컨테이너 안으로 접속
docker exec -it kafka /bin/bash

cd /opt/kafka/bin
vi server.properties

# 5.server.properties 파일 내용 끝에 추가
listeners=PLAINTEXT://:9092                                                   
delete.topic.enable=true                                                        
auto.create.topics.enable=true  

# 6.kafka topic 생성
cd /opt/kafka/bin
bash-5.1# kafka-topics.sh --bootstrap-server localhost:9092 --create --topic exam-topic   
# 토픽 리스트 확인
kafka-topics.sh --bootstrap-server localhost:9092 --list
 


