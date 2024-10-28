## docker healthcheck 명령어

## 기본 사용 
# --interval: 헬스 체크 간격을 설정하는 것으로 기본값이 30s
# --timeout: 타임 아웃 값으로 응답이 오는데 기다리는 시간으로 기본값이 30s
# --retries: 재시도 횟수로 기본값을 3
HEALTHCHECK --interval=1m --timeout=3s --retries=5 CMD curl -f http://localhost || exit 1

## 3번 요청을 하면 중지되는 컨테이너를 실행
## 이미지는 diamol/ch08-numbers-api && 포트는 80번 포트 연결
docker container run -d -p 8080:80 diamol/ch08-numbers-api
docker run -d -p 8080:80 --name numbersapi diamol/ch08-numbers-api

# 요청 전송
curl http://localhost:8080/rng

## 30초마다 헬스체크를 하고 3번 연속 실패하면 unhealth 상태로 만듬
## 새로운 이미지 빌드(numbers 디렉토리로 이동해서 실행)
docker image build -t numbers-api:v2 -f ./numbers-api/Dockerfile.v2 .

## 컨테이너를 생성
docker run -d -p 8081:80 --name numbersapi1 numbers-api:v2

## 컨테이너 확인
curl http://localhost:8081/rng 명령을 4번 수행해서 4번째 에러인지 확인

docker ps : 아직은 healthy 상태

## 90초후 컨테이너를 확인
docker ps : unhealthy 상태
