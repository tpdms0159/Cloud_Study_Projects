# 가상환경 생성 후 -> apiserver 프로젝트 생성하기
sudo apt install python3.10-venv
python3 -m venv myenv
source myvenv/bin/activate

mkdir cicd
pip3 install django djangorestframework
django-admin startproject apiserver
cd apiserver
python manage.py runserver


