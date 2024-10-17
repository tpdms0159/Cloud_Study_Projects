
# 1. py_flask 디렉터리 생성
mkdir py_flask
cd py_flask

# 동일
mkdir py_flask && cd py_flask

# 2. app 디렉터리 생성 후 py_app.py 파일 생성
mkdir app && nano app/py_app.py

# 3. py_app.py 파일에 작성
from flask import Flask

py_app = Flask(__name__)

@py_app.route('/')
def python_flask():
        return "<h1>Hello Flask</h1>"

if __name__ == "__main__":
        py_app.run(host="0.0.0.0", port=9000, debug=True)


# flask 설정을 위한 requirements.txt 파일 생성
/py_flask/app $ vi requirements.txt

Flask=1.1.0

/py_flask $ 

# 4. Dockerfile 생성 후 작성
FROM python:3.8-alpine

RUN apk update && apk add --no-cache bash

RUN apk add --update build-base python3-dev py-pip

ENV LIBRARY_PATH=lib:/usr/lib
ENV FLASK_APP=py_app
ENV FLASK_ENV=development

EXPOSE 9000

WORKDIR /py_app
COPY ./app/ .

RUN pip install -r requirements.txt

ENTRYPOINT ["python"]
CMD ["py_app.py"]


#########################################################
# python 은 가상환경 생성 필수 -> 안 만들면 모든 의존성을 가져오는 문제 발생
pip3 freeze > requirements.txt



