### 参考
https://kubernetes.io/docs/
https://www.cnblogs.com/zhenyuyaodidiao/p/6500830.html
https://cloud.tencent.com/developer/article/1138668
https://www.cnblogs.com/kevingrace/p/5575666.html
https://www.cnblogs.com/Cherry-Linux/p/7866427.html
http://www.cnblogs.com/fuyuteng/p/9460534.html

### 安装包
# source
# https://dl.k8s.io/v1.11.0/kubernetes.tar.gz
# https://dl.k8s.io/v1.11.0/kubernetes-src.tar.gz
# Binaries
# https://dl.k8s.io/v1.11.0/kubernetes-server-linux-amd64.tar.gz

### 环境配置
| 服务器    	|  					服务  						|
| master    |   apiserver,controller-manager,scheduler 		|
| node      |   flannel,docker,kubelet,kube-proxy    		|
| etcd      |   etcd    									|

### 组件部分

1.kubectl 					集群通信：命令行（作为整个系统的操作入口 => 发送给kube-apiserver）

2.kube-apiserver 			集群通信：API服务（作为整个系统的控制入口 => 以REST API服务提供接口）
	
3.kube-controller-manager 	集群通信：系统后台（管理节点状态、Pods、Service的关联等）

4.kube-scheduler   			集群节点：资源管理（接受来自 kube-apiserver => 创建Pods => 分配节点）

5.etcd  					集群数据：服务发现、配置共享

6.kube-proxy  				集群节点：代理策略（计算节点上 Pod 网络代理 定时 从 etcd 获取到 service 信息来做相应的策略）

7.kubelet 					集群节点：运行在每个计算节点上	作为agent 接受分配 该节点的 Pods 任务及管理容器周期性 获取 容器状态 => kube-apiserver

8.DNS  						可选的DNS服务（用于为每个Service对象创建DNS记录 这样所有的Pod就可以通过DNS访问服务了）



#### 设置hosts
> cat >>/etc/hosts<<EOF
192.168.1.10 master
192.168.1.10 etcd
192.168.1.11 node1
EOF

#### 检查环境
> cat /etc/redhat-release

#### 检查内核
> uname -r

#### 主机更名
> hostnamectl --static set-hostname k8s

#### IP地址
> ip link


#### 临时关闭 SELinux
> setenforce 0
## 永久关闭 SELinux
> sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config

#### Swap (永久禁掉： vi /etc/fstab 注释掉swap那一行)
> swapoff -a

#### 配置转发参数
> cat <<EOF > /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
vm.swappiness=0
EOF

#### 生效
> sysctl --system
> sysctl -p

#### 关闭防火墙
systemctl stop firewalld
systemctl disable firewalld

#### 重启
> reboot

-----------------------------------------------------------------------------------

# 3.YUM安装方式

## 配置YUM源
> cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes Repository
baseurl=http://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=0
EOF

## etcd
> yum install etcd
> systemctl enable etcd
> systemctl start etcd

## network
etcdctl -C http://etcd:2379 set /flannel/network/config '{"Network":"172.17.0.0/16"}'


## master
> yum install kubernetes-master
> systemctl enable kube-apiserver kube-scheduler kube-controller-manager
> systemctl start kube-apiserver kube-scheduler kube-controller-manager


## node
> yum install kubernetes-node
> systemctl enable kubelet kube-proxy
> systemctl start kubelet kube-proxy















