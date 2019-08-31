!/bin/bash
##	source
source env.sh

##########################################################################
##	system
##########################################################################
# 主机更名
hostnamectl --static set-hostname node1

##########################################################################
##	flannel
##########################################################################
# 
yum install flannel -y

# 配置内网
# FLANNEL_ETCD_ENDPOINTS="http://etcd:2379" 
# FLANNEL_ETCD_PREFIX="/flannel/network" 
# PS：其中flannel与上面etcd中的Network对应
#
sed -i 's/127.0.0.1/etcd/' /etc/sysconfig/flanneld
sed -i 's/atomic.io/flannel/' /etc/sysconfig/flanneld

##########################################################################
##	node
##########################################################################
# 
yum install kubernetes-node -y
#
systemctl enable kubelet kube-proxy
# 全局配置
# KUBE_MASTER="--master=http://master:8080"
#
sed -i 's/127.0.0.1/master/' /etc/kubernetes/config
#
# 配置kubelet
# KUBELET_ADDRESS="--address=0.0.0.0"
# KUBELET_HOSTNAME="--hostname-override=node1" 
# KUBELET_API_SERVER="--api-servers=http://master:8080"
# KUBELET_POD_INFRA_CONTAINER="--pod-infra-container-image=192.168.1.3:5000/pod-infrastructure:latest"
#
sed -i 's/address=127.0.0.1/address=0.0.0.0/' /etc/kubernetes/kubelet
sed -i 's/override=127.0.0.1/override=node1/' /etc/kubernetes/kubelet
sed -i 's/127.0.0.1/master/' /etc/kubernetes/kubelet
sed -i 's/127.0.0.1/master/' /etc/kubernetes/kubelet
# registry.access.redhat.com/rhel7/pod-infrastructure:latest
# 可选
# --registry-mirrors=https://bmmsq0wm.mirror.aliyuncs.com
# --insecure-registries=192.168.1.3:5000
# --pod-infra-container-image=192.168.1.3:5000/pod-infrastructure:latest
# 
sed -i 's/registry.access.redhat.com\/rhel7/192.168.1.3:5000/' /etc/kubernetes/kubelet
#
systemctl start kubelet kube-proxy
# 
# 外网无法访问nodePort问题
iptables -P FORWARD ACCEPT
# Ques
# https://blog.csdn.net/qa1986nibuhao/article/details/80770951
# https://blog.csdn.net/qq_30852577/article/details/79443322