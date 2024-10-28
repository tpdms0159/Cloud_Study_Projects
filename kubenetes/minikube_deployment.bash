## Deployment 생성하기

## 1. nginx-deploy.yml 생성 후 작성
# API 버전
apiVersion: apps/v1

#객체 종류
kind: Deployment


#객체에 대한 정보를 생성
#labels 가 중요
metadata:
  name: nginx-deploy
  labels:
    app: nginx
spec:
  replicas: 2    #2개의 파드 생성
  selector:      #Deployment 가 관리할 파드를 선택
    matchLabels:
      app: nginx
  template:      #이 정보를 가지고 pod를 생성
    metadata:
      labels:
        app: nginx

    spec:        #컨테이너 정보
      containers:
      - name: nginx
        image: nginx:1.7.9
        ports:
        - containerPort: 80

## 2. yaml 파일의 정보를 가지고 파드를 생성
kubectl apply -f nginx-deploy.yml

## 3. - 모든 파드 삭제
kubectl delete pods --all

## 4. - 파드 확인
kubectl get pods

## lables
## 모든 파드 이름 과 레이블 확인
kubectl get pods -o custom-columns=NAME:metadata.name,LABELS:metadata.labels

## 레이블 변경
kubectl label pods -l app=nginx --overwrite app=nginx-1

## Deployment 나 ReplicaSet은 pod를 직접 관리하지 않기 때문에 레이블이 변경되면 변경된 레이블 아래 pod가 존재해야 한다고 판단
kubectl label pods -l app=nginx-1 --overwrite app=nginx
## 결과 : 새로 만들어진 파드(nginx-1) 2개가 소멸됨

