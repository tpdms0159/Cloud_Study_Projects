## docker image 다운로드
docker image pull 이미지이름
docker image pull jenkins/jenkins:lts
# 버전 지정 - 태그를 작성하여 지정 가능
docker pull debian:latest

## 이미지 실행
docker container run 이미지이름
## 컨테이너 시작
docker container start 이미지이름
## 컨테이너를 백그라운드에서 시작
docker container run -d 이미지이름 -mode=1

## docker image 검색
docker search --limit 5 mysql

## 이미지 정보 확인
docker image ls 
docker images

## 이미지 세부정보 확인
docker image inspect

# 확인
docker image pull httpd
docker image inspect httpd
docker image ispect --format="{{. Created}}" httpd

## 이미지를 구성하고 있는 레이어와 실행 정보 확인
docker image history 이미지이름

## docker 로그인 및 로그아웃
docker login
docker logout


## image 이름과 태그 생성
docker tag 기존이미지이름:버전 생성하는이미지이름:버전
docker tage 이미지ID 생서이미지이름:버전

## 이미지를 docker hub 에 업로드하는 경우 
# 본인의 docker hub 아이디를 앞에 붙여줌
docker image tad 이미지ID 내ID/생성이미지이름:버전

## 이미지 업로드
docker login -u 내ID
password : token 값 입력
docerk push 내ID/생서이미지이름:버전

## image 레이어 구조 복제
# image 파일을 tar 확장자로 저장
docker image save [옵션] image_이름 > 파일_경로
docker image load < 파일_경로

## 원본 이미지 삭제 
docker image rm 이미지이름
docker rmi 이미지이름

## 모든 이미지 저장
docker image save -o 파일명 $(dockr image ls -q)
