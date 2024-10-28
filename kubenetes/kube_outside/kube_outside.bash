## ClusterIP.yml 생성 후 작성
nano ClusterIp.yml

apiVersion: apps/v1 # pod create: apps/v1, job create: batch/v1, etc: v1
kind: Deployment
metadata:
  name: clusterip-nginx
spec:
  selector:
    matchLabels:
      run: clusterip-nginx
  replicas: 2

  template:
    metadata:
      labels:
        run: clusterip-nginx
    spec:
      containers:
       - name: clusterip-nginx
         image: nginx
         ports:
          - containerPort: 80

## 2. 파드 생성 후 확인
kubectl apply -f ClusterIP.yml
kubectl get pods
kubectl get pods -o wide
# 특정 레이블을 가진 파드를 확인
kubectl get pods -l run=clusterip-nginx -o wide

# 서비스를 만드는 방법
kubectl expose deployment/clusterip-nginx



# 클러스터 내에 다른 Pod를 만들어서 확인
# 10.101.136.62
kubectl run busybox --rm -it --image=busybox /bin/sh 

## External Name 사용 방법
apiVersion: v1
kind: Service
metadata:
  name: external-service
spec:
  type: ExternalName
  externalName: myservice.test.com


## 노드포트 사용하기
apiVersion: apps/v1 #pod create: apps/v1, job create: batch/v1, etc: v1

kind: Deployment

metadata:
  name: nginx-deployment
  labels:
    app: nginx

spec:
  selector:
    matchLabels:
      run: nginx
  replicas: 3

  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx
        ports:
        - containerPort: 80
## 파드 생성
kubectl apply -f nginx-deployment.yml

## NodePort를 개방하는 서비스 파일을 생성: nginx-svc.yml



