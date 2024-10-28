## 개념
# nginx-deploy-7f89d7585d-drhcb 파드의 80 번 포트를 호스트의 8000 번 포트로 연결하도록 port-forwarding을 수행
kubectl port-forward nginx-deploy-7f89d7585d-drhcb 8000:80
# 파드 정보 확인
kubectl get pods

# 파드IP 정보 확인
kubectl describe nginx-deploy-7f89d7585d-drhcb

# 파드 삭제
kubectl delete pod nginx-deploy-7f89d7585d-drhcb
## ==> IP 는 파드 재생성시 변경되므로 IP 를 이용해서 접속하는것은 의미가 없음


## 외부에서 서비스 이름으로 접근할 수 있도록 포트를 외부로 개방하기
## 1. nginx-svc.yml 파일 생성 후 작성
apiVersion: v1

kind: Service      #Service를 생성하는 yaml 파일

metadata:
  name: nginx-svc  #Service 이름
  labels:
    app: nginx

spec:
  type: NodePort   #NodePort를 이용해서 외부에 공개
  ports:
  - port: 8000
    nodePort: 31472
    targetPort: 80
  selector:
    app: nginx     #app: nginx 레이블을 갖는 파드와 연결

## 2. nginx-svc.yml 을 이용해서 클러스터 생성
kubectl apply -f nginx-svc.yml

## 3. 서비스 생성 확인
kubectl get svc



