## 1. 시스템 업데이트
sudo apt-get update

## 2. docker 설치 시 필요한 패키지 설치
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

## 3. Docker의 공식 GPG 키 추가
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

## 4. Docker 리포지토리 추가:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

## 5. 시스템 업데이트
sudo apt-get update

## 6. Docker 설치
sudo apt-get install docker-ce docker-ce-cli containerd.io

## 7. Docker 시작 후 확인
sudo systemctl start docker
sudo systemctl enable docker

## 8. 현재 사용자에 docekr 권한 부여
sudo usermod -aG docker $USER
newgrp docker
