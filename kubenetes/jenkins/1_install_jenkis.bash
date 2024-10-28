## 
sudo apt update
sudo apt install -y openjdk-17-jre-headless

## 리눅스에 설치하려는 패키지가 기본 repository 에 없는 경우
## add-apt-repository 명령어를 이용해 추가 가능
## 해당 명령어를 사용하기 위해 설치하려는 소프트웨어 대한 접슨 권한을 부여
## GPG :: 디지털 암호화 및 서명 서비스를 제공하는 OpenPGP 로 위와 유사한 역을 수행
## 특정 소프트웨어들은 패키지에 접근하기 위해 GPG 키를 추가하기를 권장함
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo gpg --dearmor -o /usr/share/keyrings/jenkins.gpg

