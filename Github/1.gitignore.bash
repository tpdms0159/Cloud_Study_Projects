## 하나의 디렉토리를 만들고 git init 수행
## 1. 파일을 생성
# file1.txt, file2.txt, folder/file3.txt

$ touch file1.txt
$ touch file2.txt
$ mkdir folder
$ touch folder/file3.txt

# 2. .gitignore 파일을 추가하고 작성
file1.txt

# 확인: file1.txt는 추적하지 않음
git status

# 디렉토리를 설정하면 디렉토리 안의 모든 내용을 추적하지 않음

## 3. .gitignore 파일에 추가
# folder/

# 확인: folder 안의 내용은 추적하지 않음
git status
# 확장자 패턴 가능

## 4. .gitignore 파일 수정
*.txt

## 5. 확인: 확장자가 txt 인 파일은 추적하지 않음
git status
