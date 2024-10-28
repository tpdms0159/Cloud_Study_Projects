## 1. linux -> git 에서 다운로드 받기
sudo curl -L "https://github.com/docker/compose/releases/download/v2.5.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

## 2. 실행 권한 부여
sudo chmod +x /usr/local/bin/docker-compose

## 3. 심볼릭 링크 부여, PATH 설정도 가능 
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# PATH 설정
nano ~/.bashrc

export PATH=$PATH:/usr/bin/docker-compose

## 4. 버전 확인
docker --version

