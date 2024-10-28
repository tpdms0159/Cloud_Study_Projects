## 1. Python 에서 카프카 메세지 전송 및 받기
# 가상환경 생성
python3 -m venv kafka_env

# 가상환경 활성화
# mac, linux
soucr kafka_env/bin/activate
# window
kafka_env\Scripts\activate
# 가상환경 비활성화
deactivate

# 패키지 설치
pip3 install kafka-python
pip3 install six=1.6.0

## 2. 메시지 전송하는 코드를 작성하고 실행한 후 터미널 확인
import sys
import six
if sys.version_info >= (3, 12, 0):
   sys.modules['kafka.vendor.six.moves'] = six.moves

from kafka import KafkaProducer
import json


class MessageProducer:
   def __init__(self, broker, topic):
       self.broker = broker
       self.topic = topic
       #key_serializer=str.encode 를 추가하면 key 와 함께 전송
       #그렇지 않으면 value 만 전송
       self.producer = KafkaProducer(
           bootstrap_servers=self.broker,
           value_serializer=lambda x: json.dumps(x).encode("utf-8"),
           acks=0,
           api_version=(2, 5, 0),
           key_serializer=str.encode,
           retries=3,
       )
   def send_message(self, msg, auto_close=True):
       try:
           print(self.producer)
           future = self.producer.send(self.topic, value=msg, key="key")
           self.producer.flush()  # 비우는 작업
           if auto_close:
               self.producer.close()
           future.get(timeout=2)
           return {"status_code": 200, "error": None}
       except Exception as exc:
           raise exc
# 브로커와 토픽명을 지정
broker = ["localhost:9092"]
topic = "exam-topic"
pd = MessageProducer(broker, topic)
#전송할 메시지 생성
msg = {"name": "John", "age": 30}
res = pd.send_message(msg)
print(res)

## 2. 실행 한 후 터미널의 카프카 컨슈머가 데이터를 받는지 확인

## 3. 파이썬 카프카 컨슈머를 작성
import sys
import six
if sys.version_info >= (3, 12, 0):
   sys.modules['kafka.vendor.six.moves'] = six.moves

from kafka import KafkaConsumer
import json
class MessageConsumer:
   def __init__(self, broker, topic):
       self.broker = broker
       self.consumer = KafkaConsumer(
           topic,  # Topic to consume
           bootstrap_servers=self.broker,
           value_deserializer=lambda x: x.decode(
               "utf-8"
           ),  # Decode message value as utf-8
           group_id="my-group",  # Consumer group ID
           auto_offset_reset="earliest",  # Start consuming from earliest available message
           enable_auto_commit=True,  # Commit offsets automatically
       )
   def receive_message(self):
       try:
           for message in self.consumer:
               #print(message.value)
               result = json.loads(message.value)
               for k, v in result.items():
                   print(k, ":", result[k])
               print(result["name"])
               print(result["age"])
       except Exception as exc:
           raise exc
      
# 브로커와 토픽명을 지정한다.
broker = ["localhost:9092"]
topic = "exam-topic"
cs = MessageConsumer(broker, topic)
cs.receive_message()

# 작성한 파일을 실행하면 에러가 발생: 이전에 JSON 형식이 아닌 데이터를 전송했는데 그 데이터를 파싱할려고 해서 에러가 발생
# 토픽을 삭제하고 다시 전송한 후 실행
#  docker exec -it kafka /bin/bash
bash-5.1# cd /opt/kafka/bin
bash-5.1# kafka-topics.sh --delete --zookeeper zookeeper:2181 --topic exam-topic 

