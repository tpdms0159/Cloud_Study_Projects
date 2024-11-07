## Helm 설치
# 설치 가이드: https://helm.sh/ko/docs/intro/install/
# 설치 확인: helm version

## 애플리케이션 설치: https://kiamol.net & vweb, https://charts.bitnami.com/bitnami & nginx

## 1. 레포지토리 추가
helm repo add 이름 URL

# 삭제
helm repo remove 이름
# 리스트
helm repo list

## 2. 레포지토리의 캐시를 업데이트
helm repo update

## 3. 애플리케이션 검색 및 설치
# 애플리케이션 검색 : helm search repo 애플리케이션이름
helm search repo vweb
helm search repo nginx

## 4. 애플리케이션 다운로드: helm pull 애플리케이션이름
helm pull bitnami/nginx
# 구조를 알아보기 위해서 압축 해제
tar xvfz nginx-18.2.4.tgz

# 환경 변수 확인: helm show values 이름

# 설치: helm install --set 환경변수=값… 레이블 애플리케이션이름
# 로컬의 nginx를 설치
cd nginx
helm install nginx -f values.yaml .
helm ls
kubectl get pods

# 원격 서버의 kiamol/vweb을 설치
helm install --set servicePort=8010 --set replicaCount=2 vweb kiamol/vweb --version 1.0.0

helm ls

kubectl get pods

