## kubectl 설치: https://kubernetes.io/ko/docs/tasks/tools/install-kubectl-linux/

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"

echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check

sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

kubectl version --client


## kind 설치
## 문서: https://kind.sigs.k8s.io/docs/user/quick-start/

## 명령어
[ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.24.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind
	
## 확인
# 기본 클러스터(Master 1개 와 Worker 1개) 생성
kind create cluster
# 클러스터 삭제
kind delete cluster

## 여러 개의 노드 생성
#yaml 파일 작성

	kind: Cluster
	apiVersion: kind.x-k8s.io/v1alpha4
	nodes:
			- role: control-plane
			- role: worker
			- role: worker


## 클러스터 생성
kind create cluster --config yaml파일경로

## 클러스터 확인
docker ps




#하나의 Mater Node 와 3개의 Worker Node를 가진 클러스터를 위한 설정 파일 생성

kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
- role: worker
- role: worker

#생성
kind create cluster --config kind-example-config.yml

#확인
kubectl get nodes
