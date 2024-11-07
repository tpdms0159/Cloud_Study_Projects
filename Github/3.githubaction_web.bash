## Docker Private Registry 생성
## 1. hub.docker.com 이 아닌 registry 생성
# aws ec2에 접속해서 public IP 와 docker 설치 여부 확인
13.209.82.178

## 2. registry 라는 이미지를 이용해서 docker image registry를 생성
# 이미지 다운로드
sudo docker pull registry

# 컨테이너 실행
docker run -d -v /home/ubuntu/registry_data:/var/lib/registry -p 5000:5000 --restart=always --name=registry registry

## 3. 생성한 이미지 저장소를 사용하기 위한 설정
# /etc/docker/daemon.json 파일에 저장소를 추가
{
        "insecure-registries": ["13.209.82.178:5000"]
}

# /etc/init.d/docker 파일에 추가
DOCKER_OPTS=--insecure-registry 13.209.82.178:5000

# 도커 재시작
sudo service docker restart

# 새로 등록한 레지스트리의 이미지 확인
curl -XGET 13.209.82.178:5000/v2/_catalog

# nginx 이미지를 받아와서 tag를 변경하고 업로드
docker pull nginx
docker image tag nginx 13.209.82.178:5000/nginx
docker push 13.209.82.178:5000/nginx

# 카탈로그 다시 확인
curl -XGET 13.209.82.178:5000/v2/_catalog