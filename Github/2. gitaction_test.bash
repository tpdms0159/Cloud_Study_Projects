## node.js 로 만든 애플리케이션을 테스트하는 과정을 git hub action으로 구현
## 1. git hub 사이트에서 레포지토리 생성

## 2. nodejs프로젝트 생성
# 빈 디렉토리를 생성
# npm init 을 입력하고 옵션을 설정

## 3. 필요한 패키지 설치
npm install express
npm install --save-dev nodemon

## 4. node 플랫폼의 모든 프로젝트는 package.json에 설정을 하는데 이 파일을 수정
"main": "app.js",
  "scripts": {
    "test": "test mocha",
    "start": "nodemon app"
  },




## 5. app.js 파일을 추가하고 작성
const express = require('express')

const app = express()

app.set('port', process.env.PORT || 3000)

app.get('/', (req, res) => {
    res.send('Hello Express');
})

app.listen(app.get('port'), () => {
    console.log(app.get('port'), '번 포트에서 대기 중')
})

# 실행
npm start
브라우저에서 localhost:3000 번으로 접속

## 6. git hub에 push

# .gitignore 파일을 생성하고 작성
node_modules/

push
git init
git add .
git commit -m "nodejs"
git remote add origin https://github.com/itggangpae/gitaction.git
git checkout -b main
git push origin main

## 7. 테스트 수행
# 테스트를 위한 라이브러리를 설치
npm install mocha

# 테스트를 위한 파일을 생성하고 작성
#test.spec.js
describe('Default Test Set', () => {
    it('test1 should be passed', () =>{
        console.log('test1 passed');
    })

    it('test2 should be passed', () =>{
        console.log('test2 passed')
    })
})

# 테스트 수행
./node_modules/.bin/mocha test.spec.js


# test 명령을 package.json에 등록: npm test 라는 명령어로 테스트를 수행
"scripts": {
    "start": "nodemon app",
    "test": "./node_modules/.bin/mocha test.spec.js"
  },


## 8. Git Hub Action 작성: main 브랜치가 push 될 때 테스트를 수행
# 프로젝트에 .github/workflows 디렉토리를 생성
# .github/workflows 디렉토리에 yaml 파일을 생성하고 작성: ci.yaml

name: Node Git Action

on:
  push:
    branches: [main]

jobs:
  build:
    runs-on: ubuntu-latest

    strategy:
      matrix:
        node-version: [20.x]

    steps:
    - uses: actions/checkout@v3

    - name: Use Node.js ${{ matrix.node-version}}
      uses: actions/setup-node@v3
      with:
        node-version: ${{ matrix.node-version}}
    - run: npm install
    - run: npm test

# 작성한 코드를 push 하고 git hub 페이지에서 action을 확인
