## Daemon set

## 1.  daemonset.yml 파일로 daemon set 생성
nano daemonset.yml

apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: prometheus-daemonset
spec:
  selector:
    matchLabels:
      tier: monitoring #user define lable
      name: promethous-exporter
  template:
    metadata:
      labels:
        tier: monitoring
        name: promethous-exporter
    spec:
      containers:
      - name: promethous  
        image: prom/node-exporter
        ports:
        -  containerPort: 80


