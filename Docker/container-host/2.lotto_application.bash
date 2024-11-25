## lotto 번호 뽑는 애플리케이션 host 에서 생성
## cotanier에 파일 복사후 실행 확인 
# 1. python 파일
from random import shuffle
from time import sleep

gamenum = input('로또 게임 회수를 입력하세요: ') 
for i in range(int(gamenum)):
    balls = [x+1 for x in range(45)]
    ret = []
    for j in range(6):
        shuffle(balls)
        number = balls.pop() 
        ret.append(number) 
    ret.sort()
print('로또번호[%d]: ' %(i+1), end='') 
print(ret)
sleep(1)

# 2. 컨테이너 생성 
docker run -it -d --name=lotto_test -p 8900:8900 python

# 3. 파일 복사
docker cp lotto.py lotto_test:/

# 4.컨테이너 접속해서 확인
docker exec -it lotto_test bash
python lotto.py
exit()
# 외부에서 파이썬 컨테이너 코드 실행
docker exec -it lotto_test python /lotto.py


