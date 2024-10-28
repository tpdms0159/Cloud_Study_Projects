## 디렉터리 생성하기
sudo mkdir /home/namespace
sudo mkdir /home/namespace/box

sudo mkdir /home/namespace/box/bin
## sh 파일을 만들어서 복사
sudo mkdir /home/namespace/box/bin
sudo mkdir /home/namespace/box/lib
sudo mkdir /home/namespace/box/lib64
sudo mkdir /home/namespace/box/usr

sudo cp -r /lib/* /home/namespace/box/lib
sudo cp -r /lib64/* /home/namespace/box/lib64
sudo cp -r /usr/* /home/namespace/box/usr


sudo mkdir /home/namespace/box/proc
sudo mount -t proc proc /home/namespace/box/proc

sudo chroot /home/namespace/box /bin/bash

## sh 파일에 실행권한 부여
sudo chmod +x 파일경로