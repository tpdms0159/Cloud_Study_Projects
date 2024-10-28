## utm - linux 환경에서 실시 - arm64 환경
## 1. https://minikube.sigs.k8s.io/docs/start/?arch=%2Flinux%2Farm64%2Fstable%2Fbinary+download 사이트에서 다운받기
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-arm64
sudo install minikube-linux-arm64 /usr/local/bin/minikube && rm minikube-linux-arm64

## 2. kubectl 설치하기
sudo apt install -y kubectl
chmod +x kubectl
sudo mv kubectl /usr/local/bin/
kubectl version --client

## 3. minikube 시작하기
minikube start

## 4. niginx 컨테이너 생성 후 실행
sudo kubectl run mynginx --image nginx

## 5. pods 확인
kubectl get pods