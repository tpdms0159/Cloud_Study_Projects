## 1.
cronjob.yml 파일을 생성하고 작성
apiVersion: batch/v1  #Job의 경우 apiVersion이 batch/v1
kind: CronJob
metadata:
  name: hi

spec:
  schedule: "*/1 * * * *"  #Linux의 Crontab 설정 과 동일(명령문이 빠짐)
  jobTemplate:		#Pod를 생성하는 경우는 template
    spec:
      template:
        spec:
          containers:
          - name: hi
            image: busybox #minimun linux
            imagePullPolicy: IfNotPresent #이미지가 존재하는 경우 어떻게 할 것인지 설정: 이 경우는 없을 때만 Pull
            command: #수행할 명령문 작성
            - /bin/sh
            - -c
            - date; echo Hi
          restartPolicy: OnFailure #재시작 옵션 - 실패할 때에만 다시 시작

## 2. 크론잡 확인
kubectl get cronjob hi
NAME   SCHEDULE      TIMEZONE   SUSPEND   ACTIVE   LAST SCHEDULE   AGE
hi     */1 * * * *   <none>     False     3        50s             3m27s

## 3. 크론잡의 수행을 실시간으로 감시
kubectl get cronjob -w

## 4. 크론잡의 수행 시 만들어지는 pod를 확인
kubectl get pod -w

