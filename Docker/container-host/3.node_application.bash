# 노드 실행 파일을 host 디렉터리에 만들고 작성 - index.js
let http = require('http');
let content = function(req, resp) {
    resp.end("Good morning Adam ~! -Jessica-" +"\n");
    resp.writeHead(200); 
    }
let web = http.createServer(content); 
web.listen(8000);

# 노드 이미지 다운로드 
docker pull node
# 노드 컨테이너 실행 
docker run -dit -p 9000:8000 --name=node_test node
# 파일 복사후 외부에서 실행
docker cp index.js node_test:/index.js
docker exec -it node_test node /index.js
# 브라우저 확인 


## container 를 이미지로 생성 
docker commit -a '커밋내용' node_test 이미지이름
docker images
docker login -u 도커아이디
docker tag 위의이미지이름 도커아이디/이미지이름:태그 
docker push 도커아이디/이미지이름:태그
    