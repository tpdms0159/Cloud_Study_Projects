## 토픽 생성 및 조회 및 삭제 
## 1. 토픽 생성
# kafka 프롬프트 이동
docker exec -it kafka /bin/bash
cd /opt/kafka/bin
kafka-topics.sh --bootstrap-server localhost:9092 --list

## 2. 토픽 삭제
kafka-topics.sh --delete --zookeeper zookeeper:2181 --topic exam-topic

## 3. 메세지 전송 및 받기
# 메시지 전송
docker exec -it kafka /bin/bash
cd /opt/kafka/bin
kafka-console-producer.sh --topic exam-topic --broker-list localhost:9092

# 메시지 받기
docker exec -it kafka /bin/bash
cd /opt/kafka/bin


