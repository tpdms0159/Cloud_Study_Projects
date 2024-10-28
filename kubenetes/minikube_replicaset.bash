## Replicaset 생성

## 1. yml 파일 만들어서 실행
nano replicaset.yml

## 내용작성
apiVersion: apps/v1

kind: ReplicaSet

metadata:
  name: 3-replicaset

spec:
  template:
    metadata:
      name: 3-replicaset
      labels:
        app: 3-replicaset
    spec:
      containers:
      - name: 3-replicaset
        image: nginx
        ports:
        - containerPort: 80
  replicas: 3
  selector:
    matchLabels:
        app: 3-replicaset

## 2. 적용
kubectl apply -f replicaset.yml

## 3. 스케일 변경: scale 명령 과 --replicas=개수 옵션을 이용
kubectl scale --replicas=5 replicaset/3-replicaset


## 4. 삭제는 delete 명령 
kubectl delete -f replicaset.yml

# --cascade=orphan 옵션을 이용하면 pod는 유지되고 replicaset 만 없어짐
kubectl delete -f replicaset.yml --cascade=orphan



