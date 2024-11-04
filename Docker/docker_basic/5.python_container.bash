## 파이썬 파일을 도커 컨테이너로 실행할 수 있도록 생성
## 1. 파이썬 파일 작성(py_lotto.py)
from random import shuffle
from time import sleep

gamenum = input('How many times?')

for i in range(int(gamenum)):
        balls = [x+1 for x in range(45)]
        ret = []
        for j in range(6):
                shuffle(balls)
                number = balls.pop()
                ret.append(number)
        ret.sort()
        print('lotto number[%d]:' %(i+1), end=' ')
        print(ret)
        sleep(1)

## 2. 파일을 실행해서 에러가 없는 것을 확인
 python3 py_lotto.py

## 3. python 컨테이너 실행
docker run --name=python_test -dit -p 8900:8900 python

## 4. 소스 파일을 컨테이너로 복사
docker cp py_lotto.py python_test:/


## 5. 도커 외부에서 실행
docker exec -it python_test python /py_lotto.py

## 6. nodejs 애플리케이션을 도커 컨테이너로 실행
# nodejs의 이미지 이름은 node
# nodejs에서 web 서버를 만드는 경우 포트는 직접 지정해야 합니다.

# nodejs로 웹 서버를 만드는 코드를 작성: nodejs_test.js
let http =  require('http')
let content = function(req, res){
        res.end('Go for it Korea~!!!')
        res.writeHead(200)
}
let web =  http.createServer(content)
web.listen(8002)

# 8002 번 포트를 외부에서 접속할 수 있도록 node 컨테이너를 생성
docker run -dit --name=nodejs_test -p 8002:8002 node

# 소스 코드를 컨테이너에 복사
docker cp nodejs_test.js nodejs_test:/nodejs_test.js

# 실행 명령어 수행
docker exec -it nodejs_test node /nodejs_test.js

## 7. 컨테이너를 이미지로 만들기
# 명령 형식
docker commit 컨테이너이름 이미지이름

# -a 옵션을 이용해서 작성자를 추가해주기도 합니다.
# 도커 허브에 있는 이미지를 다운로드 받아서 소스 코드를 추가하고 만든 이미지를 골든이미지라고 합니다.
# nginx에 welcome file을 변경한 이미지를 만들어서 업로드하고 다운로드해서 테스트

# welcome file을 생성(index.html)
<h1>Welcome My Web Site!!!</h1>

# nginx의 최신 버전으로 컨테이너 실행 - 용도는 웹서버, 기본 포트번호는 80
docker run --name=website -dit -p 8008:80 nginx

# 로컬의 파일을 컨테이너로 복사
docker cp index.html website:/usr/share/nginx/html/index.html

# 확인
curl http://localhost:8008

# 컨테이너를 이미지로 생성
docker commit -a adam website website:1.0

# 이미지를 업로드 하기 위해서 태그 작업 수행
docker tag website:1.0 ggnagpae1/website:1.0

# 이미지 업로드
docker push ggnagpae1/website:1.0