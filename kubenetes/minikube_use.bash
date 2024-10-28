## 1. 컨테이너 실행 
kubectl run mynginx --image nginx

## 2. 실행 중인 컨테이너(pod) 조회
kubectl get pod

# 자세히 보기
kubectl get pod 파드이름 -o yaml
kubectl get pod 파드이름 -o wide

# event 기록까지 확인 가능한 자세히 보기:디버깅 할 때 사용
kubectl describe pod mynginx

## 3. pod 로깅
kubectl logs -f mynginx

## 4. pod에 명령을 수행
kubectl exec mynginx -- apt-get update

## 5. 파드 내부로 들어가고자 하는 경우
kubectl exec -it mynginx -- bash

## 6. 파드 와 호스트간 파일 복사
kubectl cp /etc/password mynginx:/tmp/passwd

# 파일 생성 후 파일 복사 실습
sudo touch /etc/password
ls /etc/password

kubectl cp /etc/password mynginx:/tmp/passwd
kubectl exec -it mynginx -- bash

# 결과
# ls /tmp
passwd

## 7. 파드 정보 수정
kubectl edit pod nginx

## 8. 파드 삭제
kubectl delete pod nginx

## 9. yaml 파일을 이용해서 파드를 생성
vi mynginx.yml

apiVersion: v1
kind: Pod
metadata:
  name: mynginx
spec:
  containers:
    - name: mynginx
      image: nginx

kubectl apply -f mynginx.yml 
kubectl apply -f 야믈파일경로



