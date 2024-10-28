##### 1번 가상머신
## 1. ifconfig 명령으로 NIC를 확인: 10.0.2.15 할당된 NIC를 찾습니다.
enp0s3

## 2. 네트워크 기능 중지
sudo systemctl stop NetworkManager

## 3. IP 할당
sudo ifconfig enp0s3 192.168.56.100

## 4. 네트워크 기능 활성화
sudo systemctl start NetworkManager

## 5. IP 확인
ifconfig

## 6. 호스트이름 변경
sudo hostnamectl set-hostname swarm-manager

cat /etc/hostname


##### 2번 가상머신
## 1. netplan을 이용해서 IP를 수정(기본적으로 dhcp가 설정되어 있음)
sudo nano /etc/netplan/00-installer-config.yaml

# 내용 작성
network:
ethernets:
  enp0s3:
	addresses: [192.168.56.101/24]
	routes:
to: default
via: 192.168.56.1
	nameservers:
	  address: [8.8.8.8]
	version: 2

## 2. 변경 내용 적용
sudo netplan apply

## 3. hostname 변경 & 재부팅
sudo hostnamectl set-hostname swarm-worker1
sudo reboot now

