## container 와 host 의 연결
## 파일 복사 
docker cp 호스트경로 컨테이너이름:컨테이너경로


## apache 컨테이너 생성 및 실행 
docker run --name apa000ex19 -d -p 8089:80 httpd

## 해당 컨테이너 -> 호스트로 파일 복사 
docker cp apa000ex19:/usr/local/apache2/htdocs/index.html index.html

## 파일 수정 후 호스트 -> 컨테이너로 파일 복사
docker cp index.html apa000ex19:/usr/local/apache2/htdocs/index.html