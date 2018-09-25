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
