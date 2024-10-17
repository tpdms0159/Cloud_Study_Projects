# 다단계 빌드
## 1. goapp 디렉터리 생성
mkdir goapp
cd goapp

## 2. go 파일 생성 후 작성
# goapp.go 파일 생성
package main

import(
    "fmt"
    "time"
)

func main() {
for{
    fmt.Println("Hello World")
    time.Sleep(10 * time.Second)
    }
}

## 3. go 설치 - 압축해제 - PATH 등록
# PATH 등록 : 명령어 또는 파일을 아무곳에서 사용하기 위해서 등록
wget https://golang.org/dl/go1.19.1.linux-arm64.tar.gz # aarch64 아키텍쳐
sudo tar -xzf go1.19.1.linux-arm64.tar.gz -C /usr/local/

sudo nano /etc/profile

ls /usr/local/go/bin/go
export PATH=$PATH:/usr/local/go/bin

source etc/profile
go version

## 4. Dockerfile 생성해서 작성
FROM golang:1.15-alpine3.12 AS gobuilder-stage

WORKDIR /usr/src/goapp

COPY goapp.go .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /usr/local/bin/gostart

FROM scratch AS runtime-stage

COPY --from=gobuilder-stage /usr/local/bin/gostart /usr/local/bin/gostart

CMD ["/usr/local/bin/gostart"]

## 5. Dockerfile 빌드
docker build -t goapp:1.0 .

## 6. 이미지 확인
docker images

## 7. 컨테이너로 실행
docker run --name goapp-deploy goapp:1.0
