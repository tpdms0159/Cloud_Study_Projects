## linux 에 docker 설치하기
sudo apt-get upate

## 필요한 패키지 설치
sudo apt install apt-transport-https ca-certificates curl software-properties-common

## docker 에서 제공하는 공식 GPG 키 추가
curl -fsSL https://download.docker.com/linux/ubuntu/gpg
sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

## docker repository 추가
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io
## docker group 에 현재 사용자 등록
sudo usermod -aG docker $USER