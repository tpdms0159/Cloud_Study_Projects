## 애플리케이션 생성 및 실행
## 1. 가상환경 생성 후 -> apiserver 프로젝트 생성하기
sudo apt install python3.10-venv
python3 -m venv myenv
source myvenv/bin/activate

mkdir cicd
pip3 install django djangorestframework
django-admin startproject apiserver
cd apiserver
python manage.py runserver

## 2. settings.py 파일 수정

#어떤 컴퓨터에서 실행될 것인지를 설정
#*이면 아무 컴퓨터에서나 실행이되고 아이피를 직접 설정하면 그 아이피에서만 실행이 됩니다.
ALLOWED_HOSTS = ['*']
#사용할 Application 등록
INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'apiserver',
    'rest_framework'
]

#사용할 시간대 설정
TIME_ZONE = 'Asia/Seoul'
 
## 3. 브라우저에서 확인
http://localhost:8000

## 4. 사용자의 요청을 처리할 views.py 파일을 apiserver 디렉토리 내부에 생성하고 작성
from rest_framework.response import Response
from rest_framework.decorators import api_view
from rest_framework import status

@api_view(['GET'])
def index(request):
    data = {"result":"success", "data":[{"id":"itstudy", "name":"adam"}]}
    return Response(data, status=status.HTTP_200_OK)

## 5. urls.py 파일을 수정해서 요청과 요청 처리 함수를 연결
from django.contrib import admin
from django.urls import path
from .views import index

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', index)
]

## 6. 실행
python manage.py runserver 0.0.0.0:8000

## 7. Dockerfile 을 생성해서 이미지 생성, 컨테이너 생성
# Dockerfile 에 생성 /apiserver

# 1. Python 3.8 슬림 이미지를 사용
FROM python:3.8-slim-buster AS build
# 2. 시스템 패키지 업데이트 및 curl 설치
RUN apt-get update && apt-get install -y --no-install-recommends gcc curl libffi-dev python3-dev && rm -rf >
# 3. 작업 디렉토리 설정
WORKDIR /usr/src/app
# 4. requirements.txt 파일 복사
COPY requirements.txt ./
# 5. pip 업그레이드 및 패키지 설치
RUN pip3 install --upgrade pip && pip3 install django djangorestframework
# 6. 애플리케이션 소스 코드 복사
COPY . .
# 7. 포트 노출
EXPOSE 80
# 8. 서버 실행
CMD ["python", "manage.py", "runserver", "0.0.0.0:80"]

## 8. requirements.txt 파일 생성
cp freeze > requirements.txt /apiserver

## 8. 이미지 빌드 후 컨테이너 생성 
docker build -t apiserver .
docker run -d -p 80:80 --name apiserver apiserver

