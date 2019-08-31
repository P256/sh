!/bin/bash
##	source
source env.sh

##########################################################################
##	system
##########################################################################
# 主机更名
hostnamectl --static set-hostname master

# 转发参数
cat <<EOF > /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
vm.swappiness=0
EOF

# 配置生效
sysctl -p

##########################################################################
##	etcd
##########################################################################
# 
yum install etcd -y
#
systemctl enable etcd
# 配置etcd属性
# ETCD_LISTEN_CLIENT_URLS="http://0.0.0.0:2379" 
# ETCD_ADVERTISE_CLIENT_URLS="http://etcd:2379"
#
sed -i 's/localhost/etcd/' /etc/etcd/etcd.conf
#
systemctl start etcd

# 内网信息
etcdctl -C http://etcd:2379 set /flannel/network/config '{"Network":"172.17.0.0/16"}'

##########################################################################
##	master
##########################################################################
# 
yum install kubernetes-master -y
#
systemctl enable kube-apiserver kube-scheduler kube-controller-manager
# 配置apiserver属性
# KUBE_API_ADDRESS="--insecure-bind-address=0.0.0.0" 
# KUBE_ETCD_SERVERS="--etcd-servers=http://etcd:2379"
# KUBE_SERVICE_ADDRESSES="--service-cluster-ip-range=172.17.0.0/16"
# KUBE_ADMISSION_CONTROL="--admission-control=NamespaceLifecycle,NamespaceExists,LimitRanger,ResourceQuota" 
# PS：测试时需要把KUBE_ADMISSION_CONTROL中的SecurityContextDeny和ServiceAccount去掉，这是权限相关的
# 
sed -i 's/127.0.0.1:/etcd:/' /etc/kubernetes/apiserver
sed -i 's/127.0.0.1/0.0.0.0/' /etc/kubernetes/apiserver
sed -i 's/10.254.0.0/172.17.0.0/' /etc/kubernetes/apiserver
# 全局配置
# KUBE_MASTER="--master=http://master:8080"
sed -i 's/127.0.0.1/master/' /etc/kubernetes/config
#
systemctl start kube-apiserver kube-scheduler kube-controller-manager

##########################################################################
##	test
##########################################################################
# 节点
kubectl get nodes
# 配置pod
cat <<EOF > nginx-pod.yaml
apiVersion: v1
kind: Pod
metadata:
 name: nginx-pod
 labels:
  name: nginx-pod
spec:
 containers:
 - name: nginx
   image: nginx
   ports:
   - containerPort: 80
EOF
# 创建pod
kubectl create -f nginx-pod.yaml
# 查看pod
kubectl get pods
# 
kubectl describe pod nginx-pod
#
# 配置rc
cat <<EOF > nginx-rc.yaml
apiVersion: v1
kind: ReplicationController
metadata:
 name: nginx-rc
spec:
 replicas: 1
 selector:
  name: nginx-pod
 template:
  metadata:
   labels:
    name: nginx-pod
  spec:
   containers:
   - name: nginx-pod
     image: nginx
     ports:
     - containerPort: 80
EOF
# 创建rc
kubectl create -f nginx-rc.yaml
# 查看rc
kubectl get rc
# 
kubectl describe rc nginx-rc
# 配置service
cat <<EOF > nginx-service.yaml
apiVersion: v1
kind: Service
metadata:
 name: nginx-service
spec:
 type: NodePort
 ports:
 - port: 80
   nodePort: 30001
 selector:
  name: nginx-pod
EOF
# 创建service
kubectl create -f nginx-service.yaml
# 查看service
kubectl get service
# 
kubectl describe service nginx-service
#
# ss -tlnp | grep 30001