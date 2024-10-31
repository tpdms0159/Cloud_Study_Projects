## 1. yml 파일 생성
apiVersion: v1

kind: Pod

metadata:
  name: core-k8s
  labels:
    role: just-an-example
    app: my-example-app
    organization: friends-of-manning
    creator: adam

spec:
  containers:
    - name: any-lod-name-will-do
      image: docker.io/busybox:latest
      command: ['sleep', '10000']
      ports:
      - name: webapp-port
        containerPort: 80
        protocol: TCP

## 2. 파드 생성
kubectl create -f pod.yml

## 3. 파드가 리눅스 내부적으로 프로세스로 실행되는 것을 확인
#리눅스에서 현재 실행 중인 프로세스 개수 확인
ps -ax | wc -l


## 추가적인 pod 정보 관련 명령어
# 파드 상태에 대한 쿼리
kubectl get pods -o=jsonpath='{.items[0].status.phase}'
# 파드의 IP 주소 확인
kubectl get pods -o=jsonpath='{.items[0].status.podIP}'
# 호스트 컴퓨터의 IP 주소 확인
kubectl get pods -o=jsonpath='{.items[0].status.hostIP}'

## 파드에 마운트 한 데이터 검사
# 리눅스에서 수행
kubectl exec -it core-k8s -- sh	
# 컨테이너 내부 쉘에서 수행
mount | grep resolv.conf


### kubectl 을 사용하지 않고 생성하는 방법
## 1. yml 파일 생성
## 2. pod 생성 위치 확인
## 3. pod 생성 컴퓨터에 접속
## 4. 컨테이너에 접속
## 5, 자원 사용량 확인
## 6. 사용량을 설정하지 않은 경우 yml 파일 수정
# pod 생성 및 접속 
# 무한 작업 수행 명령
# 다른 터미널에서 접속시
# pod 가 생성된 노드 확인
# 노드의 container ID 확인
# docker 에 접속
# 자원 사용량 확인

##리소스 사용량을 제한하지 않거나 제한을 하더라도 정수 단위로 설정하면 리소스 전체를 사용하는 일이 벌어질 수 있음
## 7. pod 의 리소스 확인
