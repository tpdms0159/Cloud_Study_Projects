## debian 과 https 의 최신 버전을 다운로드
docker pull debian
docker pull httpd:latest

## 이미지 저장소 확인(관리자 모드에서만 가능)
sudo su -
/var/lib/docker/image/overlay2/layerdb/sha256
ls

## httpd 의 레이어 확인
docker image inspect --format="{{ .RootFS.Layers }}" httpd

## 레이어 안으로 이동
cd 8d853c8add5d1e7b0aafc4b68a3d9fb8e7a0da27970c2acf831fe63be4a0cd2c

## 레이어 내부 확인
ls
cache-id  diff  size  tar-split.json.gz

## cache-id 확인
cat cache-id

## 태그 추가하기
$ docker image tag 5daf6a4bfe74 debian-httpd:1.0
$ docker image tag httpd:latest debian-httpd:2.0
$ docker images

## 이미지 저장
docker image save 이미지이름 > 파일명
## 읽기
docker image load < 파일명
## mysql:5.7 다운로드(M1의 경우 다운로드가 안될 수 있는데 이 경우는 --platform linux/amd64 나 arm64를 이미지 이름 앞에 추가해주어야 합니다.)
docker pull mysql:5.7

## 다운로드 받은 mysql:5.7을 test-mysql57.tar로 저장
docker image save mysql:5.7 > test-mysql57.tar

## 압축된 파일 확인
tar tvf test-mysql57.tar

## 이미지를 불러오기 위해서 기존 이미지를 삭제
docker image rm mysql:5.7

## 이미지 확인
docker images

## 이미지 불러오기
docker image load < test-mysql57.tar

## 이미지 확인
docker images

## 이름을 변경해서 불러올 때는 docker import 를 사용
cat test-mysql57.tar | docker import - mysql57:1.0

## 용량을 줄이고자 하면 gzip 옵션을 이용
docker image save mysql:5.7 | gzip > test-mysql57gzip.tar.gz

## 스크립트 변수 방식을 이용해서 도커의 전체 이미지를 하나로 묶는 것도 가능(docker image ls -q 명령은 이미지의 ID를 전부 출력)
docker image save -o all_image.tar $(docker image ls -q)
