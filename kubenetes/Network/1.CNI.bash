## 클러스터 파드 내부에서 실행되는 CoreDNS 컨테이너를 가리키는 NodePort 서비스 생성
## 1. yml 파일 생성: my-nodeport.yml
apiVersion: v1

kind: Service

metadata:
  annotations:
    prometheus.io/port: "9153"
    prometheus.io/scrape: "true"
  labels:
    k8s-app: kube-dns
    kubernetes.io/cluster-service: "true"
    kubernetes.io/name: CoreDNS
  name: kube-dns-2
  namespace: kube-system
spec:
  ipFamilies:
  - IPv4
  ipFamilyPolicy: SingleStack
  ports:
  - name: dns
    port: 53
    protocol: UDP
    targetPort: 53
  - name: dns-tcp
    port: 53
    protocol: TCP
    targetPort: 53

  selector:
    k8s-app: kube-dns

  sessionAffinity: None
  type: NodePort


## 2. 서비스 생성
kubectl apply -f my-nodeport.yml

## 3. 서비스 확인
kubectl get svc


