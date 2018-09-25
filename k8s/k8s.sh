# 
# https://kubernetes.io/docs/setup/release/notes/
#
https://dl.k8s.io/v1.11.0/kubernetes.tar.gz
https://dl.k8s.io/v1.11.0/kubernetes-src.tar.gz
# Binaries
https://dl.k8s.io/v1.11.0/kubernetes-server-linux-amd64.tar.gz
#
# yum源方式
yum install etcd kubernetes

# 启动所有服务
systemctl start etcd
systemctl start docker 
systemctl start kube-apiserver
systemctl start kube-controller-manager
systemctl start kube-scheduler
systemctl start kubelet
systemctl start kube-proxy

#https://cloud.tencent.com/developer/article/1138668
#https://kubernetes.io/docs/setup/independent/install-kubeadm/
#yum install kubelet kubeadm kubectl --disableexcludes=kubernetes

#https://www.cnblogs.com/Leo_wl/p/8511902.html
# 
setenforce 0
yum install kubelet kubeadm kubectl --disableexcludes=kubernetes
systemctl start kubelet
systemctl enable kubelet

# 不写version就会装最新的1.10
kubeadm init --kubernetes-version=v1.9.0 --pod-network-cidr=10.244.0.0/16

kubeadm init --pod-network-cidr=192.168.1.102/16


Master 管理节点包含组件：
	docker
	etcd
	kube-apiserver
	kube-controller-manager
	kubelet
	kube-scheduler
Minion 工作节点包含组件：
	docker
	kubelet
	kube-proxy