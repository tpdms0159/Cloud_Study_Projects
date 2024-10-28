##
## 1. 생성 형식
# 상수 방식
kubectl create configmap <map-name> <data-source> <arguments>
# 문자열 방식
kubectl create configmap [map name] --from-literal=[키]=[값]
kubectl create configmap my-config --from-literal=JAVA_HOME=/usr/java

## 2. 삭제
kubectl delete configmap my-config

## 3. 생성
kubectl create configmap my-config --from-literal=JAVA_HOME=/usr/java --from-literal=URL=http://localhost:8000

## 4. 생성 후 확인
kubectl get configmap my-config

kubectl describe configmap my-config

## 5. 파일에서 읽어서 만들기
# 데이터를 저장하는 yaml 파일 생성하고 작성
echo Hello Config >> configmap_test.html

kubectl create configmap configmap-file --from-file configmap_test.html

# 6. 다른 yaml 파일에서 가져다 사용할 때는 최상단에 작성
envFrom:
configMapRef:
name: ConfigMap 이름

## 7. secret 만들기
kubectl create secret generic " secret 이름" --from-literal=키-값

kubectl create secret generic dbuser --from-literal-username=t
kubectl get secret
# data 값이 안보임
kubectl describe secret



