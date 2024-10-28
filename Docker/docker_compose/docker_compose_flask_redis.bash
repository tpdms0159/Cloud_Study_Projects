## 디렉토리 생성 및 프롬프트 이동
mkdir flask_redis && cd $_

## 파이썬 파일을 생성하고 작성(app 디렉토리를 생성하고 그 안에 py_app.py)
$ mkdir app
$ nano py_app.py

import time
import redis
from flask import Flask

py_app = Flask(__name__)
db_cache = redis.Redis(host='redis', port=6379)

def web_hit_cnt():
        return db_cache.incr('hits')

@py_app.route('/')
def python_flask():
        cnt = web_hit_cnt()

        return  '''<h1 style="text-align:center; color:deepskyblue;">docker-compose app:
Flask & Redis</h1>
<p style="text-align:center; color:deepskyblue;">Good Container Service</p>
<p style="text-align:center; color:red;">Web access count : {} times</p>'''.format(cnt)

if __name__ == '__main__':
        py_app.run(host='0.0.0.0', port=9000, debug=True)



