## nginx 컨테이너 생성
## 이미지 다운로드
nginx:1.18
docker pull nginx:1.18

## 이미지 확인
docker images

## nginx를 외부에서 8001 번 포트로 접속할 수 있도록 컨테이너를 생성
docker run --name webserver -d -p 8001:80 nginx:1.18
## 확인
curl http://localhost:8001

## 리소스 사용량 확인: docker stats 컨테이너이름
docker run --name webserver -d -p 8001:80 nginx:1.18
docker stats webserver
# 종료하고자 하는 경우는 ctrl + z

# 브라우저나 다른 터미널에서 localhost:8001 에 접속해서 사용량을 확인
## 컨테이너 내부의 실행 중인 프로세스 확인: docker top 컨테이너이름
docker top webserver

## 컨테이너 내부의 로그 확인: docker logs -f(f는 실시간이고 t를 사용하면 마지막 로그 까지) 컨테이너이름
docker logs -f webserver
# 호스트 컴퓨터에서 컨테이너로 파일 복사: docker cp 호스트컴퓨터의파일경로 컨테이너이름:컨테이너내부파일경로

## nginx 의 첫 화면 파일을 확인
docker exec -it webserver /bin/bash
cat /usr/share/nginx/html/index.html

## 컨테이너 외부에서 index.html 파일을 작성
vi index.html
<h1>File Copy</h1>

## 컨테이너 외부에서 컨테이너 내부로 파일을 복사
docker cp index.html webserver:/usr/share/nginx/html/index.html 

# 웹 서버에 접속해보면 메인 화면이 변경된 것을 확인할 수 있음
# 설정 파일을 컨테이너의 쉘에서 직접 수정할 수 있는 경우도 있지만 그렇지 못하는 경우가 많기 때문에 외부에 설정 파일을 만든 후 docker cp 명령을 이용해서 복사해서 사용합니다.

## 컨테이너 일시 중지: docker pause 컨테이너이름
## pause 된 컨테이너 다시 시작: docker unpause 컨테이너이름
## 컨테이너 다시 시작: docker restart 컨테이너이름
