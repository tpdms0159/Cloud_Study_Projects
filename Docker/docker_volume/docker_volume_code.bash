# nginx container -> /var/log/nginx 연결해서 로그 확인하기
tail -f niginx-log/access.log

# linux 의 awk - 줄단위 전체 출력
awk {print} nginx-log/access.log
awk '{print $1}' nginx-log/access.log