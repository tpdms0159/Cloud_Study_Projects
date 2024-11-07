## Github Page 로 Helm 패키지 저장 및 다운로드
## 1. git hub 레포지토리 와 배포할 데이터를 가진 디렉토리를 동기화
# github 레포지토리를 생성(README.md 파일을 소유한 상태)
# 로컬에서 clone
git clone https://github.com/tpdms0159/webping.git 
# 브랜치 변경
git checkout -b release
# README.md를 수정
nano README.md

## 2. git hub 레포지토리를 웹 사이트로 변경
# github 레포지토리에서 [Settings] - [Pages]를 선택한 후 branch 부분에서 원하는 브랜치를 선택하고 save를 클릭
# 확인
https://{username}.github.io/{repositoryname}/

## 3. 배포할 디렉토리 복사
cp -r /home/ubuntu/kiamol/ch10/web-ping /home/ubuntu/webping

## 4. 압축 파일을 생성
helm package 디렉토리/

## 5. index.yaml 파일 생성
helm repo index .

# 구조 확인
README.md
web-ping
	Chart.yaml
	Values.yaml
	templates 디렉토리
index.yaml
web-ping-0.1.0.tgz 

## 6. 푸시 수행
git add .
git commit -m "chart init"
git push

## 7. 레포지토리 등록
helm repo add {REPO_NAME} https://{USER_NAME}.github.io/{REPO_NAME}/
# 설치
helm install webping webping/web-ping
