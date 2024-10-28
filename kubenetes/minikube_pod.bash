## pod 생성 
# 1. httpd 이미지를 이용해서 deployment 로 파드를 생성
kubectl create deployment my-httpd --image=httpd --replicas=1 --port=80

# 2. deployment 를 확인
kubectl get deployment

# 3. 이미지 변경
kubectl set image deployment/디풀로이먼트이름 컨테이너이름=이미지
