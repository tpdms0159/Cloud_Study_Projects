# Django Application을 이미지로 만드는 Dockerfile을 작성하고 그 내용을 전송하시오.
FROM --platform=linux/arm64 python:3.8-slim-buster as build
RUN apt-get update && apt-get install -y --no-install-recommends && rm -rf /var/lib/apt//lists/*
WORKDIR /usr/src/app
COPY requirements.txt ./
RUN pip install -r requirements.txt
COPY . .
EXPOSE 80
CMD ["python", "manage.py", "runserver", "0.0.0.0:80"]


# github action을 이용해서 위의 이미지를 자동으로 빌드해서 업로드하는 yaml 파일을 작성해서 내용을 전송하시오

name: Django
on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main

jobs:
  build:
    # 최신 Ubuntu 이미지에서 작업 실행
    runs-on: ubuntu-latest

    steps:
      # 1. GitHub 리포지토리에서 코드 체크아웃
      - name: Checkout code
        uses: actions/checkout@v3

      # 2. Python 3.10 설정 (Django 프로젝트가 Python을 사용하는 경우)
      - name: Set up Python 3.10
        uses: actions/setup-python@v4
        with:
          python-version: '3.10'

      # 3. 종속성 설치 (requirements.txt가 있는 경우)
      - name: Install dependencies
        run: |
          python -m pip install --upgrade pip
          pip install -r requirements.txt

      # 4. Docker Hub에 로그인 (임의로 설정한 Secret 변수 사용)
      - name: Log in to Docker Hub
        uses: docker/login-action@v2
        with:
          username: ${{ secrets.DOCKER_USER }}    # Docker Hub 사용자 이름
          password: ${{ secrets.DOCKER_PASS }}    # Docker Hub 비밀번호

      # 5. Docker 이미지 빌드 및 푸시 (Docker Hub로 업로드)
      - name: Build and push Docker image
        env:
          IMAGE_NAME: ${{ secrets.DOCKER_REPO }}  # Docker Hub 레포지토리 이름
          USERNAME: ${{ secrets.DOCKER_USER }}    # Docker Hub 사용자 이름
        run: |
          # Docker 이미지 빌드
          docker build -t $IMAGE_NAME .

          # 태그 설정
          docker tag $IMAGE_NAME:latest $USERNAME/$IMAGE_NAME:latest

          # Docker Hub에 이미지 푸시
          docker push $USERNAME/$IMAGE_NAME:latest

name: django
on:
  push:
	branches: [ "main" ]
  pull_request:
	branches: [ "main" ]
jobs:
  build:
	runs-on: ubuntu-latest
        	
	steps:
  	- name: Checkout
    	uses: actions/checkout@v3
          	
  	- name: Set up Python 3.10
    	uses: actions/setup-python@v4
    	with:
      	python-version: '3.10'
          	
  	- name: Install dependencies
    	run: |
        	python -m pip install --upgrade pip
        	pip install -r requirements.txt
                  
      - name: Login to DockerHub
    	uses: docker/login-action@v1
    	with:
      	username: ${{secrets.DOCKERHUB_USERNAME}}
      	password: ${{secrets.DOCKERHUB_TOKEN}}
            	
  	- name: build and release to DockerHub
    	env:
      	NAME: ${{secrets.DOCKERHUB_USERNAME}}
      	REPO: ${{secrets.DOCKERHUB_REPO}}
    	run: |
      	docker build -t $REPO .
      	docker tag $REPO:latest $NAME/$REPO:latest
      	docker push $NAME/$REPO:latest

# DOCKER HUB의 username, password, repository는 모두 secret variable로 할당하는데 변수 이름은 임의로 할당하시오 
- name: Login to DockerHub
  uses: docker/login-action@v1
  with:
    username: ${{ secrets.DOCKER_USER }}   # 임의로 설정한 변수명
    password: ${{ secrets.DOCKER_PASS }}   # 임의로 설정한 변수명

- name: Build and release to DockerHub
  env:
    NAME: ${{ secrets.DOCKER_USER }}       # 임의로 설정한 변수명
    REPO: ${{ secrets.DOCKER_REPO }}       # 임의로 설정한 변수명
