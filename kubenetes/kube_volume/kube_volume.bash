########### emtyDir 볼륨 생성하기
## 볼륨 마운트를 위한 yaml 파일을 생성 - 이미지는 nginx 를 이용
## 1. 폴더 생성 후 yaml 파일 생성
mkdir 1025_volme
cd 1025_volume
nano emptyDir.yml

# emtydir.yml
apiVersion: v1

kind: Pod

metadata:
  name: emptydata

spec:
  containers:
  - name: nginx
    image: nginx
    volumeMounts:
    - name: shared-storage
      mountPath: /data/shared

  volumes:
  - name: shared-storage
    emptyDir: {}

## 2. emtyDir.yml 로 클러스터 생성
kubectl apply -f emptyDir.yml

## 3. 접속
kubectl exec -it emptydata -- /bin/bash

# 확인
ccd /data/shared



########### hostPath 만들기
## 1. hostPath 를 이용하는 Pod 생성을 위한 yaml 파일 작성
nano hostPath.yml

apiVersion: v1
kind: Pod
metadata:
  name: hostpath
spec:
  containers:
  - name: nginx
    image: nginx
    volumeMounts:
    - name: localpath
      mountPath: /data/shared

  volumes:
  - name: localpath
    hostPath:
      path: /tmp
      type: Directory

## 2. 파드 생성
kubectl apply -f hostpath.yml

## 3. 파드 내부로 접속
kubectl exec -it hostpath -- /bin/bash

## 4. 볼륨과 연결된 디렉토리로 이동
cd /data/shared




########### 영구 볼륨 만들기
## 1. 영구 볼륨(kind 가 PersistentVolume)을 정의: pv.yml
apiVersion: v1

kind: PersistentVolume

metadata:
  name: mysql-pv-volume
  labels:
    type: local

spec:
  storageClassName: manual
  capacity:
    storage: 20Gi
  accessModes:
    - ReadWriteOnce #노드의 접근 방법으로 ReadWriteOnce이면 하나의 노드에서 읽기쓰기, ReadOnlyMany이면 여러 노드에서 읽기 전용으로 사용하고 ReadWriteMany는 여러 노드에서 읽고 쓰기가 가능하고 ReadWriteOncePod는 하나의 파드에서만 읽고 쓰기가 가능

  hostPath:
    path: "mnt/data"

#위에 ReclaimPolicy를 설정할 수 있는데 영구 볼륨 클레임이 삭제되었을 때 영구 볼륨을 어떻게 할 것인지 여부를 설정하는 것인데 retain을 설정하면 클레임이 삭제되도 영구 볼륨은 보존되고 delete를 설정하면 같이 삭제되고 recycle은 다른 노드에서 사용 가능한 상태로 설정
#지금은 노드가 1개라서 hostPath를 설정했지만 nfs 서버를 이용한다면 path 속성에 디렉토리를 설정하고 server에 nfs 서버의 ip를 설정

## 2. pv.yml을 실행시켜서 영구 볼륨을 생성
kubectl apply -f pv.yml

## 3. Persistant Volume Claim을 위한 yaml 파일 생성: pvc.yml
apiVersion: v1

kind: PersistentVolumeClaim

metadata:
  name: mysql-pv-claim

spec:
  storageClassName: manual  #영구 볼륨의 스토리지이름을 기재
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 20Gi

## 4. pvc를 생성
kubectl apply -f pvc.yml

## 5. 영구 볼륨 클레임을 사용하는 Pod 생성을 위한 Deployment를 생성
nano pvc-deploment.yml
apiVersion: apps/v1

kind: Deployment

metadata:
  name: mysql

spec:
  selector:
    matchLabels:
      app: mysql
  strategy:
    type: Recreate
  template:
    metadata:
      labels:
        app: mysql
    spec:
      containers:
      - image: mysql:8.0.29
        name: mysql
    env:
    - name: MYSQL_ROOT_PASSWORD
      value: password
    ports:
    - containerPort: 3306
    name: mysql
    volumeMounts:
    - name: mysql-persistent-storage
      mountPath: var/mysql
  volumes:
  - name: mysql-persistent-storage
    persistentVolumeClaim:
      claimName: mysql-pv-claim


## 2. 파일 서버 만들기

nfs-utils 패키지를 설치
공유할 디렉토리를 생성하고 접근 권한을 777로 변경
설정 파일을 생성하고 작성: sudo nano /etc/exports
공유할 디렉토리 경로 IP/24(rw)
sudo systemctl start nfs-server







