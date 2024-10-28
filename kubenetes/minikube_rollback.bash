## 서비스 롤백

## 1. 기본 배포된 이미지를 nginx:1.16.1 로 변경
kubectl set image deployment.v1.apps/nginx-deploy nginx=nginx:1.16.1
# 확인
kubectl describe deploy nginx-deploy

## 2. 존재하지 않는 버전으로 수정
kubectl set image deployment/nginx-deploy nginx=nginx:1.200

## 3. 현재 상황 확인
kubectl rollout status deployment/nginx-deploy

## 4. 이전 버전으로 회귀
kubectl rollout undo deployment/nginx-deploy

## 5. 업데이트 내역 확인
kubectl rollout history deployment/nginx-deploy

## 6. 특정 revision으로 롤백이 가능
kubectl rollout undo 디플로이먼트 --to-revision=번호

