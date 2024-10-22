## Django python 프로젝트 생성시 필요한 터미널 명령어

# 가상환경 실행하기
python3 -m venv venv
source ./venv/bin/activate

# 프로젝트 생성 및 실행
pip3 install django
django-admin startproject project
cd project
python3 manage.py startapp app
python3 manage.py runserver 127.0.0.1:8000

# /admin 유저 생성
 (venv) (base) adam@ADAMui-MacBookPro mysite % python manage.py createsuperuser
u Username (leave blank to use 'adam'): adam u Email address: ggangpae1@gmail.com
u Password: ******
u Password (again): *****
u Bypass password validation and create user anyway? [y/N]: y u Superuser created successfully.

# 데이터베이스 연결
$ brew install mysql
$ brew install openssl
$ brew install pkg-config 
$ pip install mysqlclient
